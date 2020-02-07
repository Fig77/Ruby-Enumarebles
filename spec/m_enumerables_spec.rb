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
end
