require 'set'

grid = File.readlines('input.txt', chomp: true).map(&:chars).map { |l| l.map(&:to_i) }

def count_visible(grid)
  total = grid.size * 4 - 4
  rotated = grid.transpose

  (1..grid.size - 2).each do |row_idx|
    (1..grid.first.size - 2).each do |col_idx|
      lhs = grid[row_idx][0..col_idx-1].all? { |height| height < grid[row_idx][col_idx]}
      rhs = grid[row_idx][col_idx+1..-1].all? { |height| height < grid[row_idx][col_idx]}

      top = rotated[col_idx][0..row_idx-1].all? { |height| height < grid[row_idx][col_idx]}
      bot = rotated[col_idx][row_idx+1..-1].all? { |height| height < grid[row_idx][col_idx] }

      total += 1 if rhs || lhs || top || bot
    end
  end  
  total
end

pp count_visible(grid)
