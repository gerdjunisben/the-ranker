namespace :db do
    desc "Parse JSON files and insert data into the database"
    task import_json: :environment do
      require 'json'
  
      json_dir = Rails.root.join('db', 'jsons')
  
      Dir.glob("#{json_dir}/*.json").each do |file|
        puts "Processing file: #{file}"
  
        json_data = JSON.parse(File.read(file))
  
        json_data.each do |entry|
            begin
                Gif.create!(
                    link: entry['link'],
                    global_rank: 0,
                    rank_count: 0,
                )
            rescue ActiveRecord::RecordInvalid => e
                puts "Failed to create item for link: #{entry['link']}. Error: #{e.message}"
            end
        end
  
        puts "Finished processing file: #{file}"
      end
    end
  end