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

  def m_all?
    i = 0
    while i < length
      if block_given? && !yield(self[i])
        return false 
      elsif !self[i]
        return false
      end
    end
  end
end
