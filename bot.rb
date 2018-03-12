# frozen_string_literal: true

class Bot
  WIN = 1
  DRAW = 0
  LOSE = -1

  def move_intro
    "Bot's turn\n"
  end

  def choose(board)
    board.each_available_point do |point|
      return point
    end
  end
end
