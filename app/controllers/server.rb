module RushHour
  class Server < Sinatra::Base

    not_found do
      erb :'errors/error'
    end

    def render_payload_requests(client)
      if client.payload_requests.empty?
        erb :'errors/app_error', locals: { msg: "No payload data has been received for this source.",
                                           client: client }
      else
        erb :statistics
      end
    end

    get '/' do
      erb :landing
    end

    get '/signup' do
      erb :signup
    end

    post '/sources' do
      ClientHelper.parse_client_params(params)
    end

    get '/sources/:identifier' do |identifier|
      @client = ClientHelper.find_client(identifier)

      if @client.nil?
        erb :'errors/app_error', locals: { msg: "Identifier does not exist" }
      else
        render_payload_requests(@client)
      end
    end

    post '/sources/:identifier/data' do |identifier|
      client = ClientHelper.find_client(identifier)
      return ApplicationHelper.status_message(403, "403 Forbidden - Application not registered") unless client

      payload_request = PayloadRequestHelper.create_payload_request(client, params)
      PayloadRequestHelper.payload_status_message(params, payload_request)
    end

    get '/sources/:identifier/events' do |identifier|
      @client = ClientHelper.find_client(identifier)

      erb :'/events/event_index'
    end

    get '/sources/:identifier/events/:event' do |identifier, event|
      @client = ClientHelper.find_client(identifier)
      @event  = event

      if @client.payload_requests.find_by(event_name: event)
        erb :'/events/event_show'
      else
        erb :'errors/event_error'
      end
    end

    get '/sources/:identifier/urls' do |identifier|
      @client = ClientHelper.find_client(identifier)
      urls = @client.url_requests.pluck(:url).uniq

      erb :'/urls/urls', locals: { urls: urls }
    end

    get '/sources/:identifier/urls/:path' do |identifier, path|
      @url = UrlRequestHelper.find_url(identifier, path)

      if @url
        erb :'/urls/url_stats'
      else
        erb :'errors/url_does_not_exist'
      end
    end
  end
end
