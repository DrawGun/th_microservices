channel = RabbitMq.consumer_channel
queue = channel.queue('authorization', durable: true)

queue.subscribe(manual_ack: true) do |delivery_info, properties, payload|
  payload = JSON(payload)
  extracted_token = JwtEncoder.decode(payload['token']) rescue {}
  result = Auth::FetchUserService.call(extracted_token['uuid'])

  if result.success?
    client = AdsService::Rpc::Client.fetch
    client.return_user_data(payload['ad'], result.user.id)
  end

  channel.ack(delivery_info.delivery_tag)
end
