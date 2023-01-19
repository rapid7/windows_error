module WindowsError
  module HResult
    # This module provides the namespace for all of the HRESULT Facility Codes.
    # See [HRESULT](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-erref/0642cb2f-2075-4469-918c-4441e69c548a)
    # for more details on this particular set of error codes.
    module Facility
      FacilityCode = Struct.new('FacilityCode', :name, :value, :description) do
        def ==(other_object)
          if other_object.kind_of? self.class
            self.value == other_object.value
          elsif other_object.kind_of? Integer
            self.value == other_object
          elsif other_object.nil?
            false
          else
            raise ArgumentError, "Cannot compare a #{self.class} to a #{other_object.class}"
          end
        end

        alias :=== :==

        def to_s
          code = sprintf "%04x", self.value
          "(0x#{code}) #{self.name}: #{self.description}"
        end
      end

      # Return the {WindowsError::HResult::FacilityCode} object that matches
      # the value supplied.
      #
      # @param [Integer] retval the return value you want the facility code for
      # @raise [ArgumentError] if something other than a Integer is supplied
      # @return [WindowsError::HResult::FacilityCode, Nil] the FacilityCode that matched
      def self.find_by_code(retval)
        raise ArgumentError, "Invalid value!" unless retval.kind_of? Integer

        self.constants.sort.each do |constant_name|
          facility_code = self.const_get(constant_name)
          if facility_code.value == retval
            return facility_code
          end
        end
      end

      # (0x0000) The default facility code.
      FACILITY_NULL = FacilityCode.new('FACILITY_NULL', 0x0000, 'The default facility code.')

      # (0x0001) The source of the error code is an RPC subsystem.
      FACILITY_RPC = FacilityCode.new('FACILITY_RPC', 0x0001, 'The source of the error code is an RPC subsystem.')

      # (0x0002) The source of the error code is a COM Dispatch.
      FACILITY_DISPATCH = FacilityCode.new('FACILITY_DISPATCH', 0x0002, 'The source of the error code is a COM Dispatch.')

      # (0x0003) The source of the error code is OLE Storage.
      FACILITY_STORAGE = FacilityCode.new('FACILITY_STORAGE', 0x0003, 'The source of the error code is OLE Storage.')

      # (0x0004) The source of the error code is COM/OLE Interface management.
      FACILITY_ITF = FacilityCode.new('FACILITY_ITF', 0x0004, 'The source of the error code is COM/OLE Interface management.')

      # (0x0007) This region is reserved to map undecorated error codes into HRESULTs.
      FACILITY_WIN32 = FacilityCode.new('FACILITY_WIN32', 0x0007, 'This region is reserved to map undecorated error codes into HRESULTs.')

      # (0x0008) The source of the error code is the Windows subsystem.
      FACILITY_WINDOWS = FacilityCode.new('FACILITY_WINDOWS', 0x0008, 'The source of the error code is the Windows subsystem.')

      # (0x0009) The source of the error code is the Security API layer.
      FACILITY_SECURITY = FacilityCode.new('FACILITY_SECURITY', 0x0009, 'The source of the error code is the Security API layer.')

      # (0x0009) The source of the error code is the Security API layer.
      FACILITY_SSPI = FacilityCode.new('FACILITY_SSPI', 0x0009, 'The source of the error code is the Security API layer.')

      # (0x000a) The source of the error code is the control mechanism.
      FACILITY_CONTROL = FacilityCode.new('FACILITY_CONTROL', 0x000a, 'The source of the error code is the control mechanism.')

      # (0x000b) The source of the error code is a certificate client or server?
      FACILITY_CERT = FacilityCode.new('FACILITY_CERT', 0x000b, 'The source of the error code is a certificate client or server?')

      # (0x000c) The source of the error code is Wininet related.
      FACILITY_INTERNET = FacilityCode.new('FACILITY_INTERNET', 0x000c, 'The source of the error code is Wininet related.')

      # (0x000d) The source of the error code is the Windows Media Server.
      FACILITY_MEDIASERVER = FacilityCode.new('FACILITY_MEDIASERVER', 0x000d, 'The source of the error code is the Windows Media Server.')

      # (0x000e) The source of the error code is the Microsoft Message Queue.
      FACILITY_MSMQ = FacilityCode.new('FACILITY_MSMQ', 0x000e, 'The source of the error code is the Microsoft Message Queue.')

      # (0x000f) The source of the error code is the Setup API.
      FACILITY_SETUPAPI = FacilityCode.new('FACILITY_SETUPAPI', 0x000f, 'The source of the error code is the Setup API.')

      # (0x0010) The source of the error code is the Smart-card subsystem.
      FACILITY_SCARD = FacilityCode.new('FACILITY_SCARD', 0x0010, 'The source of the error code is the Smart-card subsystem.')

      # (0x0011) The source of the error code is COM+.
      FACILITY_COMPLUS = FacilityCode.new('FACILITY_COMPLUS', 0x0011, 'The source of the error code is COM+.')

      # (0x0012) The source of the error code is the Microsoft agent.
      FACILITY_AAF = FacilityCode.new('FACILITY_AAF', 0x0012, 'The source of the error code is the Microsoft agent.')

      # (0x0013) The source of the error code is .NET CLR.
      FACILITY_URT = FacilityCode.new('FACILITY_URT', 0x0013, 'The source of the error code is .NET CLR.')

      # (0x0014) The source of the error code is the audit collection service.
      FACILITY_ACS = FacilityCode.new('FACILITY_ACS', 0x0014, 'The source of the error code is the audit collection service.')

      # (0x0015) The source of the error code is Direct Play.
      FACILITY_DPLAY = FacilityCode.new('FACILITY_DPLAY', 0x0015, 'The source of the error code is Direct Play.')

      # (0x0016) The source of the error code is the ubiquitous memoryintrospection service.
      FACILITY_UMI = FacilityCode.new('FACILITY_UMI', 0x0016, 'The source of the error code is the ubiquitous memoryintrospection service.')

      # (0x0017) The source of the error code is Side-by-side servicing.
      FACILITY_SXS = FacilityCode.new('FACILITY_SXS', 0x0017, 'The source of the error code is Side-by-side servicing.')

      # (0x0018) The error code is specific to Windows CE.
      FACILITY_WINDOWS_CE = FacilityCode.new('FACILITY_WINDOWS_CE', 0x0018, 'The error code is specific to Windows CE.')

      # (0x0019) The source of the error code is HTTP support.
      FACILITY_HTTP = FacilityCode.new('FACILITY_HTTP', 0x0019, 'The source of the error code is HTTP support.')

      # (0x001a) The source of the error code is common Logging support.
      FACILITY_USERMODE_COMMONLOG = FacilityCode.new('FACILITY_USERMODE_COMMONLOG', 0x001a, 'The source of the error code is common Logging support.')

      # (0x001f) The source of the error code is the user mode filter manager.
      FACILITY_USERMODE_FILTER_MANAGER = FacilityCode.new('FACILITY_USERMODE_FILTER_MANAGER', 0x001f, 'The source of the error code is the user mode filter manager.')

      # (0x0020) The source of the error code is background copy control
      FACILITY_BACKGROUNDCOPY = FacilityCode.new('FACILITY_BACKGROUNDCOPY', 0x0020, 'The source of the error code is background copy control')

      # (0x0021) The source of the error code is configuration services.
      FACILITY_CONFIGURATION = FacilityCode.new('FACILITY_CONFIGURATION', 0x0021, 'The source of the error code is configuration services.')

      # (0x0022) The source of the error code is state management services.
      FACILITY_STATE_MANAGEMENT = FacilityCode.new('FACILITY_STATE_MANAGEMENT', 0x0022, 'The source of the error code is state management services.')

      # (0x0023) The source of the error code is the Microsoft Identity Server.
      FACILITY_METADIRECTORY = FacilityCode.new('FACILITY_METADIRECTORY', 0x0023, 'The source of the error code is the Microsoft Identity Server.')

      # (0x0024) The source of the error code is a Windows update.
      FACILITY_WINDOWSUPDATE = FacilityCode.new('FACILITY_WINDOWSUPDATE', 0x0024, 'The source of the error code is a Windows update.')

      # (0x0025) The source of the error code is Active Directory.
      FACILITY_DIRECTORYSERVICE = FacilityCode.new('FACILITY_DIRECTORYSERVICE', 0x0025, 'The source of the error code is Active Directory.')

      # (0x0026) The source of the error code is the graphics drivers.
      FACILITY_GRAPHICS = FacilityCode.new('FACILITY_GRAPHICS', 0x0026, 'The source of the error code is the graphics drivers.')

      # (0x0027) The source of the error code is the user Shell.
      FACILITY_SHELL = FacilityCode.new('FACILITY_SHELL', 0x0027, 'The source of the error code is the user Shell.')

      # (0x0028) The source of the error code is the Trusted Platform Module services.
      FACILITY_TPM_SERVICES = FacilityCode.new('FACILITY_TPM_SERVICES', 0x0028, 'The source of the error code is the Trusted Platform Module services.')

      # (0x0029) The source of the error code is the Trusted Platform Module applications.
      FACILITY_TPM_SOFTWARE = FacilityCode.new('FACILITY_TPM_SOFTWARE', 0x0029, 'The source of the error code is the Trusted Platform Module applications.')

      # (0x0030) The source of the error code is Performance Logs and Alerts
      FACILITY_PLA = FacilityCode.new('FACILITY_PLA', 0x0030, 'The source of the error code is Performance Logs and Alerts')

      # (0x0031) The source of the error code is Full volume encryption.
      FACILITY_FVE = FacilityCode.new('FACILITY_FVE', 0x0031, 'The source of the error code is Full volume encryption.')

      # (0x0032) The source of the error code is the Firewall Platform.
      FACILITY_FWP = FacilityCode.new('FACILITY_FWP', 0x0032, 'The source of the error code is the Firewall Platform.')

      # (0x0033) The source of the error code is the Windows Resource Manager.
      FACILITY_WINRM = FacilityCode.new('FACILITY_WINRM', 0x0033, 'The source of the error code is the Windows Resource Manager.')

      # (0x00000034) The source of the error code is the Network Driver Interface.
      FACILITY_NDIS = FacilityCode.new('FACILITY_NDIS', 0x00000034, 'The source of the error code is the Network Driver Interface.')

      # (0x00000035) The source of the error code is the Usermode Hypervisor components.
      FACILITY_USERMODE_HYPERVISOR = FacilityCode.new('FACILITY_USERMODE_HYPERVISOR', 0x00000035, 'The source of the error code is the Usermode Hypervisor components.')

      # (0x00000036) The source of the error code is the Configuration Management Infrastructure.
      FACILITY_CMI = FacilityCode.new('FACILITY_CMI', 0x00000036, 'The source of the error code is the Configuration Management Infrastructure.')

      # (0x00000037) The source of the error code is the user mode virtualization subsystem.
      FACILITY_USERMODE_VIRTUALIZATION = FacilityCode.new('FACILITY_USERMODE_VIRTUALIZATION', 0x00000037, 'The source of the error code is the user mode virtualization subsystem.')

      # (0x00000038) The source of the error code is  the user mode volume manager
      FACILITY_USERMODE_VOLMGR = FacilityCode.new('FACILITY_USERMODE_VOLMGR', 0x00000038, 'The source of the error code is  the user mode volume manager')

      # (0x00000039) The source of the error code is the Boot Configuration Database.
      FACILITY_BCD = FacilityCode.new('FACILITY_BCD', 0x00000039, 'The source of the error code is the Boot Configuration Database.')

      # (0x0000003a) The source of the error code is user mode virtual hard disk support.
      FACILITY_USERMODE_VHD = FacilityCode.new('FACILITY_USERMODE_VHD', 0x0000003a, 'The source of the error code is user mode virtual hard disk support.')

      # (0x0000003c) The source of the error code is System Diagnostics.
      FACILITY_SDIAG = FacilityCode.new('FACILITY_SDIAG', 0x0000003c, 'The source of the error code is System Diagnostics.')

      # (0x0000003d) The source of the error code is the Web Services.
      FACILITY_WEBSERVICES = FacilityCode.new('FACILITY_WEBSERVICES', 0x0000003d, 'The source of the error code is the Web Services.')

      # (0x00000050) The source of the error code is a Windows Defender component.
      FACILITY_WINDOWS_DEFENDER = FacilityCode.new('FACILITY_WINDOWS_DEFENDER', 0x00000050, 'The source of the error code is a Windows Defender component.')

      # (0x00000051) The source of the error code is the open connectivity service.
      FACILITY_OPC = FacilityCode.new('FACILITY_OPC', 0x00000051, 'The source of the error code is the open connectivity service.')

    end
  end
end
