require 'net/http'
require 'nokogiri'

class ProxyController < ApplicationController
  def fetch
    url = params[:url]
    if url.present?
      uri = URI.parse(url)
      response = Net::HTTP.get_response(uri)

      if response.is_a?(Net::HTTPSuccess)
        html = Nokogiri::HTML(response.body)
        gif_url = html.at_css('meta[property="og:image"]')&.[]('content')

        if gif_url
          gif_uri = URI.parse(gif_url)
          gif_response = Net::HTTP.get_response(gif_uri)

          if gif_response.is_a?(Net::HTTPSuccess)
            send_data gif_response.body, type: gif_response.content_type, disposition: 'inline'
          else
            render plain: "Failed to fetch GIF", status: :bad_request
          end
        else
          render plain: "GIF URL not found", status: :bad_request
        end
      else
        render plain: "Failed to fetch page", status: :bad_request
      end
    else
      render plain: "No URL provided", status: :bad_request
    end
  end
end
