require 'pry'

class Transfer

  attr_accessor :sender, :receiver, :status, :amount

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @status = 'pending'
    @amount = amount
  end

  def valid?
    sender.valid? && receiver.valid? ? true : false
  end

  def execute_transaction
    unless self.status == 'complete' || self.amount > self.sender.balance
      sender.balance -= amount
      receiver.balance += amount
      return self.status = 'complete'
    end
      self.status = 'rejected'
      "Transaction rejected. Please check your account balance."
  end

  def reverse_transfer
    if execute_transaction
      sender.balance += amount
      receiver.balance -= amount
      self.status = 'reversed'
    end
  end

end
