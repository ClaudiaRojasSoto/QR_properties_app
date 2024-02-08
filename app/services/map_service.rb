class MapService
  include HTTParty
  base_uri 'https://eu1.locationiq.com/v1'

  def self.initialize_map(address)
    response = get('/search.php', query: {
                     key: 'pk.0f9b547895c4f8881948b9f403d466dc',
                     q: address,
                     format: 'json'
                   })

    map = {
      address:,
      center: [0, 0],
      zoom: 13
    }

    if response.success?
      coordinates = response.parsed_response.first
      if coordinates
        bbox = coordinates['boundingbox']
        map[:center] = [(bbox[0].to_f + bbox[1].to_f) / 2, (bbox[2].to_f + bbox[3].to_f) / 2]
      end
    else
      { error: response['error'] }
    end

    map
  end
end
