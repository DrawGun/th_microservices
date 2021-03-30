require 'sinatra'

class App < Sinatra::Application
  configure :development do
    register Sinatra::Reloader

    set :raise_sinatra_param_exceptions, true
    set :show_exceptions, false
  end

  helpers Sinatra::Param, PaginationLinks, ApiErrors

  namespace '/api/v1' do
    before do
      content_type 'application/json'
    end

    get '/ads' do
      ads = Ad.all.order(updated_at: :desc).page(params[:page])
      json AdSerializer.new(ads, links: pagination_links(ads)).serializable_hash
    end

    post '/ads' do
      param :user_id, String, required: true, raise: true
      param :ad,  Hash, required: true, raise: true do
        param :title, String, required: true, raise: true
        param :description, String, required: true, raise: true
        param :city, String, required: true, raise: true
      end

      result = ::Ads::CreateService.call(
        ad: params[:ad],
        user_id: params[:user_id]
      )

      if result.success?
        status 201

        serializer = AdSerializer.new(result.ad)
        json serializer.serializable_hash
      else
        status 422
        error_response result.ad
      end
    end
  end

  error ActiveRecord::RecordNotFound do
    status 404
    error_response 'ActiveRecord::RecordNotFound'
  end

  error ActiveRecord::RecordNotUnique do
    status 422
    error_response 'ActiveRecord::RecordNotUnique'
  end

  error Sinatra::Param::InvalidParameterError do
    status 422
    error_response "#{env['sinatra.error'].param} is invalid"
  end

  run! if app_file == $0
end
