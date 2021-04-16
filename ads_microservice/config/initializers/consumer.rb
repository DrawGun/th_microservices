channel = RabbitMq.consumer_channel
exchange = channel.default_exchange
queue = channel.queue('ads', durable: true)

queue.subscribe do |delivery_info, properties, payload|
  Thread.current[:request_id] = properties.headers['request_id']

  payload = JSON(payload)
  Ads::UpdateService.call(id: payload['id'], data: payload['coordinates'].symbolize_keys)

  Application.logger.info(
    'geocode_coordinates',
    ad_id: payload['id'],
    coordinates: payload['coordinates']
  )

  exchange.publish(
    '',
    routing_key: properties.reply_to,
    correlation_id: properties.correlation_id
  )
end
