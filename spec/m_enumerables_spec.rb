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

    context "my_each_with_index" do
      it "return enumerable when no block given" do
        expect(arr_numbers.my_each_with_index).to be_an(Enumerator)
        
      end
      it "return an element given its index" do
        expected_output = []
        arr_words.my_each_with_index { |key, idx| 
          if idx == 1
            expected_output.push(key.to_s)
          end  
        }
        expect(expected_output).to eql (["orange"]) 
      end
    end


    
  end
end