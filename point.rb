# frozen_string_literal: true

class Point
  attr_reader :row, :column
  def initialize(row, column)
    @row = row
    @column = column
  end
end
