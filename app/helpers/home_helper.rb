require 'net/http'

module HomeHelper
  def croped_image_url(image_url, x=0, y=0, width=700, height=277)
        image_buffer_url = 'http://www.service201.net/photos/crop/'
        image_utility_url = 'http://www.service201.net/ImgCrop.cgi?x=' + x.to_s + '&y=' + y.to_s + '&w=' + width.to_s + '&h=' + height.to_s + '&s='
        if image_url.start_with?('http://pantone201.ca/webskins/olp/photos/')
            image_utility_url += 'olp&i='
            image_url['http://pantone201.ca/webskins/olp/photos/'] = ''
        elsif image_url.start_with?('http://pantone201.ca/webskins/mpp/photos/')
            image_utility_url += 'mpp&i='
            image_url['http://pantone201.ca/webskins/mpp/photos/'] = ''
        elsif image_url.start_with?('http://pantone201.ca/webskins/pla/photos/')
            image_utility_url += 'pla&i='
            image_url['http://pantone201.ca/webskins/pla/photos/'] = ''
        elsif image_url.start_with?('http://pantone201.ca/webskins/vote/photos/')
            image_utility_url += 'vote&i='
            image_url['http://pantone201.ca/webskins/vote/photos/'] = ''
        end
        image_utility_url += image_url
        image_buffer_url += image_url
        image_utility_url['.jpg'] = ''
        image_buffer_url['.jpg'] = '_' + x.to_s + '_' + y.to_s + '_' + width.to_s + '_' + height.to_s + '.jpg'
        # if Net::HTTP.get_response(URI.parse(image_buffer_url)).kind_of?(Net::HTTPSuccess)
        #      image_utility_url = image_buffer_url
        # end
        image_utility_url
    end
end
