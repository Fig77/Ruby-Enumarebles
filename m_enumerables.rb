module Enumerable

	def m_each
		if block_given?
			i = 0
			while i < self.length
				yield(self[i])
				i += 1
			end
		else
			return self
		end
  end

end

my_test = [1, 2, 3, 4, 5]
print my_test.m_each