require 'colorize'
class Simon
  COLORS = %w(red blue green yellow)

  attr_accessor :sequence_length, :game_over, :seq

  def initialize
    @game_over = false
    @seq = []
    @sequence_length = 1
  end

  def play
    until game_over
      take_turn
    end
    game_over_message
    reset_game
  end

  def take_turn
    show_sequence
    require_sequence
    round_success_message
    @sequence_length += 1
  end

  def show_sequence
    add_random_color
    @seq.each_with_index do |color, i|
      puts "#{i+1}: #{color}".colorize(:"#{color}")
      sleep(1)
      system('clear')
    end
  end

  def require_sequence
    input = []
    @sequence_length.times do |t|
      puts "what is the #{t+1} color?: "
      input << gets.chomp
      if input[t] != @seq[t]
        @game_over = true
        break
      end
    end

  end

  def add_random_color
   seq << COLORS.sample
  end

  def round_success_message
    "success" if @game_over == false
    system('clear')
  end

  def game_over_message
    p "it's over"
    sleep(1)
  end

  def reset_game
    @sequence_length = 1
    @game_over = false
    @seq = []
  end
end

if __FILE__ == $PROGRAM_NAME
  simon = Simon.new
  simon.play
end
