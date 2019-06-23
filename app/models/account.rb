# frozen_string_literal: true

class Account
  include ActiveModel::Model

  attr_accessor :amount, :start_date, :allocations

  validates :amount, :start_date, presence: true
end
