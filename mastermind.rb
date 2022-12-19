require 'pry-byebug'

# To do: Make sure that colors can't repeat in code or answer

class Mastermind
  @@colors = %w[red green blue orange purple yellow]

  def initialize
    @clue = []
    @num_of_guesses = 0
    @answer = []
    @game_over = false
    define_game_rules
    if @mastermind == 'player'
      puts 'Set the code'
      @code = gets.chomp.split(' ')
      player_mastermind
    elsif @mastermind == 'computer'
      @code = @@colors.sample(4)
      computer_mastermind
    end
  end

  # defines who is mastermind and how many tries codebreaker will get
  def define_game_rules
    puts 'Who should be mastermind? Player or computer?'
    @mastermind = gets.chomp
    puts 'How many tries will the codebreaker get?'
    @max_tries = gets.chomp.to_i
  end

  # Plays game with player as mastermind
  def player_mastermind
    while @game_over == false
      if @max_tries.positive?
        if 0 < @num_of_guesses
          puts 'Give a clue'
          @clue = gets.chomp.split(' ')
        end
        computer_takes_guess
        @num_of_guesses += 1
        @max_tries -= 1
        player_mastermind
      else
        puts 'Mastermind wins!'
        @game_over = true
      end
    end
  end

  # Computer guesses the code
  def computer_takes_guess
    # binding.pry
    if @clue == []
      @answer = @@colors.sample(4)
    else
      right_colors = @clue.reduce(0) { |sum, color| sum += 1 if %w[black white].include?(color) }
      @answer.pop(4 - right_colors)
      (4 - right_colors).times do
        @answer.push(@@colors.sample(1))
      end
      @answer = @answer.flatten!
      replace_duplicates
      @answer.shuffle!
    end
    p "Computer answer: #{@answer}"
  end

  # checks to make sure there are no duplicate colors in computer guess
  def replace_duplicates
    # binding.pry
    @answer.uniq!
    while @answer.length < 4
      @answer.push(@@colors.sample(1))
      @answer.flatten!
      @answer.uniq!
    end
    @answer
  end

  # Players game with computer as mastermind
  def computer_mastermind
    while @game_over == false
      next unless @max_tries.positive?

      puts 'Enter the code'
      @answer = gets.chomp.split(' ')
      check_answer(@answer)
      @max_tries -= 1
      # puts "#{@max_tries} tries remaining."
      computer_mastermind
    end
    puts 'Mastermind wins!'
  end

  # Check if answer matches code
  def check_answer(answer)
    if answer == @code
      puts 'Game over! Codebreaker wins!'
      @game_over = true
      # @max_tries = 0
    else
      give_clue(@answer)
    end
  end

  # Give clue based on answer
  def give_clue(answer)
    binding.pry
    @clues = []
    answer.each do |answer_color|
      answer_index = answer.find_index(answer_color)
      if answer[answer_index] == @code[answer_index]
        @clues.push('black')
      elsif @code.include?(answer_color)
        @clues.push('white')
      end
    end
    p @clues.shuffle
  end
end

game_one = Mastermind.new
