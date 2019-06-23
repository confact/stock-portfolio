# frozen_string_literal: true

class StockService
  def initialize(account)
    @account = account
    @api = Api::WorldTradingDataService.new
  end

  attr_accessor :data

  def get_history
    @data = {}
    @account.allocations.each do |k|
      a = Allocation.new(symbol: k['symbol'], percentage: k['percentage'].to_f/100, data: @api.historical_data(k['symbol'], @account.start_date))
      @data[k['symbol'].to_sym] = a
    end
  end

  def start_budget(symbol)
    @data[symbol.to_sym].start_budget(@account.amount)
  end

  def end_budget(symbol)
    @data[symbol.to_sym].end_budget(@account.amount)
  end

  def start_total_budget
    return @start_budget if @start_budget.present?
    start_budget = []
    @data.each do |d|
      start_budget << d.second.start_budget(@account.amount).to_f
    end
    start_budget.compact.sum
  end

  def end_total_budget
    return @end_budget if @end_budget.present?
    @end_budget = []
    @data.each do |d|
      @end_budget << d.second.end_budget(@account.amount).to_f
    end
    @end_budget.compact.sum
  end

  def start_to_end_progress
    @end_progress ||= end_total_budget
  end

  def get_percentage
    @account.allocations.map { |k| [k['symbol'], @data[k['symbol'].to_sym].percentage*100] }
  end

  def get_end_percentage
    @account.allocations.map { |k| [k['symbol'], @data[k['symbol'].to_sym].end_percentage(@account.amount, start_to_end_progress)] }
  end

  def get_progress_allocations_data
    @account.allocations.map { |k| {name: k['symbol'], data: [['start', start_budget(k['symbol'])], ['current', end_budget(k['symbol'])]]} }
  end

  def get_history_data
    @account.allocations.map { |k| {name: k['symbol'], data: @data[k['symbol'].to_sym].history} }
  end

  def calculate_allocations

  end
end
