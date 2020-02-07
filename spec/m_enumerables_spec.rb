require 'rspec'
require_relative '../m_enumerables.rb'

describe "Enumerable" do
  let(:arr_numbers) { Array(1..5)}
  let(:arr_words) { %w[apple orange banana] }
  let(:arr_fruits) { %w[apple orange banana bacovo guava basa] }
  describe "Given either block or array" do
    context "#my_each" do
      it "return enumerable when no block given" do
        expect([1,2,3,4,5].my_each).to be_an(Enumerator)
      end

      it "return same data with ruby each" do
        expect([1,2,3,4,5].my_each { |num|}).to eql ([1,2,3,4,5].each { |num|})
      end
    end
    
  end
end