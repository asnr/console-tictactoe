# frozen_string_literal: true

require './controller.rb'

class TicTacToe
  def initialize
    @controller = Controller.new
  end

  def start
    print @controller.display.to_s
    until @controller.game_over?
      player_input = read_player_input
      @controller.update player_input
      print @controller.display.to_s
    end
  end

  private

  def read_player_input
    print "\n"
    print '> '
    gets.strip
  end
end

TicTacToe.new.start
