rounds = File.readlines('input.txt', chomp: true).map(&:split)

# pt 1
win_pt1 = -> (round) do
  case round
  in ['A', 'X'] | ['B', 'Y'] | ['C', 'Z']
    3
  in ['A', 'Y'] | ['B', 'Z'] | ['C', 'X']
    6
  else
    0
  end
end

value_pt1 = -> (play) do
  case play
  when 'X'
    1
  when 'Y'
    2
  when 'Z'
    3
  end
end

pp rounds.map{ win_pt1.(_1) + value_pt1.(_1.last) }.sum

# pt 2
beat = -> (play) do
  case play
  when 'A'
    'B'
  when 'B'
    'C'
  when 'C'
    'A'
  end
end

draw = -> (play) { play }

lose = -> (play) do
  case play
  when 'A'
    'C'
  when 'B'
    'A'
  when 'C'
    'B'
  end
end

action = -> (act, opponent) do
  case act
  when 'X'
    lose.(opponent)
  when 'Y'
    draw.(opponent)
  when 'Z'
    beat.(opponent)
  end
end

win_value = -> (val) do
  case val
  when 'X'
    0
  when 'Y'
    3
  when 'Z'
    6
  end
end

play_value = -> (val) do
  case val
  when 'A'
    1
  when 'B'
    2
  when 'C'
    3
  end
end

pp rounds.map{ |opp, act| play_value.(action.(act, opp)) + win_value.(act) }.sum