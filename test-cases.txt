puts [].m_all?
puts [nil, true, 99].m_all?
puts [1, 2i, 3.14].m_all?(Numeric)
puts %w[ant bear cat].m_all?(/t/)
puts %w[ant bear cat].m_all? { |word| word.length >= 4 }
puts %w[ant bear cat].m_all? { |word| word.length >= 3 }