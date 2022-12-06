stream = File.read('input.txt').chomp

# pt 1

buffer = []

index = catch(:index) do
  stream.chars.each_with_index do |c, idx|
    buffer << c
    next if buffer.length < 4
    
    buffer.shift if buffer.length > 4
    throw :index, idx + 1 if buffer.uniq == buffer
  end
end

pp buffer.join
pp index

# pt 2

buffer = []

index = catch(:index) do
  stream.chars.each_with_index do |c, idx|
    buffer << c
    next if buffer.length < 14
    
    buffer.shift if buffer.length > 14
    throw :index, idx + 1 if buffer.uniq == buffer
  end
end

pp buffer.join
pp index