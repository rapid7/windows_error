require 'spec_helper'
require 'windows_error/h_result/facility'

describe WindowsError::HResult::Facility do

  describe '#find_by_code' do

    it 'raises an argument error when passed an invalid value' do
      expect { WindowsError::HResult::Facility.find_by_code('foo') }.to raise_error ArgumentError, 'Invalid value!'
    end

    it 'returns the facility code for the supplied value' do
      expect(WindowsError::HResult::Facility.find_by_code(0x0007)).to eq WindowsError::HResult::Facility::FACILITY_WIN32
    end

    it 'returns nil if there is no matching facility code' do
      expect(WindowsError::HResult::Facility.find_by_code(0x0fff)).to be_nil
    end
  end

  describe '#find_by_h_result' do

    it 'raises an argument error when passed an invalid value' do
      expect { WindowsError::HResult::Facility.find_by_h_result('foo') }.to raise_error ArgumentError, 'Invalid value!'
    end

    it 'returns the facility code embedded in an HRESULT' do
      expect(WindowsError::HResult::Facility.find_by_h_result(0x80070547)).to eq WindowsError::HResult::Facility::FACILITY_WIN32
    end

    it 'returns nil if there is no matching facility code' do
      expect(WindowsError::HResult::Facility.find_by_h_result(0x8fff0547)).to be_nil
    end
  end
end
