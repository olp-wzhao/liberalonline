# create a rake task to import the CSV data 
# new file: lib/tasks/import_csv_data.rake 
namespace :csv_import do

	desc 'Import Ridings.'
  task :import_ridings => :environment do
		require 'csv' 

		csv_file_path = 'db/ED_Names.csv'

    csv_data = CSV.read(csv_file_path, encoding: 'windows-1251:utf-8')

    Riding.create({riding_id: 9000, title: "Central"})

    csv_data.each do |row|
			if row[0].to_i != 0
				riding = Riding.new
				riding.riding_id = 9000 + row[0].to_i

				I18n.locale = :en
				riding.title = row[1]
				I18n.locale = :fr
				riding.title =row[2]
				riding.save
				riding.web_site_manager = WebSiteManager.where(r_id: riding.riding_id).first
				riding.save
			end
		end 
  end
end
