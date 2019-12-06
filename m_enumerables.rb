# frozen_string_literal: true

module Enumerable
  def m_each
    return self unless block_given?

    i = 0
    while i < length
      yield(self[i])
      i += 1
    end
  end

  def m_each_with_index
    return self unless block_given?

    i = 0
    while i < length
      yield(self[i], i)
      i += 1
    end
  end

  def m_select
    return self unless block_given?

    new_vector = []
    i = 0
    while i < length 
      new_vector.push(self[i]) if yield(self[i])
    end
  end

  # this function is just to reduce cyclomatic complexity.

  def all_auxiliar?(arg, pattern = nil, bol = false)
    return bol unless arg
    return bol if !pattern.nil? && !(pattern === arg) # rubocop:disable Style/CaseEquality

    !bol
  end

  def m_all?(pattern = nil, bol = false)
    i = 0
    ans = true
    while i < length
      ans = false # rubocop:disable Lint/UselessAssignment
      if block_given?
        break unless all_auxiliar?(yield(self[i]), nil, bol)
      end
      break unless all_auxiliar?(self[i], pattern, bol)

      ans = true
      i += 1
    end
    ans
  end

  # not implemented untill none.
  def m_any?(args = nil) # rubocop:disable Style/UnusedMethodArgument
    if block_given?
      return true unless m_all?(nil, true) { yield(self) }
    else
      return true unless m_all?(args, true)
    end

    false
  end

  def m_none?(args = nil) # rubocop:disable Style/UnusedMethodArgument
    block_given? ? m_all?(args, true) { yield(self) } : m_all?(args, true)
  end
end

puts [1, 3.14, 42].none?(Float)
puts [].m_none?
puts [nil].m_none?
puts [nil, false].m_none?
puts [nil, false, true].m_none?

puts %w[ant bear cat].m_any? { |word| word.length >= 3 } #=> true
puts %w[ant bear cat].m_any? { |word| word.length >= 4 } #=> true
puts %w[ant bear cat].m_any?(/d/)                        #=> false
puts [nil, true, 99].m_any?(Integer)                     #=> true
puts [nil, true, 99].m_any?                              #=> true
puts [].m_any?                                           #=> false
