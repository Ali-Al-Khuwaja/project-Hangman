# frozen_string_literal: true

require_relative 'lib/game'

puts 'Welcome to Hangman!'
puts '1. New Game'
puts '2. Load Saved Game'
print 'Choose an option (1 or 2): '
choice = gets.chomp

if choice == '2' && File.exist?('save_game.yaml')
  puts "\nLoading your saved game..."
  # Load the saved file and rebuild the Hangman object
  game = YAML.load(File.read('save_game.yaml'), permitted_classes: [Hangman, Symbol])
  game.play # rubocop:disable Style/IdenticalConditionalBranches
elsif choice == '2'
  puts "\nNo save file found! Starting a new game instead...\n\n"
  game = Hangman.new
  game.play # rubocop:disable Style/IdenticalConditionalBranches
else
  # Option 1 or any other input launches a fresh game
  game = Hangman.new
  game.play # rubocop:disable Style/IdenticalConditionalBranches
end
