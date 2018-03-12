# frozen_string_literal: true

class HumanPlayer
  QUIT_EARLY = 'q'

  def move_intro
    "Input your move\n"
  end

  def choose(board)
    choice = nil
    until choice
      players_input = read_player_input
      return nil if players_input == QUIT_EARLY
      choice = parse_and_explain_errors(players_input, board: board)
    end
    choice
  end

  private

  def read_player_input
    print "\n"
    print '> '
    gets.strip
  end

  def parse_and_explain_errors(players_input_string, board:)
    input_array = players_input_string.split(',')
    if input_array.size != 2
      puts 'Need two coordinates'
      return nil
    end

    begin
      coordinates = input_array.map { |s| Integer(s) }
    rescue ArgumentError
      puts 'Need integers'
      return nil
    end

    choice = Point.new(*coordinates)
    unless board.available?(choice)
      puts 'Position is not available'
      return nil
    end

    choice
  end
end
