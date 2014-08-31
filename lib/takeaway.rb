class Takeaway
	attr_reader :order

	def initialize
		@order = []
	end

	def menu
		{:green_curry => 5, :red_curry => 6}
	end

	def ring_ring
		answer = how_can_i_help_you		
		what_do_you_want if answer == "2"
		menu.each { |key, value| p "#{key.to_s.gsub("_", " ")}: £#{value}" } if answer == "1"
	end

	def how_can_i_help_you
		puts "How can I help you? Choose 1 to see the menu, 2 to place an order and type \"x\" to stop."
		gets.chomp
	end

	def what_next
		puts "Do you want to place an order? Type \"order\""
		gets.chomp
	end

	def what_do_you_want
		order = gets.chomp
		until order == "x" do
			order_to_sym = order.gsub(" ", "_").to_sym
			if menu.include?(order_to_sym) 
				@order << order_to_sym
				order = gets.chomp
			else
				p "sowwy, cant hear you?" if !menu.include?(order_to_sym)
				order = gets.chomp
			end
		end
	end

	def total
		p order.inspect
		order.map! do |v|
			x = v.to_s.gsub(" ", "_").to_sym
			menu[x]
		end
		order.inject(:+)
	end

	# def

	# end

end