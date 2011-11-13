class Creature
  include Helper
  attr_accessor :name,
                :strength, :intelligence, :level,
                :current_health, :max_health,
                :current_mana, :max_mana

  def initialize(name = 'creature')
    self.name = name
    self.level = 1
    self.health = random(5..10)
    self.strength = random(1..5)
    self.intelligence = random(1..5)
  end

  def to_s
    name
  end

  %w(health mana).each do |attr|
    define_method "#{attr}" do
      send("current_#{attr}").to_s + '/' + send("max_#{attr}").to_s
    end

    define_method "missing_#{attr}" do
      send("max_#{attr}") - send("current_#{attr}")
    end

    define_method "#{attr}=" do |amount|
      self.send("max_#{attr}=", amount)
      self.send("current_#{attr}=", amount)
    end

    define_method "increase_#{attr}_by!" do |amount|
      if instance_eval("self.current_#{attr} += #{amount}") > send("max_#{attr}")
        self.send("current_#{attr}=", send("max_#{attr}"))
      else
        send("current_#{attr}")
      end
    end

    define_method "reduce_#{attr}_by!" do |amount|
      if instance_eval("self.current_#{attr} -= #{amount}") < 0
        self.send("current_#{attr}=", 0)
      else
        send("current_#{attr}")
      end
    end
  end

  %w(strength intelligence).each do |attr|
    define_method "reduce_#{attr}_by!" do |amount|
      if instance_eval("self.#{attr} -= #{amount}") < 0
        self.send("#{attr}=", 0)
      else
        send(attr)
      end
    end

    define_method "increase_#{attr}_by!" do |amount|
      instance_eval("self.#{attr} += #{amount}")
    end
  end

  def dealt_damage
    random(min_damage..max_damage)
  end

  def min_damage
    (strength / 2) + (intelligence / 4)
  end

  def max_damage
    strength + (intelligence / 2) + (max_health / 4)
  end

  def hit_by!(creature)
    damage = creature.dealt_damage
    if damage.eql? 0
      puts "#{creature.to_s.capitalize} misses."
    else
      puts "#{creature.to_s.capitalize} hits #{self} for #{damage} damage."
    end
    self.reduce_health_by! damage
  end

  def alive?
    current_health > 0
  end

  def dead?
    !alive?
  end
end
