require 'rails_helper'

RSpec.describe "StockService" do
  describe "start budgets" do
    it "should give correct start_budget" do
      account = Account.new(amount: 32500, start_date: "2017-6-21", allocations: [{'symbol' => 'AAPL', 'percentage' => 100}])
      stock = StockService.new(account)
      stock.get_history
      expect(stock.start_total_budget).to eq(32500)
    end
    it "should give correct start_budget" do
      account = Account.new(amount: 32500, start_date: "2017-6-21", allocations: [{'symbol' => 'AAPL', 'percentage' => 100}])
      stock = StockService.new(account)
      stock.get_history
      expect(stock.start_budget('AAPL')).to eq(32500)
    end
  end
  describe "end budgets" do
    it "should give correct end_total_budget" do
      account = Account.new(amount: 32500, start_date: "2017-6-21", allocations: [{'symbol' => 'AAPL', 'percentage' => 100}])
      stock = StockService.new(account)
      stock.get_history
      expect(stock.end_total_budget.to_i).to eq(23849)
    end
    it "should give correct end_budget" do
      account = Account.new(amount: 32500, start_date: "2017-6-21", allocations: [{'symbol' => 'AAPL', 'percentage' => 100}])
      stock = StockService.new(account)
      stock.get_history
      expect(stock.end_budget('AAPL').to_i).to eq(23849)
    end
  end

  describe "percentage" do
    it "should give correct start percentage" do
      account = Account.new(amount: 32500, start_date: "2017-6-21", allocations: [{'symbol' => 'AAPL', 'percentage' => 100}])
      stock = StockService.new(account)
      stock.get_history
      expect(stock.get_percentage).to eq([['AAPL', 100.0]])
    end
    it "should give correct end percentage" do
      account = Account.new(amount: 32500, start_date: "2017-6-21", allocations: [{'symbol' => 'AAPL', 'percentage' => 100}])
      stock = StockService.new(account)
      stock.get_history
      expect(stock.get_percentage).to eq([['AAPL', 100.0]])
    end
  end

  describe "check data" do
    it "that last date is correct date" do
      account = Account.new(amount: 32500, start_date: "2017-6-21", allocations: [{'symbol' => 'AAPL', 'percentage' => 100}])
      stock = StockService.new(account)
      stock.get_history

      expect(stock.data[:AAPL].data.parsed_response['history'].keys.last).to eq("2019-06-21")
    end
  end
end
