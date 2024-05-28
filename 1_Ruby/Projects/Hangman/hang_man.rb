require 'yaml'

class Hangman
  WRONG_GUESSES = 11

  def initialize(secret_word = nil, guesses = nil, wrong_guesses = nil)
    words = File.read('google-10000-english-no-swears.txt')
    filtered_words = words.split.select { |word| word.length.between?(5, 12) }
    @secret_word = secret_word.nil? ? filtered_words.sample : secret_word
    @guesses = guesses.nil? ? [] : guesses
    @wrong_guesses = wrong_guesses.nil? ? 0 : wrong_guesses
  end

  def display_word
    @secret_word.chars.map { |c| @guesses.include?(c) ? c : '_' }.join(' ')
  end

  def guess(input)
    @guesses << input
    unless @secret_word.include?(input)
      @wrong_guesses += 1
    end
  end

  def save_game
    File.open('save.yaml', 'w') {|file| file.write(YAML.dump(:secret_word => @secret_word, :guesses => @guesses, :wrong_guesses => @wrong_guesses))}

  end

  def self.load_game
    data = YAML.load(File.read('save.yaml'))
    self.new(data[:secret_word], data[:guesses], data[:wrong_guesses])
  end

  def won?
    @secret_word.chars.all? { |c| @guesses.include?(c) }
  end

  def lost?
    @wrong_guesses >= WRONG_GUESSES
  end

  def remaining_guesses
    WRONG_GUESSES - @wrong_guesses
  end

  attr_accessor :guesses, :secret_word, :wrong_guesses
end

puts "Do you want to load a saved game? (y/n)"
if gets.chomp.downcase == 'y'
  game = Hangman.load_game
else
  game = Hangman.new
end

until game.won? || game.lost?
  puts "Secret word: #{game.display_word}"
  puts "Remaining guesses: #{game.remaining_guesses}"
  puts "You have guessed #{game.guesses}"
  puts "Guess a letter or enter 'save' to save the game:"
  input = gets.chomp.downcase
  if input == 'save'
    game.save_game
    break
  else
    game.guess(input)
  end
end

if game.won?
  puts "CONGRATULATIONS, YOU HAVE WON THE GAME! The word was #{game.secret_word}"
elsif game.lost?
  puts "You have lost. The word was #{game.secret_word}"
end
