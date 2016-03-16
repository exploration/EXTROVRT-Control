require 'adafruit/io'
require 'sinatra/base'
require 'sinatra/config_file'

class Extrovrt < Sinatra::Base
  # set up external config file
  register Sinatra::ConfigFile
  config_file 'config.yml'

  # create an AIO instance
  aio = Adafruit::IO::Client.new(:key => settings.aio_key)

  get "/" do
    protected!
    @robots = settings.robots
      
    # Parse last access if there was one
    if settings.log_feed
      data = aio.feeds.retrieve(settings.log_feed)
      t = Time.parse(data.updated_at).getlocal
      @last_access = "#{data.last_value} on #{t.strftime('%Y.%m.%d at %H:%M%P')}"
    end

    erb :index
  end

  get "/robot/:robot" do
    protected!
    @robot = params['robot']

    # Post robot access to the "log" feed if there is one
    if settings.log_feed
      aio.feeds(settings.log_feed).data.create(:value => "#{@robot}")
    end

    erb :control
  end


  get "/:robot/:direction" do
    api!
    # post the adafruit feed "basefeed-robot"
    feed_create aio, "#{settings.base_feed.downcase}-#{params['robot'].downcase}", params['direction'][0].upcase
  end



  private

  # only allow API calls through AJAX. This = security!
  def api!
    unless request.xhr?
      throw(:halt, [401, 'non-XHR context'])
    end
  end

  # basic HTML auth on the main app
  def authorized?
    @auth ||=  Rack::Auth::Basic::Request.new(request.env)
    @auth.provided? && @auth.basic? && @auth.credentials && @auth.credentials == [settings.username,settings.password]
  end

  def feed_create(io_client, feed, value)
    data = io_client.feeds(feed).data.create({:value => value})
    data.inspect
  end

  def protected!
    unless authorized?
      response['WWW-Authenticate'] = %(Basic realm="Restricted Area")
      throw(:halt, [401, "Oops... we need your login name & password\n"])
    end
  end
end
