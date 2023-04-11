class Rack::Attack
  Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new

  safelist('allow-trusted-ips') do |req|
    trusted_ips = []
    trusted_ips.include?(req.ip)
  end

  # 許可されるリクエストを制限する
  throttle('requests/ip', limit: 10, period: 1.minute) do |req|
    req.ip
  end

  # レートリミットを超えたリクエストに対する応答をカスタマイズ
  self.throttled_responder = lambda do |env|
    retry_after = (env['rack.attack.match_data'] || {})[:period]
    [
      429,
      {
        'Content-Type' => 'text/html',
        'Retry-After' => retry_after.to_s
      },
      ["Too Many Requests\n"]
    ]
  end
end