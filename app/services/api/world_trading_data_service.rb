# frozen_string_literal: true

class Api::WorldTradingDataService
  include HTTParty
  base_uri 'api.worldtradingdata.com/api/v1'

  def initialize
    @options = { api_token: ENV['WORLDTRADINGDATA_TOKEN'] }
  end

  def historical_data(symbol, date)
    query = { symbol: symbol, date_from: Date.parse(date).strftime("%Y-%m-%d"), date_to: Date.today.strftime("%Y-%m-%d") }.merge(@options)
    self.class.get("/history",  { query: query, headers: { 'Content-Type' => 'application/json' }})
  end
end
