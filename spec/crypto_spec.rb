require 'set'
require_relative '../crypto'

RSpec.describe 'Safe Unlock' do
  describe '#modify_digit' do
    it 'correctly increments and decrements digits' do
      expect(modify_digit(222, 0, -1, 3)).to eq(122)
      expect(modify_digit(222, 0, 1, 3)).to eq(322)
      expect(modify_digit(222, 1, -1, 3)).to eq(212)
      expect(modify_digit(222, 1, 1, 3)).to eq(232)
      expect(modify_digit(222, 2, -1, 3)).to eq(221)
      expect(modify_digit(222, 2, 1, 3)).to eq(223)

      expect(modify_digit(901, 1, -1, 3)).to eq(991)
      expect(modify_digit(991, 1, 1, 3)).to eq(901)
      expect(modify_digit(0, 1, 1, 3)).to eq(10)
      expect(modify_digit(0, 0, 1, 3)).to eq(100)
      expect(modify_digit(0, 1, -1, 3)).to eq(90)
      expect(modify_digit(0, 0, -1, 3)).to eq(900)
    end
  end

  describe '#reverse_return' do
    it 'returns the correct path from initial to target state' do
      initial_qs = QueueState.new(111, nil, 0)
      prev_qs = QueueState.new(110, initial_qs, 1)
      target_qs = QueueState.new(120, prev_qs, 2)
      
      expect(reverse_return(target_qs, 3)).to eq([[1, 1, 1], [1, 1, 0], [1, 2, 0]])
    end
  end

  describe '#safe_unlock' do
    it 'finds the correct path without restricted states' do
      initial_state = 0
      target_state = 111
      restricted_states = []

      path = safe_unlock(initial_state, target_state, restricted_states)
      expect(path).to eq([[0, 0, 0], [1, 0, 0], [1, 1, 0], [1, 1, 1]])
    end

    it 'finds the correct path avoiding restricted states' do
      initial_state = 212
      target_state = 111
      restricted_states = [112, 211]

      path = safe_unlock(initial_state, target_state, restricted_states)
      expect(path).to eq([[2, 1, 2], [2, 2, 2], [1, 2, 2], [1, 2, 1], [1, 1, 1]])
    end

    it 'returns nil if it can not avoid restricted states' do
      initial_state = 212
      target_state = 111
      restricted_states = [112, 121, 211, 11, 110, 101]

      path = safe_unlock(initial_state, target_state, restricted_states)
      expect(path).to eq(nil)
    end
  end
end