namespace :csvimport do

  require 'csv'
  #require 'progress_bar'

  desc "Import CSV Data."
  task :riding_locations => :environment do
    
    #Geocoder::Configuration.lookup = :esri

    csv_file_path = 'db/Postal_Codes_26.csv'

    csv_data = CSV.read(csv_file_path, encoding: 'windows-1251:utf-8')
    #progress_bar = ProgressBar.new(csv_data.count)
    csv_data.each do |row|
      begin
        riding = Riding.where({riding_id: row[1]}).first
        riding.riding_addresses.create({postal_code: row[0] })
        #binding.pry
        riding.save
      rescue => ex
        puts ex.message
      end
      #progress_bar.increment!
    end
  end

  task :attach_riding_to_location => :environment do
    csv_file_path = 'db/Postal_Codes.csv'
    csv_data = CSV.read(csv_file_path, encoding: 'windows-1251:utf-8')
    #progress_bar = ProgressBar.new(csv_data.count)
    csv_data.each do |row|
      begin
        riding = Riding.where({riding_id: row[1]}).first
        address = RidingAddress.where({postal_code: row[0]}).first
        address.riding_number = riding.riding_id
        #riding.riding_addresses.push(address)
        #riding.riding_addresses.create({postal_code: row[0] })
        #binding.pry
        address.save
        #riding.save
        #binding.pry
      rescue => ex
        puts ex.message
      end
      progress_bar.increment!
    end
  end
end