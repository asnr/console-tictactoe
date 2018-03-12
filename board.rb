# frozen_string_literal: true

class Board
  STATE_AVAILABLE = :available
  STATE_PLAYER_ONE = :one
  STATE_PLAYER_TWO = :two

  def initialize(position_states: nil, player_to_state: nil)
    @rows = 3
    @columns = 3
    @position_states = position_states || []
    if @position_states.empty?
      (1..@rows).each do |_|
        @position_states << [STATE_AVAILABLE] * @columns
      end
    end
    @player_to_state = player_to_state || {}
  end

  def available?(point)
    in_field?(point) &&
      @position_states[point.row][point.column] == STATE_AVAILABLE
  end

  def play(player, point)
    new_position_states = @position_states.dup
    new_position_states[point.row] = @position_states[point.row].dup
    new_board = Board.new(position_states: new_position_states,
                          player_to_state: @player_to_state.dup)
    new_board.play!(player, point)
    new_board
  end

  def play!(player, point)
    @position_states[point.row][point.column] = state_for_player(player)
  end

  def each_available_point
    (0...@rows).each do |row_index|
      (0...@columns).each do |column_index|
        point = Point.new(row_index, column_index)
        yield point if available?(point)
      end
    end
  end

  def each_row
    @position_states.each do |row|
      yield row.dup
    end
  end

  def game_over?
    false
  end

  private

  def state_for_player(player)
    state = @player_to_state[player]
    unless state
      state = if @player_to_state.empty?
                STATE_PLAYER_ONE
              else
                STATE_PLAYER_TWO
              end
      @player_to_state[player] = state
    end
    state
  end

  def in_field?(point)
    0 <= point.row && point.row < @rows &&
      0 <= point.column && point.column < @columns
  end

end
