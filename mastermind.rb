require 'pry-byebug'

class Mastermind
  @@colors = %w[red green blue orange purple yellow]

  class << self
    attr_accessor :answer
  end

  def initialize
    @clue = []
    @num_of_guesses = 0
    @answer = []
    @game_over = false
    define_game_rules
    start_game
  end

  # defines who is mastermind and how many tries codebreaker will get
  def define_game_rules
    puts 'Who should be mastermind? Player or computer?'
    @mastermind = gets.chomp
    puts 'How many tries will the codebreaker get?'
    @max_tries = gets.chomp.to_i
    set_code
  end

  # set code
  def set_code
    case @mastermind
    when 'player'
      puts 'Set the code'
      @code = gets.chomp.split(' ')
    when 'computer'
      @code = @@colors.sample(4)
    end
  end

  # start the game
  def start_game
    case @mastermind
    when 'player'
      player_mastermind
    when 'computer'
      computer_mastermind
    end
  end

  # Plays game with player as mastermind
  def player_mastermind
    while @game_over == false
      if @max_tries.positive?
        player_give_clue
        computer_takes_guess
        @num_of_guesses += 1
        @max_tries -= 1
        player_mastermind
      else
        puts 'Mastermind wins!'
        game_over
      end
    end
  end

  def player_give_clue
    return unless 0 < @num_of_guesses

    puts 'Give a clue'
    @clue = gets.chomp.split(' ')
  end

  # Computer guesses the code
  def computer_takes_guess
    if @clue == []
      @answer = @@colors.sample(4)
    else
      check_right_colors
      @answer.flatten!
      replace_duplicates
    end
    puts "The code: #{@code[0]}, #{@code[1]}, #{@code[2]}, #{@code[3]}"
    puts "Computer answer: #{@answer[0]}, #{@answer[1]}, #{@answer[2]}, #{@answer[3]}"
    puts ' '
  end

  def check_right_colors
    right_colors = @clue.reduce(0) { |sum, color| sum += 1 if %w[black white].include?(color) }
    @answer.pop(4 - right_colors)
    replace_wrong_colors(right_colors)
    @answer
  end

  def replace_wrong_colors(right_colors)
    return unless right_colors.positive?

    (4 - right_colors).times do
      @answer.push(@@colors.sample(1))
    end
    @answer
  end

  # checks to make sure there are no duplicate colors in computer guess
  def replace_duplicates
    @answer.uniq!
    while @answer.length < 4
      @answer.push(@@colors.sample(1))
      @answer.flatten!
      @answer.uniq!
    end
    @answer.shuffle!
  end

  # Players game with computer as mastermind
  def computer_mastermind
    while @game_over == false
      next unless @max_tries.positive?

      player_guesses
      check_answer(@answer)
      @max_tries -= 1
      # puts "#{@max_tries} tries remaining."
      computer_mastermind
    end
    puts 'Mastermind wins!'
    game_over
  end

  def player_guesses
    puts 'Enter the code'
    @answer = gets.chomp.split(' ')
  end

  # Check if answer matches code
  def check_answer(answer)
    if answer == @code
      puts 'Game over! Codebreaker wins!'
      game_over
    else
      computer_give_clue(@answer)
    end
  end

  def game_over
    @game_over = true
  end

  # Give clue based on answer
  def computer_give_clue(answer)
    @clues = []
    answer.each do |answer_color|
      answer_index = answer.find_index(answer_color)
      if answer[answer_index] == @code[answer_index]
        @clues.push('black')
      elsif @code.include?(answer_color)
        @clues.push('white')
      end
    end
    @clues.shuffle!
    puts "Computer clue: #{@clues.join(' ')}"
    puts ' '
  end
end

game_one = Mastermind.new
