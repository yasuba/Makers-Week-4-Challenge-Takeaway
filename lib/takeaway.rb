require 'twilio-ruby'

class Takeaway
	attr_reader :order

	def initialize
		@order = []
	end

	def menu
		{:green_curry => 5, :red_curry => 6}
	end

	def ring_ring
		puts "How can I help you? Choose 1 to see the menu, 2 to add items to your order or 3 to pay."
		loop do
			# how_can_i_help_you
			options
		end
	end

	def options
		answer = gets.chomp
		case answer
		when "1"
			menu.each { |key, value| p "#{key.to_s.gsub("_", " ")}: £#{value}" }
		when "2"	
			what_do_you_want
			p "To order another item, press 2, to pay, press 3." 	 
		when "3"
			pay
		when "4"
			exit
		else 
			p 'Try again'
		end
	end

	def what_do_you_want
		place_order = gets.chomp
		order_to_sym = place_order.gsub(" ", "_").to_sym
		if menu.include?(order_to_sym) 
			@order << order_to_sym
		else
			p "We don't serve that here. Please try again." if !menu.include?(order_to_sym)
		end
		all_dishes
	end

	def pay
		p "You have ordered: #{@dishes}, which comes to £#{total}. We will text to confirm your order."
		send_message
		exit
	end

	def all_dishes
		@dishes = order.map! {|i| i.to_s}.join(", ").gsub("_", " ")
	end

	def total
		new_order = order.map do |v|
			x = v.to_s.gsub(" ", "_").to_sym
			menu[x]
		end
		new_order.inject(:+)
	end

	def send_message
		@account_sid = 'AC160c8dbb0270a8f82d8a15f74a00d365'
		@auth_token = '921e633e79f2b741919176a029d33a1f'
		@client = Twilio::REST::Client.new(@account_sid, @auth_token)
		@client.messages.create(:from => '+441556730136', :to => '07817384762', :body => 'Thank you! Your order was placed and will be delivered within one hour.')
	end

end