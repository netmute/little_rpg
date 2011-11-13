class RPG
  include Helper
  attr_accessor :player, :dungeon

  def initialize
    self.dungeon = DeepDungeon.new
    self.player = Player.new choice('What is your name?')
  end

  def start
    newline
    puts "Hail, brave adventurer #{player}!"
    puts player.stats :verbose
    newline
    dungeon.entered_by player
  end
end
