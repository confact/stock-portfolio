require 'rails_helper'

RSpec.describe "Account", type: :model do
  describe "validations" do
    it "fails if amount is not filled" do
      account = Account.new(start_date: "2017-6-20")
      expect(account).not_to be_valid
    end
    it "fails if start_date is not filled" do
      account = Account.new(amount: 32500)
      expect(account).not_to be_valid
    end
    it "valid if start_date and amount is filled" do
      account = Account.new(amount: 32500, start_date: "2017-6-20")
      expect(account).to be_valid
    end
  end
end
