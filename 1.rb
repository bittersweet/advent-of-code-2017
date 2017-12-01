require "byebug"

def solve(input)
  numbers = input.to_s.split("").map(&:to_i)
  length = numbers.size
  first = numbers[0]

  total = 0

  previous_number = first

  numbers.each_with_index do |number, index|
    next if index == 0

    if number == previous_number
      total += number
    end

    previous_number = number

    if index == numbers.size - 1
      if number == first
        total += number
      end
    end
  end

  total
end

questions = [
  [1122, 3],
  [1111, 4],
  [1234, 0],
  [91212129, 9]
]

result = questions.map do |question|
  solve(question[0]) == question[1]
end

p result, result.all?
