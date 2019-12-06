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

  def shitIsfalse?(arg, pattern = nil)
    return false if !arg 
    return false if !pattern.nil? && !(pattern === arg) # rubocop:disable Style/CaseEquality
    return true
  end

  def m_all?(pattern = nil)
    i = 0
    ans = true
    while i < length
      ans = false # rubocop:disable Lint/UselessAssignment
      if block_given?
        break if !shitIsfalse?(yield(self[i]))
      end
      break if !shitIsfalse?(self[i], pattern)
      ans = true
      i += 1
    end
    ans
  end

  def m_any?(*args) # rubocop:disable Style/UnusedMethodArgument
    block_given? ? !m_all? { yield(self) } : !m_all?
  end
end

