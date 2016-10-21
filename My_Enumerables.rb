#My Enumerable Methods

module Enumerable

	def my_each
		return enum_for(:my_each) unless block_given?
		i = 0
		while i < self.length
			yield(self[i])
			i += 1
		end
		return self
	end

	def my_each_with_index
		return enum_for(:my_each_with_index) unless block_given?
		i = 0
		while i < self.length
			yield(self[i], i)
			i += 1
		end
		return self
	end

	def my_select
		return enum_for(:my_select) unless block_given?
		good = []
		i = 0
		while i < self.length
			if yield(self[i])
				good << self[i]
				i += 1
			else
				i += 1
			end
		end
		return good
	end

	def my_all?
		check = true
		return check unless block_given?
		i = 0
		while i < self.length do
			if yield(self[i])
				i += 1
			else
				check = false
				i = self.length
			end
		end
		return check
	end

	def my_any?
		return true unless block_given?
		i = 0
		while i < self.length do
			if yield(self[i])
				check = true
				i = self.length
			else
				check = false
				i += 1
			end
		end
		return check
	end

	def my_none?
		return false unless block_given?
		i = 0
		while i < self.length
			if yield(self[i])
				check = false
				i = self.length
			else
				check = true
				i += 1
			end
		end
		return check
	end

	def my_count(*args)
		i = 0
		while i < self.length do
			if args
				if args.include? self[i]
					i += 1
				end
			elsif block_given?
				if yield(self[i])
					i += 1
				end
			else
				i += 1
			end
		end
		return i
	end

	def my_map
		return enum_for(:my_map) unless block_given?
		i = 0
		result = Array.new[]
		while i < self.length {result << yield(self[i])}
		return result
	end

	def my_inject(arrg, symb:)
		if arrg && :symb
			memo = self.send(:symb, arrg)
		elsif arrg && !:symb
			memo = self.my_each {|x| yield(arrg, x)}
		elsif !arrg && !:symb
			memo = self.my_each {|x| yield(x)}
		elsif !arrg && :symb
			memo = self.send(:symb)
		end
		return memo
	end

	def multiply_els
		result = self.my_inject{|a, b| a*b}
	end

	def my_map_proc(&prc)
		if prc.is_class?(Proc)
			result = Array.new
			result << self.my_each{|x| x.call(&prc)}
		else
			return enum_for(:my_map_proc)
		end
		return result
	end

	def my_map_proc_or_block(&prc)
		if prc.is_class?(Proc)
			result = Array.new
			result << self.my_map_proc.call(&prc)
		elsif block_given? && !prc.is_class?(Proc)
			result = Array.new
			result << self.my_map{|x| yield(x)}
		else
			return enum_for(:my_map_proc_or_block)
		end
		return result
	end

end
end



