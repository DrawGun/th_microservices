channel = RabbitMq.consumer_channel
queue = channel.queue('geocoding', durable: true)

queue.subscribe(manual_ack: true) do |delivery_info, properties, payload|
  payload = JSON(payload)

  result = Geocoder::FindCityService.call(city_name: payload['city'])
  coordinates = result.coordinates

  if coordinates.present?
    client = AdsService::Rpc::Client.fetch
    client.update_coordinates(payload['id'], coordinates)
  end

  channel.ack(delivery_info.delivery_tag)
end
