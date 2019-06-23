require 'sinatra/base'

class FakeApi < Sinatra::Base
  get '/api/v1/history' do
    file_response 200, 'world_trading_dump_aapl.json'
  end

  private

  def file_response(response_code, file_name)
    content_type 'application/json'
    status response_code
    get_file(file_name)
  end

  def get_file(file_name)
    File.open(full_path(file_name), 'rb').read
  end

  def full_path(file_name)
    File.dirname(__FILE__) + '/dumps/' + file_name
  end
end
