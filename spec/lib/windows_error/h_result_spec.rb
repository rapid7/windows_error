require 'spec_helper'
require 'windows_error/h_result'

describe WindowsError::HResult do

  describe '#find_by_retval' do

    it 'raises an argument error when passed an invalid value' do
      expect { WindowsError::HResult.find_by_retval('foo') }.to raise_error ArgumentError, 'Invalid value!'
    end

    it 'maps FACILITY_WIN32 HRESULTs to Win32 error codes' do
      expect(WindowsError::HResult.find_by_retval(0x80070547)).to match_array([WindowsError::Win32::ERROR_CANT_ACCESS_DOMAIN_INFO])
    end

    it 'returns HRESULT error codes for non-Win32 facilities' do
      expect(WindowsError::HResult.find_by_retval(0x800401f3)).to match_array([WindowsError::HResult::CO_E_CLASSSTRING])
    end

    it 'returns an empty array if there is no match' do
      expect(WindowsError::HResult.find_by_retval(0xffffffff)).to match_array([])
    end
  end
end
