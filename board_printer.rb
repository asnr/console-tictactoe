# frozen_string_literal: true

require './board.rb'

class BoardPrinter
  STATE_TO_DISPLAY_CHARACTER = {
    Board::STATE_AVAILABLE => ' ',
    Board::STATE_PLAYER_ONE => 'X',
    Board::STATE_PLAYER_TWO => 'O'
  }.freeze

  def display(board)
    display_lines = []
    board.each_row do |row|
      display_lines << row.map { |cell| prettify_cell(cell) }.join('|')
    end
    board_string = display_lines.join("\n#{'-' * 5}\n")
    "#{board_string}\n"
  end

  private

  def prettify_cell(cell_state)
    STATE_TO_DISPLAY_CHARACTER[cell_state]
  end
end
