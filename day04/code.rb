lines = File.readlines('input.txt', chomp: true).map { |l| l.split(',') }

# pt 1

pp lines.map { |line| 
  line.map { |l|
    low, high = l.split('-').map(&:to_i)
    (low..high).to_a
  }
}.reject { |left, right| !(left-right).empty? && !(right-left).empty? }.count

# pt 2

pp lines.map { |line| 
  line.map { |l|
    low, high = l.split('-').map(&:to_i)
    (low..high).to_a
  }
}.reject { |left, right| (left & right).empty? }.count