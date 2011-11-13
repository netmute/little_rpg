class DarkKnight < Enemy
  def initialize
    super
    self.name = 'dark knight'
    self.health = random(10..50)
    self.strength = random(5..20)
    self.intelligence = random(5..20)
    self.level = 10
  end
end
