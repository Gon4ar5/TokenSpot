require 'set'
require 'pry'

class QueueState
  attr_accessor :state, :prev_state, :checked

  def initialize(state, prev_state, checked = false)
    @state = state
    @prev_state = prev_state
    @checked = checked
  end

  def mark_as_checked
    @checked = true
  end
end

def reverse_return(qs, n)
  path = []
  while qs
    padded_state = qs.state.digits.reverse
    padded_state = [0] * (n - padded_state.size) + padded_state
    path << padded_state
    qs = qs.prev_state
  end
  path.reverse
end

def modify_digit(number, index, step, n)
  digits = number.digits.reverse # 11 -> [1, 1]
  digits += [0] * (n - digits.size) if digits.size < n # [1, 1] -> [0, 1, 1]
  digits[index] = (digits[index] + step) % 10 # added step and if it over 10, then cut it off
  digits[index] += 10 if digits[index] < 0 # if it over 0, then add 10
  digits.join.to_i
end

def safe_unlock(initial_state, target_state, restricted_states, size)
  queue = [QueueState.new(initial_state, nil)]
  visited = Set.new([initial_state])
  restricted_set = Set.new(restricted_states)

  until queue.empty?
    qs = queue.shift

    size.times do |n|
      [1, -1].each do |step|
        new_state = modify_digit(qs.state, n, step, size)

        next if restricted_set.include?(new_state) || visited.include?(new_state)

        new_qs = QueueState.new(new_state, qs)
        return reverse_return(new_qs, size) if new_state == target_state

        queue << new_qs
        visited.add(new_state)
      end
    end

    qs.mark_as_checked
  end

  nil
end

file_path = 'input.txt'
lines = File.readlines(file_path).map(&:strip)

N = lines[0].to_i
initial_arr = eval(lines[1])
target_arr = eval(lines[2])
restricted_arrs = eval(lines[3])

path = safe_unlock(initial_arr.join.to_i, target_arr.join.to_i, restricted_arrs.map(&:join).map(&:to_i), N)

if path
  path.each {|arr| p arr }
  path
else
  'Impossible'
end