require 'io/console'

class RFID
    attr_accessor :uid

    # Initializes a new RFID instance with an optional UID.
    #
    # @param [String, nil] uid The UID of the RFID tag (optional).
    def initialize(uid = nil)
        self.uid = uid
    end

    # Converts the UID to a hexadecimal string.
    #
    # @return [String, nil] The UID as a hexadecimal string in uppercase, or `nil`
    #   if the conversion to integer fails.
    # @raise [ArgumentError] If the UID cannot be converted to an integer.
    def hex_uid
        begin
            Integer(uid).to_s(16).upcase
        rescue ArgumentError
            nil
        end
    end
end

if __FILE__ == $0

    rf = RFID.new

    # Main loop to continuously read input until the user quits.
    loop do
        print "Reading... ('q' to quit)\n"
        input = IO.console.noecho(&:gets).chomp

        # Exit the loop if the user enters 'q' or 'Q'.
        break if input.downcase == 'q'

        # Check if the input consists only of digits.
        if input.match?(/\A\d+\z/)
            rf.uid = input
            hex_value = rf.hex_uid

            # Display the hexadecimal value if the conversion is successful.
            if hex_value
                puts "UID (HEX): #{hex_value}"
            else
                puts "Error: UID can't be converted to hexadecimal."
            end
        else
            # Display an error message if the input contains non-digit characters.
            puts "Error: UID contains non-digit characters."
        end
    end

end
