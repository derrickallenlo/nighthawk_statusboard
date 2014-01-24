require 'instagram'

# Instagram Client ID from http://instagram.com/developer
Instagram.configure do |config|
  config.client_id = '05ddad8281ed476e92419490176b0faa'
end

# Latitude, Longitude for location
instadash_location_lat = '36.127719'
instadash_location_long = '-115.16586'

SCHEDULER.every '10m', :first_in => 0 do |job|
  photos = Instagram.media_search(instadash_location_lat,instadash_location_long)
  if photos
    photos.map! do |photo|
      { photo: "#{photo.images.low_resolution.url}" }
    end    
  end
  send_event('instadash', photos: photos)
end