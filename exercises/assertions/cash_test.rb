require 'minitest/autorun'
require "minitest/reporters"
Minitest::Reporters.use!

require_relative 'cash_register'
require_relative 'transaction'

class CashRegisterTest < Minitest::Test
  def setup
    @transaction1 = Transaction.new(20)
    @cash_register = CashRegister.new(100)
  end

  def test_accept_money
    @transaction1.amount_paid = 20
    assert_equal @cash_register.total_money + 20, @cash_register.accept_money(@transaction1)
  end

  def test_change
    @transaction1.amount_paid = 30
    assert_equal 10, @cash_register.change(@transaction1)
  end

  def test_give_receipt
    assert_output("You've paid $20.\n") do
      @cash_register.give_receipt(@transaction1)
    end
  end
end
