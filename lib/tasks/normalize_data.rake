namespace :normalize do

  desc 'Riding translations were imported incorrectly the first time'
  task :fix_riding_translations => :environment do
    require 'csv' 

    Riding.each do |row|
      if(row.riding_id != 0)
        
        begin
          english = row.title_translations["title"]["en"]
          french  = row.title_translations["title"]["fr"]

          
          row.title_translations = nil
          row.title = english
          I18n.locale = :fr
          row.title = french

          row.save
        rescue
          puts "Failure on record #{row.riding_id}"
        end
      end
    end 
  end
end