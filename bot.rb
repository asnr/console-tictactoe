# frozen_string_literal: true

class Bot
  VALUE_WIN = 1
  VALUE_DRAW = 0
  VALUE_LOSE = -1
  INFINITE_POSITIVE_VALUE = VALUE_WIN + 1
  INFINITE_NEGATIVE_VALUE = VALUE_LOSE - 1

  def initialize(opponent:)
    @opponent = opponent
  end

  def move_intro
    "Bot's move\n"
  end

  def choose(board)
    _, best_move = my_move_that_maximises_my_value(board)
    best_move
  end

  private

  def my_move_that_maximises_my_value(board)
    return [result_to_value(board.result_for(self)), nil] if board.game_over?

    max_value = INFINITE_NEGATIVE_VALUE
    max_move = nil
    board.each_available_point do |move|
      board_after_move = board.play(self, move)
      value_of_move, = opponents_move_that_minimises_my_value(board_after_move)
      if value_of_move > max_value
        max_value = value_of_move
        max_move = move
      end
    end
    [max_value, max_move]
  end

  def opponents_move_that_minimises_my_value(board)
    return [result_to_value(board.result_for(self)), nil] if board.game_over?

    min_value = INFINITE_POSITIVE_VALUE
    min_move = nil
    board.each_available_point do |move|
      board_after_move = board.play(@opponent, move)
      value_of_move, = my_move_that_maximises_my_value(board_after_move)
      if value_of_move < min_value
        min_value = value_of_move
        min_move = move
      end
    end
    [min_value, min_move]
  end

  RESULT_TO_VALUE = {
    Board::RESULT_WIN => VALUE_WIN,
    Board::RESULT_DRAW => VALUE_DRAW,
    Board::RESULT_LOSE => VALUE_LOSE
  }.freeze

  def result_to_value(result)
    RESULT_TO_VALUE[result]
  end
end
