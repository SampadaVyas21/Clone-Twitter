class CsvHelper
  class << self
  	require 'open-uri'
		require 'csv'
    def convert_to_ads(csv_data)
      @ads = []
      many_ads = []
      count = 0
      @errors = {}
      csv_file = csv_data.read
      CSV.parse(csv_file, headers: true) do |row|
      	count += 1
        # priorkey, details, ads_images = row
        many_ads = row['ads_images'].split(',')
        @ad = Ad.new(priorkey: row['priorkey'], details: row['details'])
         	if @ad.save
         		(0...many_ads.length).each do |i|
	         		@ad.ads_images.attach(io: URI.open(many_ads[i]), filename: many_ads[i], content_type: 'multipart/form-data')
        		end 
        	else
        		@errors.store("row_no #{count}", @ad.errors.full_messages )
        	end
      end
      return @errors
    end
  end
end

