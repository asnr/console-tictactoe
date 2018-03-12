# frozen_string_literal: true

require './board.rb'

class DisplayBoard
  STATE_TO_DISPLAY_CHARACTER = {
    Board::STATE_AVAILABLE => ' ',
    Board::STATE_PLAYER_ONE => 'X',
    Board::STATE_PLAYER_TWO => 'O'
  }.freeze

  def initialize(board)
    @board = board
  end

  def to_s
    display_lines = []
    @board.each_row do |row|
      display_lines << row.map { |cell| prettify_cell(cell) }.join('|')
    end
    display_lines.join("\n#{'-' * 5}\n")
  end

  private

  def prettify_cell(cell_state)
    STATE_TO_DISPLAY_CHARACTER[cell_state]
  end
end
