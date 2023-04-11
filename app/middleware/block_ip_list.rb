class BlockIpList
  BLOCKED_IPS = []

  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)

    if BLOCKED_IPS.include?(request.ip)
      [403, { 'Content-Type' => 'text/html' }, ['Forbidden']]
    else
      @app.call(env)
    end
  end
end