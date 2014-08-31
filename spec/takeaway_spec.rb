require 'takeaway'

describe Takeaway do

	let(:takeaway) {Takeaway.new}

	it 'should have a menu of dishes with prices' do
		expect(takeaway.menu).to eq({:green_curry => 5, :red_curry => 6})
	end

	it "prints out the menu when prompted" do
		expect(takeaway).to receive(:how_can_i_help_you).and_return("1")
		expect(takeaway.ring_ring).to eq({:green_curry => 5, :red_curry => 6})
	end

	it 'should be able to take an order' do
		allow(takeaway).to receive(:how_can_i_help_you).and_return("2")
		expect(takeaway).to receive(:what_do_you_want)
		takeaway.ring_ring
	end

	it 'should receive input when asked what do you want' do
		expect(takeaway).to receive(:gets).and_return("red curry\n")
		allow(takeaway).to receive(:gets).and_return("x\n")
		takeaway.what_do_you_want
	end

	it 'should add dishes to the order' do
		allow(takeaway).to receive(:gets).and_return("green curry\n")
		allow(takeaway).to receive(:gets).and_return("x\n")
		takeaway.what_do_you_want
		expect(takeaway.order).to eq ([:green_curry])
	end

	xit 'should continue to ask for dishes until the customer is done' do
		allow(takeaway).to receive(:order).and_return(["red curry\n"])
		allow(takeaway).to receive(:order).and_return(["red curry\n"])
		takeaway.what_do_you_want
		# allow(takeaway).to receive(:gets).and_return("green curry\n")
		
		expect(takeaway.order).to eq {[:red_curry, :red_curry]}
	end

	it 'should add the prices together' do
		allow(takeaway).to receive(:order).and_return(["red curry", "green curry"])
		expect(takeaway.total).to eq 11
	end

	

end