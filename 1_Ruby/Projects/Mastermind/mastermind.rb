module Mastermind
  TURNS = 12
  COLORS = [:R, :O, :Y, :G, :B, :W]
  GUESSER = 'G'
  CREATOR = 'C'

  class Game
    attr_reader :role, :secret_code, :turns_left, :candidates, :guess

    def initialize
      choose_role
      @turns_left = TURNS
      @candidates = COLORS.repeated_permutation(4).to_a
      @guess = [:R, :R, :O, :O]
    end

    def play
      while turns_left > 0
        guess = role == GUESSER ? player_guess : @guess
        check_guess(guess)
        @turns_left -= 1 if guess != secret_code
      end
      lose if turns_left == 0
    end

    private

    def check_guess(guess)
      if guess == secret_code
        win
      else
        give_feedback(guess)
      end
    end

    def choose_role
      puts "Would you like to be the guesser or the creator? (G or C)"
      @role = gets.chomp.upcase
      system "clear"
      role == GUESSER ? guesser_role : creator_role
    end

    def guesser_role
      puts "YOU ARE NOW THE GUESSER!"
      @secret_code = generate_secret_code
    end

    def creator_role
      puts "YOU ARE NOW THE CREATOR!"
      print "Please enter the 4 color secret code (R, O, Y, G, B, W): "
      @secret_code = gets.chomp.delete(' ').upcase.split('').map(&:to_sym)
      system "clear"
    end

    def generate_secret_code
      COLORS.sample(4)
    end

    def player_guess
      puts "Enter your guess of the 4 random colors(R, O, Y, G, B, W)."
      puts "You have #{@turns_left} turns left"
      gets.chomp.delete(' ').upcase().split('').map(&:to_sym)
    end

    def give_feedback(guess)
      exact_matches = guess.zip(secret_code).count { |g, s| g == s }
      color_matches = (guess & secret_code).size - exact_matches
      puts "The Guess #{guess} has #{exact_matches} exact_matches and #{color_matches} color matches"
      update_candidates(guess, exact_matches, color_matches)
    end

    def update_candidates(guess, exact_matches, color_matches)
      @candidates.reject! do |candidate|
        candidate_exact_matches = guess.zip(candidate).count { |g, c| g == c }
        candidate_color_matches = (guess & candidate).size - candidate_exact_matches
        candidate_exact_matches != exact_matches || candidate_color_matches != color_matches
      end
      @guess = candidates.first
    end

    def win
      puts "You have won! You have guessed the secret combination"
      exit
    end

    def lose
      puts "You have lost! You haven't guessed the secret combination"
    end


  end
end

game = Mastermind::Game.new
game.play
