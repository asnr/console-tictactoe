# frozen_string_literal: true

class Board
  STATE_AVAILABLE = :available
  STATE_PLAYER_ONE = :one
  STATE_PLAYER_TWO = :two

  def initialize
    @position_states = []
    @rows = 3
    @columns = 3
    (1..@rows).each do |_|
      @position_states << [STATE_AVAILABLE] * @columns
    end
  end

  def player_one_chooses(point)
    return false unless in_field?(point) && available?(point)

    @position_states[point.row][point.column] = :one
  end

  def each_row
    @position_states.each do |row|
      yield row.dup
    end
  end

  def finished?
    false
  end

  private

  def in_field?(point)
    0 <= point.row && point.row < @rows &&
      0 <= point.column && point.column < @columns
  end

  def available?(point)
    @position_states[point.row][point.column] == STATE_AVAILABLE
  end
end
