class Mastermind
  @@colors = %w[red green blue orange purple yellow]

  def initialize(max_tries)
    @code = @@colors.sample(4)
    @max_tries = max_tries
    p @code
    play_game
  end

  # Take user input and check answer against code
  def play_game
    if @max_tries > 0
      puts 'Enter the code'
      answer = gets.chomp.split(' ')
      check_answer(answer)
      @max_tries -= 1
      puts "#{@max_tries} tries remaining."
      play_game
    else
      puts 'You lose!'
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
end

game_one = Mastermind.new(5)

game_one.play_game
