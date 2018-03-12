# frozen_string_literal: true

require './display.rb'
require './point.rb'

class Controller
  PLAYER_QUITS = 'q'
  DISPLAY_QUIT = "byebye\n"
  DISPLAY_WRONG_NUMBER_OF_COORDINATES = "Please enter two comma-separated integers, e.g. 1,2\n"
  DISPLAY_COORDINATES_NOT_INTEGERS = "Coordinates must be integers\n"
  DISPLAY_CHOICE_INVALID = "That place is not available\n"

  attr_reader :display
  def initialize
    @player_quit = false
    @board = Board.new
    @display = DisplayBoard.new(@board)
  end

  def update(player_input_string)
    @player_quit = player_input_string == PLAYER_QUITS
    if @player_quit
      @display = DISPLAY_QUIT
      return
    end

    point = parse(player_input_string)
    return unless point

    choice_valid = @board.player_one_chooses(point)
    @display = choice_valid ? DisplayBoard.new(@board) : DISPLAY_CHOICE_INVALID
  end

  def game_over?
    @player_quit || @board.finished?
  end

  private

  def parse(player_input_string)
    input_as_array = player_input_string.split(',')
    if input_as_array.size != 2
      @display = DISPLAY_WRONG_NUMBER_OF_COORDINATES
      return nil
    end
    begin
      coordinates = input_as_array.map { |s| Integer(s) }
    rescue ArgumentError
      @display = DISPLAY_COORDINATES_NOT_INTEGERS
      coordinates = nil
    end
    Point.new(*coordinates) if coordinates
  end
end
