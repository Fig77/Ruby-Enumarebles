# frozen_string_literal: true

require 'rspec'
require_relative '../m_enumerables.rb'

describe 'my_enumerables' do
  let(:arr_numbers) { Array(1..5) }
  let(:arr_words) { %w[apple orange banana] }
  let(:arr_fruits) { %w[apple orange banana bacovo guava basa] }
  describe 'Given either block or array' do
    context '#my_each' do
      it 'return enumerable when no block given' do
        expect([1, 2, 3, 4, 5].my_each).to be_an(Enumerator)
      end

      it 'return same data with ruby each' do
        output_my = [1, 2, 3, 4, 5].my_each { |num| }
        output_each = [1, 2, 3, 4, 5].each { |num| }
        expect(output_my).to eql output_each
      end
    end

    context 'my_each_with_index' do
      it 'return enumerable when no block given' do
        expect(arr_numbers.my_each_with_index).to be_an(Enumerator)
      end
      it 'return an element given its index' do
        expected_output = []
        arr_words.my_each_with_index do |key, idx|
          expected_output.push(key.to_s) if idx == 1
        end
        expect(expected_output).to eql ['orange']
      end
    end

    context '#my_select' do
      it 'return enumerable when no block given' do
        expect(arr_numbers.my_select).to be_an(Enumerator)
        false
      end
      it 'description' do
        expected_output = arr_fruits.my_select do |fruit|
          fruit.start_with? 'b'
        end
        expect(expected_output).to eql %w[banana bacovo basa]
      end
    end

    context '#my_all?' do
      it ' returns true if the block never returns false or nil' do
        arr1 = Array(2..9)
        expected_output = arr1.my_all? { |x| x > 1 }
        expect(expected_output).to eql true
      end
      it ' returns false if the block returns false or nil' do
        arr2 = Array(-1..7)
        expected_output = arr2.my_all? { |x| x > 1 }
        expect(expected_output).to eql false
      end

      it 'return false given a regex when any return false' do
        expected_output = %w[ant bear cat].my_all?(/t/)
        expect(expected_output).to eql false
      end

      it 'return false given a class when any return false' do
        expected_output = [1, 2, 3, 4, '5'].my_all?(Integer)
        expect(expected_output).to eql false
      end

      it 'return true given empty array ' do
        expected_output = [].my_all?
        expect(expected_output).to eql true
      end
      it 'no block if given, add { |obj| obj } return true when none of the collection  false or nil.' do
        expected_output = [nil, true, 99].my_all?
        expect(expected_output).to eql false
      end
    end

    context '#my_any?' do
      it 'return false none of the collection is true' do
        expected_output = [2, 3, 1, 6].my_any? { |x| x <= 0 }
        expect(expected_output).to eql false
      end
      it 'return true if any element in the collection is true' do
        expected_output = %w[ant bear cat].my_any? { |word| word.length >= 3 }
        expect(expected_output).to eql true
      end
      it 'given regex, return true if any element in the collection is true' do
        expected_output = %w[ant bear cat].my_any?(/d/)
        expect(expected_output).to eql false
      end
      it 'given class, return true if any element in the collection is true' do
        expected_output = [nil, true, 99].my_any? Integer
        expect(expected_output).to eql true
      end
      it 'returns true if the block ever returns a value other than false or nil' do
        expected_output = [].my_any?
        expect(expected_output).to eql false
      end
    end
  end
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
        expect((%w{cat sheep bear}.my_inject { |memo, word| memo.length > word.length ? memo : word })).to eql "sheep"
      end
    end
  end
end
