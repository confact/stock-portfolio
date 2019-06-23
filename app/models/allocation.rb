# frozen_string_literal: true

class Allocation
  include ActiveModel::Model

  attr_accessor :id, :symbol, :percentage
  attr_accessor :data

  def first_close
    return nil if is_error?

    data.parsed_response['history']&.values.last['close']&.to_f
  end

  def last_close
    return nil if is_error?

    data.parsed_response['history']&.first&.second['close']&.to_f
  end

  def get_percentage_amount(total_amount)
    total_amount * percentage
  end

  def get_new_value(amount)
    return 0.0 if first_close.nil?
    return 0.0 if last_close.nil?

    count = amount / first_close
    counted = count * last_close
    counted
  end

  def end_budget(total_amount)
    amount = get_percentage_amount(total_amount.to_f)
    get_new_value(amount)
  end

  def start_budget(total_amount)
    get_percentage_amount(total_amount)
  end

  def end_percentage(total_amount, new_total_amount)
    (end_budget(total_amount) / new_total_amount)*100
  end

  def history
    return [] if is_error?

    @history ||= data.parsed_response['history'].map { |h| [h.first, h.second['close'].to_f] }
  end

  def is_error?
    data.parsed_response.keys.include?('Message')
  end
end
