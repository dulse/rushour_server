require 'httparty'
class GoogleMaps
  include HTTParty

  base_uri 'https://maps.googleapis.com/maps/api'

  def directions(start_place, end_place, arrive_by, options = {})
    default_options = {language: :en, sensor: false, mode: :driving, waypoint: [], avoid: [], units: :imperial, departure_time: nil}
    options = default_options.merge(options).merge(origin: start_place, destination: end_place, arrival_time: arrive_by)
    self.class.get('/directions/json?', query: options)
  end

end
