class UID
    attr_accessor :uid

    # Initializes a new RFID instance with an optional UID.
    #
    # @param [String, nil] uid The UID of the RFID tag (optional).
    def initialize(uid = nil)
        self.uid = uid
    end

    # Converts the given UID to a hexadecimal string with its bytes reversed.
    #
    # @return [String, nil] The UID as a hexadecimal string in uppercase, or `nil`
    #   if the conversion to integer fails.
    # @raise [ArgumentError] If the UID cannot be converted to an integer.
    def hex_uid
        begin
            decimal_uid = uid.to_i
            bytes_array = [decimal_uid].pack('L').bytes.reverse
            decimal_array = bytes_array.pack('C*').unpack('L')
            hex_string = decimal_array[0].to_s(16).upcase
            return hex_string
        rescue ArgumentError
            nil
        end
    end
end