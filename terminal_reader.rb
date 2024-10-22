require 'io/console'
require_relative 'uid'

if __FILE__ == $0

    uid_inst = UID.new

    # Main loop to continuously read input until the user quits.
    loop do
        print "Reading... ('q' to quit)\n"
        input = IO.console.noecho(&:gets).chomp

        # Exit the loop if the user enters 'q' or 'Q'.
        break if input.downcase == 'q'

        # Check if the input consists only of digits.
        if input.match?(/\A\d+\z/)
            uid_inst.uid = input
            hex_value = uid_inst.hex_uid

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