lines = File.readlines('input.txt', chomp: true)

# pt 1
pp lines.slice_when { |el, next_el| next_el == '' }
     .map { |arr| arr.reject { |el| el == ''} }
     .map { |arr| arr.map(&:to_i).sum }
     .max

# pt 2
pp lines.slice_when { |el, next_el| next_el == '' }
     .map { |arr| arr.reject { |el| el == ''} }
     .map { |arr| arr.map(&:to_i).sum }
     .max(3)
     .sum