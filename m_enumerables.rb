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
end
