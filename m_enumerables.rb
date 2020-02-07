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
    arr
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

  def all_auxiliar?(arg, pattern = nil, bol = false)
    return bol unless arg
    return bol if !pattern.nil? && !(pattern === arg)

    !bol
  end

  def my_all?(pattern = nil, bol = false)
    i = 0
    while i < length
      if block_given?
        return all_auxiliar?(yield(self[i]), nil, bol) unless all_auxiliar?(yield(self[i]), nil, bol)

      else
        return all_auxiliar?(self[i], pattern, bol) unless all_auxiliar?(self[i], pattern, bol)

      end
      i += 1
    end
    true
  end

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
      aux = aux.drop(1)
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
end

def multyply_els(arr)
  arr.my_inject(:*)
end
