
def load
  File
    .readlines('input.txt', chomp: true)
    .map(&:split)
    .map { |(ins, value)| value ? [ins, value.to_i] : [ins] }
end

instructions = load

x = 1
cycle = 0
working = false
values = []

loop do
  cycle += 1
  
  action = case instructions.first
  in ['noop']
    -> { instructions.shift }
  in ['addx', val] if !working
    -> { working = true }
  in ['addx', val] if working
    -> { working = false; x += val; instructions.shift }
  end

  values << cycle * x if cycle == 20 || (cycle + 20) % 40 == 0

  action.call

  break if instructions.empty?
end

pp values.sum

# pt 2

instructions = load
cycle = 0
x = 1
working = false

loop do
  cycle += 1
  
  action = case instructions.first
  in ['noop']
    -> { instructions.shift }
  in ['addx', val] if !working
    -> { working = true }
  in ['addx', val] if working
    -> { working = false; x += val; instructions.shift }
  end

  pos = (cycle % 40) - 1
  pos = 39 if pos == -1 && cycle > 1
  if (x-1..x+1).include?(pos)
    print '#'
  else
    print '.'
  end

  # pp ["X=#{x}", x-1, x+1, pos]


  puts " #{cycle} \n" if cycle % 40 == 0

  action.call

  break if instructions.empty?
end
