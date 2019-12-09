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
      i += 1
    end
  end

  # this function is just to reduce cyclomatic complexity.

  def all_auxiliar?(arg, pattern = nil, bol = false)
    return bol unless arg
    return bol if !pattern.nil? && !(pattern === arg) # rubocop:disable Style/CaseEquality

    !bol
  end

  # bol makes this re-usable with any? and none?

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

  def m_any?(args = nil)
    if block_given?
      return true unless m_all?(nil, true) { yield(self) }
    else
      return true unless m_all?(args, true)
    end

    false
  end

  def m_none?(args = nil)
    block_given? ? m_all?(args, true) { yield(self) } : m_all?(args, true)
  end

  def m_count(arg = nil)
    cant = 0
    i = 0
    while i < length
      if block_given?
        cant += 1 if yield(self[i])
      elsif !arg.nil?
        cant += 1 if self[i] == arg
      else
        cant += 1
      end
      i += 1
    end
    cant
  end

  def m_map
    new_arr = []
    aux = to_a
    return aux unless block_given?

    aux.m_each { |i| new_arr.push(yield(i)) }
    new_arr
  end

  def m_inject(sum = nil, arg = nil)
    aux = to_a
    arg&.to_sym
    unless sum
      sum = aux[0]
      aux = aux.drop(1)
    end
    if arg.is_a? Symbol
      aux.m_each { |i| sum = sum.send(arg, i) }
    elsif block_given?
      aux.m_each { |i| sum = yield(sum, i) }
    else
      return aux
    end

    sum
  end

  # Regarding points 11, 12, 13. As far as I can understand, they are redundant.
  # 11. Creating a method  multiply_els([2,4,5]) to test my_inject is straight up using inject, but 
  #     calling the method inside this new method.
  # 11. Modify your #my_map method to take a proc instead is also redundant since you can just pass
  #     a proc to the original method by using &proc as an argument.
  # 12. Modify your #my_map method to take either a proc or a block, also seems redundant given the
  #     previus point.
end
