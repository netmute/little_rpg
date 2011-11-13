class Dungeon
  include Helper
  attr_accessor :name, :alignment

  def initialize(name = 'dungeon')
    self.name = name
    self.alignment = random(-5..5)
  end

  def to_s
    "#{description} #{name}"
  end

  def description
    case alignment
    when -5..-4 then 'unspeakable evil'
    when -3..-1 then 'evil'
    when 0 then 'quiet'
    when 1..3 then 'docile'
    when 4..5 then 'grateful'
    end
  end
end
