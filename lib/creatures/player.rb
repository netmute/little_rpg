class Player < Creature
  attr_accessor :experience

  def initialize(name)
    super name
    self.health = random(10..20)
    self.mana = random(10..20)
    self.experience = 0
  end

  def give_experience(amount)
    puts "You got #{amount} XP."
    self.experience += amount
    while level_up_possible? do
      level_up!
    end
  end

  def level_up_possible?
    experience >= (((level - 1) * 10) + (level * 10))
  end

  def attacked_by!(enemy)
    newline
    puts "* A #{enemy} attacks you!"
    Fight.new(self, enemy).start
  end

  def heal(amount)
    puts "Used #{amount} mana."
    self.reduce_mana_by! amount
    puts "Gained #{amount} health."
    self.increase_health_by! amount
  end

  def appraise(enemy)
    guess = if enemy.max_damage >= self.max_damage * 2
      'way too powerful for you'
    elsif enemy.max_damage > self.max_damage
      'stronger than you'
    elsif enemy.max_damage == self.max_damage
      'as strong as you'
    elsif enemy.max_damage < self.max_damage / 2
      'like a piece of cake'
    elsif enemy.max_damage < self.max_damage
      'weaker than you'
    end
    puts "The #{enemy} seems #{guess}."
  end

  def stats(verbose = nil)
    if verbose
      [
        "Your Character:",
        "HP: #{health},",
        "Mana: #{mana},",
        "Str: #{strength},",
        "Int: #{intelligence},",
        "Level: #{level},",
        "XP: #{experience}"
      ].join ' '
    else
      [
        "Stats",
        "H:#{health}",
        "M:#{mana}",
        "S:#{strength}",
        "I:#{intelligence}",
        "L:#{level}",
        "XP:#{experience}"
      ].join ' '
    end
  end

  def level_up!
    puts 'Level up!'
    %w(health mana).each do |attr|
      lambda do |amount|
        if amount > 0
          puts "Max #{attr} +#{amount}"
          self.send("#{attr}=", send("max_#{attr}") + amount)
        else
          self.send("current_#{attr}=", send("max_#{attr}"))
        end
      end.call(random(0..4) * level)
    end
    %w(strength intelligence).each do |attr|
      lambda do |amount|
        if amount > 0
          puts "#{attr.capitalize} +#{amount}"
          self.send("#{attr}=", send(attr) + amount)
        end
      end.call(random(0..level))
    end
    self.level += 1
  end

end
