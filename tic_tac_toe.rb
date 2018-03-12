# frozen_string_literal: true

require './controller.rb'
require './human_player.rb'
require './bot.rb'
require './board.rb'
require './board_printer.rb'

class TicTacToe
  def initialize
    @board = Board.new
    @board_printer = BoardPrinter.new
    @player_one = HumanPlayer.new
    @player_two = Bot.new
  end

  def start
    print @board_printer.display(@board)
    current_player = @player_one
    until @board.game_over?
      print current_player.move_intro
      players_choice = current_player.choose(@board)
      quit_early unless players_choice
      @board = @board.play(current_player, players_choice)
      print @board_printer.display(@board)
      current_player = player_after(current_player)
    end
  end

  private

  def quit_early
    print "Goodbye\n"
    exit
  end

  def player_after(player)
    if player == @player_one
      @player_two
    else
      @player_one
    end
  end
end

TicTacToe.new.start
