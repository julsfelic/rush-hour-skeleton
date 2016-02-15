module RushHour
  class Server < Sinatra::Base

    not_found do
      erb :error
    end

    post '/sources' do
      ClientHelper.parse_client_params(params)
    end

    post '/sources/:identifier/data' do |identifier|
      client = ClientHelper.find_client(identifier)
      return ApplicationHelper.status_message(403, "403 Forbidden - Application not registered") unless client

      payload_request = PayloadRequestHelper.create_payload_request(client, params)

      PayloadRequestHelper.payload_status_message(params, payload_request)
    end

    get '/sources/:identifier/events' do |identifier|
      @client = ClientHelper.find_client(identifier)
      erb :event_index
    end

    get '/sources/:identifier/events/:event' do |identifier, event|
      @client = ClientHelper.find_client(identifier)
      @event  = event
      if @client.payload_requests.find_by(event_name: event)
        erb :event_show
      else
        erb :event_error
      end
    end
  end
end
