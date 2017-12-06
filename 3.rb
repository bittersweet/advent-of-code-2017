require "byebug"

@amounts = []
1000.times do |i|
  i+= 1
  @amounts << [i, i]
  # I've found that there's a pattern with amount of numbers "inserted"
end
@amounts.flatten!

def grid(count)
  # direction = right, up , left, down
  # i=0  right  2 => 1 2
  # i=1  up     2 => 2 3
  # i=2  left   3 => 3 4 5
  # i=3  down   3 => 5 6 7
  # i=4  right  4 => 7 8 9 10
  # i=5  up     4 => 10 11 12 13
  # i=6  left   5 => 13 14 15 16 17
  # i=7  down   5 => 17 19 10 20 21
  # i=8  right  6 => 21 22 23 24 25 26
  # i=9  up     6 => 26 27 28 29 30 31

  # direction = right, up , left, down
  # i=0  right  1 => 2
  # i=1  up     1 => 3
  # i=2  left   2 => 4, 5
  # i=3  down   2 => 6, 7
  # i=4  right  3 => 8, 9 10
  # i=5  up     3 => 11, 12, 13
  # i=6  left   4 => 14, 15, 16, 17
  # i=7  down   4 => 18, 19, 20, 21
  # i=8  right  5 => 22, 23, 24, 25, 26
  # i=9  up     5 => 27, 28, 29, 30, 31
  directions = ["right", "up", "left", "down"]
  grid = [
    [1]
  ]

  count.times do |i|
    direction = directions[i % directions.size]

    highest_number = grid.flatten.max
    r = grid.find {|n| n.include?(highest_number) }
    row = grid.index(r)
    column = r.index(highest_number)

    if i % 100 == 0
      puts "iteration=#{i} highest_number=#{highest_number}"
    end

    numbers_to_insert = (highest_number+1..highest_number+@amounts[i]).to_a

    case direction
    when "right"
      grid[row].push(*numbers_to_insert)
    when "up"
      # get last row
      index = grid.index(grid.last)
      numbers_to_insert.each do |number|
        index -= 1

        if index >= 0 && grid[index]
          grid[index].push(number)
        else
          grid.unshift([number])
        end
      end
    when "left"
      grid[row].unshift(*numbers_to_insert.reverse)
    when  "down"
      numbers_to_insert.each_with_index do |number, index|
        index += 1
        if grid[row + index]
          grid[row + index].unshift(number)
        else
          grid.push([number])
        end
      end
    end

    # puts "grid: #{grid}"
  end

  grid
end

@numbers = grid(1300)

def calculate(number)
  # numbers = [
  #   [17, 16, 15, 14, 13],
  #   [18, 5, 4, 3, 12],
  #   [19, 6, 1, 2, 11],
  #   [20, 7, 8, 9, 10],
  #   [21, 22, 23, 24, 25]
  # ]
  #

  r = @numbers.find {|n| n.include?(number) }
  row = @numbers.index(r)
  column = r.index(number)

  origin = @numbers.find {|n| n.include?(1) }
  origin_row = @numbers.index(origin)
  origin_column = origin.index(1)

  row_distance = if row > origin_row
    row - origin_row
  else
    origin_row - row
  end

  column_distance = if column > origin_column
    origin_column - column
  else
    column - origin_column
  end

  row_distance.abs + column_distance.abs
end

if calculate(1) != 0
  raise "incorrect code"
end
if calculate(12) != 3
  raise "incorrect code"
end
if calculate(23) != 2
  raise "incorrect code"
end
if calculate(1024) != 31
  raise "incorrect code"
end

puts calculate(347991)
