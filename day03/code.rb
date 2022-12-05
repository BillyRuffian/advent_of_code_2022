lines = File.readlines('input.txt', chomp: true).map(&:chars)

priorities = {}
('a'..'z').each.with_object(priorities).with_index do |(char, priorities), index|
  priorities[char] = index + 1
  priorities
end

('A'..'Z').each.with_object(priorities).with_index do |(char, priorities), index|
  priorities[char] = index + 27
  priorities
end

rucksacks = lines.map { |r| r.each_slice(r.size / 2).to_a }

# pt 1

pp rucksacks
     .map { |(left, right)| left.intersection(right) }
     .map { |items| items.map { |item| priorities[item] }.sum }
     .sum

#  pt 2

pp lines
     .each_slice(3)
     .flat_map { |(a, b, c)| a.intersection(b).intersection(c) }
     .map { |item| priorities[item] }
     .sum