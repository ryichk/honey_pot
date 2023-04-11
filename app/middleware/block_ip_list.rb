class BlockIpList
  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)
    ip_address = request.ip

    if IpList.trusted.exists?(ip_address: ip_address)
      @app.call(env)
    elsif IpList.blocked.exists?(ip_address: ip_address)
      [403, { 'Content-Type' => 'text/html' }, ['Forbidden']]
    else
      @app.call(env)
    end
  end
end