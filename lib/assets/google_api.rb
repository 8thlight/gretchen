require 'rubygems'
require 'google/api_client'
require 'json'

class GoogleCalendar
  def initialize(user, client_key, client_secret, calendarId)
    @calendarId = calendarId
    @client = Google::APIClient.new
    @client.authorization.client_id = client_key
    @client.authorization.client_secret = client_secret
    @client.authorization.scope = 'userinfo.email, userinfo.profile, https://www.googleapis.com/auth/calendar'
    @client.authorization.refresh_token = user['refresh_token']
    @client.authorization.access_token = user['token']

    @service = @client.discovered_api('calendar', 'v3')
  end

  def get_cal_data
    result = result = @client.execute(:api_method => @service.events.list,
                        :parameters => {'calendarId' => @calendarId})
  end

  def add_vacation(summary, start_date, end_date)
    event = {
      'summary' => "#{summary}",
      'start' => {
        'date' => "#{start_date}"
      },
      'end' => {
        'date' => "#{end_date}"
      }
    }
    result = @client.execute(:api_method => @service.events.insert,
                    :parameters => {'calendarId' => @calendarId},
                    :body_object => event,
                    :headers => {'Content-Type' => 'application/json'})

  end
  
  def get_single_event(id)
    result = @client.execute(:api_method => @service.events.get,
                             :parameters => {'calendarId' => @calendarId, 'eventId' => id})
    result

  end

  def delete_event(id)
    result = @client.execute(:api_method => @service.events.delete,
                             :parameters => {'calendarId' => @calendarId, 'eventId' => id})
  end

  def fetch_new_token
    if @client.authorization.refresh_token && @client.authorization.expired?
      @client.authorization.fetch_access_token!
    end
  end
end
