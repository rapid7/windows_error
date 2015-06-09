module WindowsError

  # This is the core class that represents a Windows Error Code.
  # It maps the error code value to the description of the error
  # according to Microsoft documentation found at https://msdn.microsoft.com/en-us/library/cc231196.aspx
  class ErrorCode
    # @return [String] the description of the error the code represents
    attr_reader :description
    # @return [Fixnum] the error code that was given as a return value
    attr_reader :value

    def initialize(value,description)
      raise ArgumentError, "Invalid Error Code Value!" unless value.kind_of? Fixnum
      raise ArgumentError, "Invalid Error Description!" unless description.kind_of? String and !(description.empty?)
      @value = value
      @description = description
      @value.freeze
      @description.freeze
      self.freeze
    end

    def ==(other_object)
      if other_object.kind_of? self.class
        self.value == other_object.value
      elsif other_object.kind_of? Fixnum
        self.value == other_object
      else
        raise ArgumentError, "Cannot compare a #{self.class} to a #{other_object.class}"
      end
    end
  end
end
