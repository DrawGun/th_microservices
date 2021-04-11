channel = RabbitMq.consumer_channel
exchange = channel.default_exchange
queue = channel.queue('ads', durable: true)

queue.subscribe do |delivery_info, properties, payload|
  payload = JSON(payload)

  if properties[:type] == 'return_user_data' && payload['user_id'].present?
    Ads::CreateService.call(ad: payload['ad'].symbolize_keys, user_id: payload['user_id'])
  else
    Ads::UpdateService.call(id: payload['id'], data: payload['coordinates'].symbolize_keys)
  end

  exchange.publish(
    '',
    routing_key: properties.reply_to,
    correlation_id: properties.correlation_id
  )
end
