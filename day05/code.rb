lines = File.readlines('input.txt', chomp: true)
columns = lines.map { |l| l.count('[') }.max

diagram = lines.take_while{ |l| l.count('[') > 0 }

stacks = Array.new(columns) { [] }
columns.times.with_object(stacks) do |idx, stacks|
  pos = idx * 4 + 1
  diagram.each do |line|
    stacks[idx] << line[pos]
  end
end

stacks = stacks.map { |s| s.reverse.reject { |tok| tok == ' '} }

instructions = lines.drop_while { |l| !(/move/ =~ l) }

# pt 1
part1 = instructions.each.with_object(stacks) do |i, stacks|
  move, from, to = /move (\d+) from (\d+) to (\d+)/.match(i).captures
  move = move.to_i
  from = from.to_i - 1
  to = to.to_i - 1

  stacks[to] += stacks[from].pop(move).reverse
  stacks
end

pp part1.map(&:last).join

# pt 2
stacks = Array.new(columns) { [] }
columns.times.with_object(stacks) do |idx, stacks|
  pos = idx * 4 + 1
  diagram.each do |line|
    stacks[idx] << line[pos]
  end
end

stacks = stacks.map { |s| s.reverse.reject { |tok| tok == ' '} }

part2 = instructions.each.with_object(stacks) do |i, stacks|
  move, from, to = /move (\d+) from (\d+) to (\d+)/.match(i).captures
  move = move.to_i
  from = from.to_i - 1
  to = to.to_i - 1

  stacks[to] += stacks[from].pop(move)
  stacks
end

pp part2.map(&:last).join
