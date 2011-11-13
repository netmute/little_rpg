module Helper
  def random(range)
    Random.new.rand(range)
  end

  def choice(string, valid_values = nil)
    print string + " "
    input = gets.strip
    valid_values && !valid_values.include?(input) ? choice(string, valid_values) : input
  end

  def newline(amount = 1)
    amount.times { puts }
  end
end
