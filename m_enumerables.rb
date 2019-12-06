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
  def m_any?(*args) # rubocop:disable Style/UnusedMethodArgument
    block_given? ? !m_all? { yield(self) } : !m_all?
  end

  def m_none?(*args) # rubocop:disable Style/UnusedMethodArgument
    block_given? ? m_all?(nil, true) { yield(self) } : m_all?(nil, true)
  end
end
