require 'rspec'
require_relative '../m_enumerables.rb'

describe 'm_enumerables' do
  describe '#my_inject' do
  	context "given a symbol of an operator" do
  		it "will sume given numbers" do
  		  expect((5..10).my_inject(:+)).to eq ((5..10).inject(:+))
  		end
  		it "will multiply given numbers" do
  			expect((5..10).my_inject(:*)).to eq ((5..10).inject(:*))
  		end
  	end
  	context "it can receive a block" do 
  		it "given a block will return statement with said blocks instruction" do
  			expect((5..10).my_inject { |sum, n| sum + n }).to be 45
  			expect((5..10).my_inject { |sum, n| sum * n }).to eq ((5..10).inject { |sum, n| sum * n })
  			expect((%w{ cat sheep bear }.my_inject { |memo, word| memo.length > word.length ? memo : word })).to eql "sheep"
  		end
  	end
  end
  describe '#my_none' do
  	context 'Block given with condition inside' do
  		it 'Should return true if block never returns true' do
  		  expect(%w{ant bear cat}.my_none? { |word| word.length == 5 }).to be true
  	  end
  	  it 'Should return false if every element of block is true' do
				expect(%w{ant bear cat}.my_none? { |word| word.length >= 4 }).to be false
  	  end
    context 'If pattern is supplied, returns false if pattern === element of block.' do
    	it 'Should return true given pattern is not on any element' do
    		expect(%w{ant bear cat}.my_none?(/d/)).to be true
    	end 
    	it 'Should return false given pattern has element with pattern' do
    		expect([1, 3.14, 42].my_none?(Float)).to be false
    	end
    	context 'If no block nor pattern is given, return true if every is true or nil' do
    		it 'returns true if elements are false or nil' do
    		  expect([].my_none?).to be true
					expect([nil].my_none?).to be true
					expect([nil, false].my_none?).to be true
    	  end
    	  it 'returns false given at least one element is true' do
    	  	expect([nil, false, true].my_none?).to be false
    	  end
    end
    end
    end
  end
  describe '#my_count' do
  	context 'Returns the number of items in enum up to argument number (if given).' do
  		it 'will return number of items' do
  			expect([1, 2, 4, 2].my_count).to be 4
  			expect([1, 2, 4, 2].my_count(2)).to be 2
  		end
  		it 'Will return number of items true to a block, if block is given' do
  			expect([1, 2, 4, 2].my_count{ |x| x%2==0 } ).to be 3
  	  end
  	end
  end
  describe '#my_map' do
  	context 'Returns a new array with the results of running block once for every element in enum' do
  	  it 'should return an array with blocks result ' do 
  	  	expect((1..4).my_map { |i| i*i } ).to eq ((1..4).map{ |i| i*i })
  	  	expect((1..4).my_map { "cat" } ).to eq ((1..4).map{ |i| "cat" })
  	  end
  	  it 'should return an enumerator if no block is given' do
  	  	expect((1..4).my_map).to eq Enumerator
  	  end
  	end
  end
end
