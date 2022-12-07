lines = File.readlines('input.txt', chomp: true)

fs = Hash.new{ |h, k| h[k] = Hash.new(&h.default_proc) }
cwd = []

loop do
  break if lines.empty?

  line = lines.shift
  case line
  when /^\$/
    case line[2..-1]
    when /^cd/
      dir = line[5..-1]
      if dir == '..'
        cwd.pop
      else
        cwd << dir
      end
    when /^ls/
      while !lines.empty? && lines.first[0] != '$'
        file = lines.shift
        next unless file =~ /^(\d+)/
        match_data = file.match(/^(\d+) (.+)$/)
        fsize = match_data.captures[0].to_i
        fname = match_data.captures[1]
        fs.dig(*cwd)[fname] = fsize
      end
    end
  end
end

def total_directories(fs)
  results = Hash.new(0)
  fs.each_pair do |path, item|
    if item.is_a? Hash
      results[path] = total_directories(item)
      results[:size] += results[path][:size]
    else
      results[:size] += item
    end
  end
  results
end

# pt 1

totals = total_directories(fs)

def find_100_000(totals)
  result = 0
  totals.each_pair do |path, item|
    if item.is_a? Hash
      result += find_100_000(item)
      if item[:size] <= 100_000
        result += item[:size]
      else
        result += 0
      end
    end
  end
  result
end

pp find_100_000(totals)

# pt 2

total_disk_space = 70_000_000
needed_disk_space = 30_000_000
used_disk_space = totals[:size]
free_disk_space = total_disk_space - used_disk_space

def find_space(totals, needed, free, result = [])
  totals.each_pair do |path, item|
    if item.is_a? Hash
      result += find_space(item, needed, free)
      if item[:size] + free >= needed
        result << item[:size]
      end
    end
  end
  result
end

pp find_space(totals, needed_disk_space, free_disk_space).min