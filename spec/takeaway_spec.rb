require 'takeaway'

describe Takeaway do

	before(:each) do
		allow(takeaway).to receive(:send_message)
	end

	let(:takeaway) {Takeaway.new}

	it 'should have a menu of dishes with prices' do
		expect(takeaway.menu).to eq({:green_curry => 5, :red_curry => 6})
	end

	it "prints out the menu when prompted" do
		allow(takeaway).to receive(:gets).and_return("1")
		takeaway.options
		expect(takeaway.options).to eq({:green_curry => 5, :red_curry => 6})
	end

	it 'should be able to take an order' do
		allow(takeaway).to receive(:gets).and_return("2")
		expect(takeaway).to receive(:what_do_you_want)
		takeaway.options
	end

	it 'should receive input when asked what do you want' do
		expect(takeaway).to receive(:gets).and_return("red curry\n")
		takeaway.what_do_you_want
	end
		
	it 'should add dishes to the order' do
		allow(takeaway).to receive(:gets).and_return("green curry\n")
		takeaway.what_do_you_want
		expect(takeaway.order).to eq (["green_curry"])
	end

	context 'adding multiple dishes to the order' do
		
		before(:each) do
			allow(takeaway).to receive(:order).and_return(["red curry", "green curry"])
		end

		it 'should list all dishes ordered' do
			expect(takeaway.all_dishes).to eq("red curry, green curry")
		end
		
		it 'should add the prices together' do
			expect(takeaway.total).to eq 11
		end

	end

		it 'should take payment' do
			allow(takeaway).to receive(:gets).and_return("3")
			expect(takeaway).to receive(:pay)
			takeaway.options
		end

		it 'should send a confirmation text message and exit the program' do
			begin 
				takeaway.pay 
				rescue SystemExit 
			end
			expect{takeaway.pay}.to raise_error SystemExit
		end

end