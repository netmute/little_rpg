class SmallRat < Enemy
  def initialize
    super
    self.name = 'small rat'
    self.health = random(3..5)
    self.strength = random(1..2)
    self.intelligence = random(1..3)
  end
end
