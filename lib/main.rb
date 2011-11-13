require 'pathname'
lib_path = File.dirname(Pathname.new(__FILE__).realpath) + '/'

%w(helper fight creature enemy dungeon rpg).each { |file| require lib_path + file + '.rb' }

%w(creatures dungeons).each do |load_path|
  Dir[lib_path + load_path + '/*.rb'].each { |file| require file }
end

RPG.new.start
