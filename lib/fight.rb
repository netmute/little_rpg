class Fight
  attr_accessor :player, :enemy, :player_fled, :initiative

  def initialize(player, enemy, initiative = nil)
    self.player = player
    self.enemy = enemy
    self.player_fled = false
    self.initiative = initiative
  end

  def start
    begin
      newline
      puts "#{player}(#{player.health}) vs. #{enemy.to_s.capitalize}(#{enemy.health})"
      case choice('[1] Fight. [2] Use magic. [3] Flee.', ['1','2','3'])
      when '1' then attack
      when '2' then magic
      when '3' then flee
      end
    end until (player.dead? or enemy.dead? or player_fled)

    after_fight_status
  end

  def attack
    newline
    if initiative
      enemy.hit_by! player
      player.hit_by!(enemy) unless enemy.dead?
    else
      player.hit_by! enemy
      enemy.hit_by!(player) unless player.dead?
    end
  end

  def magic
    case choice('[1] Heal yourself. [2] Appraise enemy. [3] Nevermind.', ['1','2','3'])
    when '1' then healing_spell
    when '2' then appraise_spell
    end
  end

  def healing_spell
    newline
    if player.current_mana >= player.missing_health
      player.heal player.missing_health
    elsif player.current_mana > 0
      player.heal player.current_mana
    else
      puts "Not enough mana."
    end
  end

  def appraise_spell
    newline
    if player.current_mana > 0
      puts "Used 1 mana."
      player.reduce_mana_by! 1
      player.appraise enemy
    else
      puts "Not enough mana."
    end
  end

  def flee
    newline
    if random(0..3) == 3
      self.player_fled = true
      puts "You managed to escape from the #{enemy}."
    else
      puts "You try to flee, but the #{enemy} stops you."
      player.hit_by! enemy
    end
  end

  def after_fight_status
    newline
    puts '* Fight results:'
    if enemy.dead?
      puts "You killed the #{enemy}."
      player.give_experience enemy.worth_experience
    elsif player.dead?
      puts 'You died.'
    elsif player_fled
      puts 'You fled.'
    end
    puts player.stats
    player.dead? ? exit : choice('[Continue]')
  end
end
