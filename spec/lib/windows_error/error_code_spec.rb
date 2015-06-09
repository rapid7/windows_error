require 'spec_helper'

describe WindowsError::ErrorCode do

  subject(:error_code) { described_class.new(value,description) }
  let(:value) { 0x00 }
  let(:description) { "The operation completed successfully." }

  context 'with a non-number value' do
    let(:value) { "Bogus" }

    it 'will raise an ArgumentError' do
      expect{described_class.new(value,description)}.to raise_error ArgumentError,"Invalid Error Code Value!"
    end
  end

  context 'with a non-string description' do
    let(:description) { 42 }

    it 'will raise an ArgumentError' do
      expect{described_class.new(value,description)}.to raise_error ArgumentError,"Invalid Error Description!"
    end
  end

  context 'with an empty string description' do
    let(:description) { '' }

    it 'will raise an ArgumentError' do
      expect{described_class.new(value,description)}.to raise_error ArgumentError,"Invalid Error Description!"
    end
  end

  it 'sets #value based on the initializer' do
    expect(error_code.value).to eq value
  end

  it 'sets #description based on the initializer' do
    expect(error_code.description).to eq description
  end

end