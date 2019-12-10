# frozen_string_literal: true

module Enumerable
  def my_each
    return to_enum unless block_given?

    arr = is_a?(Array) ? self : to_a
    i = 0
    while i < length
      yield(arr[i])
      i += 1
    end
  end

  def my_each_with_index
    return to_enum unless block_given?

    arr = is_a?(Array) ? self : to_a
    i = 0
    while i < arr.length
      yield(arr[i], i)
      i += 1
    end
  end

  def my_select
    return to_enum unless block_given?

    new_vector = []
    arr = is_a?(Array) ? self : to_a
    i = 0
    while i < arr.length
      new_vector.push(arr[i]) if yield(arr[i])
      i += 1
    end
    new_vector
  end

  # this function is just to reduce cyclomatic complexity.
  # will return false if the value you are looking for is not there.

  def all_auxiliar?(arg, pattern = nil, bol = false)
    return bol unless arg
    return bol if !pattern.nil? && !(pattern === arg) # rubocop:disable Style/CaseEquality

    !bol
  end

  # bol makes this re-usable with any? and none?
  # telling the method what to look for to return false.

  def my_all?(pattern = nil, bol = false)
    i = 0
    ans = true
    while i < length
      ans = false # rubocop:disable Lint/UselessAssignment
      if block_given?
        break unless all_auxiliar?(yield(self[i]), nil, bol)
      else
        break unless all_auxiliar?(self[i], pattern, bol)
      end

      ans = true
      i += 1
    end
    ans
  end

  # uses the all function to look for a true value, and instantly return true
  # if found.

  def my_any?(args = nil)
    if block_given?
      return true unless my_all?(nil, true, &proc)
    else
      return true unless my_all?(args, true)
    end

    false
  end

  def my_none?(args = nil)
    block_given? ? my_all?(args, true, &proc) : my_all?(args, true)
  end

  def my_count(arg = nil)
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

  def my_map
    new_arr = []
    aux = to_a
    return to_enum unless block_given?

    aux.my_each { |i| new_arr.push(yield(i)) }
    new_arr
  end

  def my_inject(sum = nil, arg = nil)
    aux = to_a
    init = sum
    if sum.nil? || sum.is_a?(Symbol)
      init = aux[0]
      aux = aux.drop(1) # placeholder solution so the first value does not compute twice.
      arg = sum
    end
    if arg.is_a? Symbol
      aux.my_each { |i| init = init.send(arg, i) }
    elsif block_given?
      aux.my_each { |i| init = yield(init, i) }
    else
      return aux
    end

    init
  end

  # Regarding points 11, 12, 13. As far as I can understand, they are redundant.
  # 11. Creating a method  multiply_els([2,4,5]) to test my_inject is straight up using inject, but
  #     calling the method inside this new method.
  # 11. Modify your #my_map method to take a proc instead is also redundant since you can just pass
  #     a proc to the original method by using &proc as an argument.
end

# Explicit point 12. (Implicit point 12 in test cases)
def multyply_els (arr)
    arr.my_inject(:*)
end
puts multyply_els([2, 4, 5])