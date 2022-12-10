class Mastermind
  @@colors = %w[red green blue orange purple yellow]

  def initialize(max_tries)
    @code = @@colors.sample(4)
    @max_tries = max_tries
    # create_board
    p @code
    play_game
  end

  def play_game
    while @max_tries > 0
      puts 'Enter the code'
      answer = gets.chomp.split(' ')
      p answer
      check_answer(answer)
      @max_tries -= 1
    end
  end

  # Check if answer matches code
  def check_answer(answer)
    if answer == @code
      puts 'Game over! You win!'
      @max_tries = 0
    else
      give_clue(answer)
    end
  end

  # Give clue based on answer
  def give_clue(answer)
    @clues = []
    answer.each do |answer_color|
      answer_index = answer.find_index(answer_color)
      if answer[answer_index] == @code[answer_index]
        @clues.push('black')
      elsif @code.include?(answer_color)
        @clues.push('white')
      end
    end
    p @clues
  end

  # Create a blank board
  # def create_board
  #   @tries.times do
  #     puts 'Your answer:'
  #     p [' ', ' ', ' ', ' ']
  #     puts 'Clues:'
  #     p [' ', ' ', ' ', ' ']
  #   end
  # end

  # Update board based on user input
end

game_one = Mastermind.new(5)

game_one.play_game
