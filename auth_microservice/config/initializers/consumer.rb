channel = RabbitMq.consumer_channel
exchange = channel.default_exchange
queue = channel.queue('authorization', durable: true)

queue.subscribe(manual_ack: true) do |delivery_info, properties, payload|
  payload = JSON(payload)
  extracted_token = JwtEncoder.decode(payload['token']) rescue {}
  result = Auth::FetchUserService.call(extracted_token['uuid'])

  data = result.success? ? { user_id: result.user.id }.to_json : ''
  exchange.publish(
    data,
    routing_key: properties.reply_to,
    correlation_id: properties.correlation_id
  )
end
