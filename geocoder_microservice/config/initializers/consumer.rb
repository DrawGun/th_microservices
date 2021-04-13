channel = RabbitMq.consumer_channel
queue = channel.queue('geocoding', durable: true)

queue.subscribe(manual_ack: true) do |delivery_info, properties, payload|
  Thread.current[:request_id] = properties.headers['request_id']
  payload = JSON(payload)

  result = Geocoder::FindCityService.call(city_name: payload['city'])
  coordinates = result.coordinates

  Application.logger.info(
    'geocoded_coordinates',
    ad_id: payload['id'],
    city: payload['city'],
    coordinates: coordinates
  )

  if coordinates.present?
    client = AdsService::Rpc::Client.fetch
    client.update_coordinates(payload['id'], coordinates)
  end

  channel.ack(delivery_info.delivery_tag)
end
