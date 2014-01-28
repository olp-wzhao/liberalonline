# create a rake task to import the CSV data
# new file: lib/tasks/import_csv_data.rake
namespace :csvimport do

  namespace :relations do
	desc "Apply implied relationships to model." 
	task :add_riding => :environment do
		#Lets build the perfect riding table
	  AboutRiding.each do |row|
      riding = Riding.where({riding_id: row.riding_id})
      if riding
        riding.description_translations = {"description" => { "en" => row.description_en, "fr" => row.description_fr}}
      end
    end
	end 
end
end
