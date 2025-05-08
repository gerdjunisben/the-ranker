class GifsController < ApplicationController
  before_action :authenticate_user!
  def index
    @user = current_user
    @gifs = Gif.all
  end

  def show
    @user = current_user
    @gif = Gif.find(params[:id])
    @num = params[:id].to_i
    begin
      @rank = Ranking.find_by(user: @user, gif: @gif)
    rescue ActiveRecord::RecordNotFound
      @rank = nil
    end
    
  end

  def update
    @gif = Gif.find(params[:id])
    begin
      prev = Ranking.find_by(user: current_user, gif: @gif)
    rescue ActiveRecord::RecordNotFound
      prev = nil
    end

    if prev.nil?
      
      rating = params[:rating].to_f
      Ranking.create(user: current_user, gif: @gif, rank: rating)
      @gif.add_rating(rating)
    else
      rating = params[:rating].to_f
      Ranking.update(prev.id, rank: rating)
      @gif.switch_rating(prev.rank, rating)
    end
    render json: { message: 'Rating updated successfully', gif: @gif }, status: :ok
  end

  def global_rankings
    @gifs = Gif.order(global_rank: :desc)
  end

  def randomNext
    @user = current_user
    unrated_gifs = Gif.where.not(id: Ranking.where(user: @user).select(:gif_id))

    @gif = unrated_gifs.sample
    if @gif
      render json: { gif: @gif }, status: :ok
    else
      render json: { message: 'No unrated GIFs available' }, status: :not_found
    end
  end
end
