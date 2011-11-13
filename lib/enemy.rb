class Enemy < Creature
  def initialize(name = 'enemy')
    super
    self.name = name
  end

  def attacked_by!(player)
    newline
    puts "* You attack a #{self}!"
    Fight.new(player, self, :initiative).start
  end

  def worth_experience
    (max_damage / 2) + level
  end
end
