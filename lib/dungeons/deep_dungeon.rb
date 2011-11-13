class DeepDungeon < Dungeon
  def initialize
    super
    self.name = 'deep dungeon'
  end

  def entered_by(player)
    puts "You climb down into the #{self}."
    newline
    puts "The #{self} is filled with creatures."
    puts "For some reason you decide to kill all of them."

    15.times { Enemy.new(['worm','slime','blob'].sample).attacked_by!(player) }

    newline 2
    puts 'Your clothes are drained in the blood of your enemies.'
    newline
    puts 'Suddenly, a dark knight.'
    player.attacked_by! DarkKnight.new

    newline
    puts "Congratulations! You managed to survive the #{self}."
    puts player.stats :verbose
  end
end
