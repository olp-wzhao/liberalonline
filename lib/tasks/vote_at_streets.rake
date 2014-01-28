namespace :voteat do
  require 'csv'
  #require 'progress_bar'

  desc "Import Riding Addresses"
  task :import_poll_stations => :environment do
    csv_file_path = 'db/voting_102.csv'

    csv_data = CSV.read(csv_file_path, encoding: 'windows-1251:utf-8')
    #progress_bar = ProgressBar.new(csv_data.count)
    csv_data.each do |row|
      begin
        if row[0].to_i != 0
          riding = Riding.where({riding_id: row[0]}).first
          riding.poll_stations.create({electoral_district: row[0], poll_division: row[1], location: row[2], address1: row[3], address2: row[4], place: row[5]})
          riding.save
        end
      rescue => ex
        puts ex.message
      end
      #progress_bar.increment!
    end
  end
end

namespace :voteat do
  require 'csv'
  #require 'progress_bar'

  desc "Import Poll Stations"
  task :import_vote_at_addresses => :environment do
    csv_file_path = 'db/Ontario_Street_Index_Guide_Mar5-2013.csv'

    csv_data = CSV.read(csv_file_path, encoding: 'windows-1251:utf-8')
    #binding.pry
    #progress_bar = ProgressBar.new(csv_data.count)
    csv_data.each do |row|
      begin
        #binding.pry
        if row[0].to_i != 0
          riding = Riding.where({riding_id: row[0]}).first
          #binding.pry
          riding.poll_street_indexes.create({electoral_district: row[0], poll_division: row[1], street_name: row[2], from_address: row[3], to_address: row[4], is_odd: row[5] == 'E' ? true : false})
          riding.save
        end
      rescue => ex
        puts ex.message
      end
      #progress_bar.increment!
      #binding.pry
    end
  end
end