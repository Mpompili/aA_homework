class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @name1 = name1
    @name2 = name2
    @cups = Array.new(14){Array.new}
    place_stones
  end

  def place_stones
    cups.each_index do |idx|
      if ![6, 13].include?(idx)
        cups[idx] += [:stone, :stone, :stone, :stone]
      else
        cups[idx] = []
      end
    end

    # helper method to #initialize every non-store cup with four stones each
  end

  def valid_move?(start_pos)
    raise "Invalid starting cup" if start_pos < 0 || start_pos >= 13
    raise "Invalid starting cup" if cups[start_pos].empty?
  end

  def make_move(start_pos, current_player_name)
    stones = @cups[start_pos]
      @cups[start_pos] = []

      # distributes stones
      cup_idx = start_pos
      until stones.empty?
        cup_idx += 1
        cup_idx = 0 if cup_idx > 13
        # places stones in the correct current player's cups
        case cup_idx
        when 6
          @cups[6] << stones.pop if current_player_name == @name1
        when 13
          @cups[13] << stones.pop if current_player_name == @name2
        else
          @cups[cup_idx] << stones.pop
        end
      end
      render
      next_turn(cup_idx)
      # stones = cups[start_pos].length #4
      # cups[start_pos] = []
      # (1..stones).each do |i|
      #   #
      #   # p "start_pos: #{start_pos} i:#{i}  s_p + i #{start_pos + i} "
      #   # p "#{start_pos + i}"
      #   # p "cup: #{(start_pos+i)%14} "
      #   p i
      #   next if (start_pos+i)%14 == 6 && current_player_name == @name1
      #   next if (start_pos+i)%14 == 13 && current_player_name == @name2
      #   cups[(start_pos+i)%14] << :stone
      # end
      #


  end

  def next_turn(ending_cup_idx)
    # helper method to determine what #make_move returns
    if ending_cup_idx == 6 || ending_cup_idx == 13
      # ended on store -- get to choose where to start again
      :prompt
    elsif @cups[ending_cup_idx].count == 1
      # ended on empty cup -- switches players' turns
      :switch
    else
      # ended on cup with stones in it -- automatically starts there
      ending_cup_idx
    end
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    cups[0..5].all?(&:empty?) ||
    cups[7..12].all?(&:empty?)

  end

  def winner
  end
end
