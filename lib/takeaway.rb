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
		p "How can I help you? To see the menu, type 1." 
		loop do
			options
		end
	end

	def options
		p "Choose 2 to add items to your order or 3 to pay."
		answer = gets.chomp
		case answer
		when "1"
			menu.each { |key, value| p "#{key.to_s.gsub("_", " ")}: £#{value}" }
		when "2"	
			what_do_you_want
		when "3"
			pay
		else 
			p 'Try again'
		end
	end

	def what_do_you_want
		place_order = gets.chomp
		order_to_sym = place_order.gsub(" ", "_").to_sym
		@order << order_to_sym if menu.include?(order_to_sym) 
		p "We don't serve that here. Please try again." if !menu.include?(order_to_sym)
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
		new_order = order.map {|v| x = v.to_s.gsub(" ", "_").to_sym ; menu[x] }
		new_order.inject(:+)
	end

	def send_message
		@account_sid = ''
		@auth_token = ''
		@client = Twilio::REST::Client.new(@account_sid, @auth_token)
		@client.messages.create(:from => '1234567890', :to => '1234567890', :body => 'Thank you! Your order was placed and will be delivered within one hour.')
	end

end
