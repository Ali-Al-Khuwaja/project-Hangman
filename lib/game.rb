# frozen_string_literal: true

require 'pry-byebug'
require 'yaml'
# Hangman class
class Hangman
  def initialize
    file = File.read('assets/google-10000-english-no-swears.txt')
    viable_words = file.split.filter { |word| word.length.between?(4, 6) } # Better than 12 :)

    @random_word = viable_words.sample.split('')
    @current_word_state = Array.new(@random_word.length, '-')
    @incorrect_guesses = []
    @remaining_lives = 6
  end

  def play
    print "Game Title: Hangman\n"

    until @remaining_lives <= 0 || @random_word == @current_word_state
      print "\nYour Guess so far: #{@current_word_state}\nYour remaining lives are: #{@remaining_lives}\n"
      print "Enter a letter:\nOr enter 'save' to save the progress\n"
      letter = gets.chomp.downcase

      if letter == 'save'
        save_game
        return
      end

      # Validate
      until letter.match?(/^[a-z]$/)
        puts "Please enter 1 letter, '#{letter}' is not valid\nOr save\n"
        letter = gets.chomp.downcase
        if letter == 'save'
          save_game
          return
        end
      end

      # included?
      unless @random_word.include?(letter)
        print "\nThe letter: #{letter} is not included in the word\n"
        @remaining_lives -= 1
      end

      # comparer
      @random_word.each_with_index do |char, index|
        @current_word_state[index] = letter if char == letter
      end
    end

    if @remaining_lives.zero?
      print "You lost\n"
      print "The word was #{@random_word}\n"
    elsif @random_word == @current_word_state
      print "You won\n"
    end
  end

  def save_game
    print "Saved\n"
    saved_data = YAML.dump(self)
    File.write('save_game.yaml', saved_data)
  end
end
