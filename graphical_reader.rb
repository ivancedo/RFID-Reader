require 'io/console'
require 'gtk3'
require_relative 'uid'

class GUI
    # Initializes the RFID interface with a GTK window and sets up the UI components.
    #
    # @return [void]
    def initialize
        # Create a new 600x300 window
        @window = Gtk::Window.new
        @window.set_title('RFID UID Reader')
        @window.set_default_size(600, 300)
        @window.override_background_color(:normal, Gdk::RGBA.new(0.1, 0.3, 0.6, 1)) # Modern blue background

        # Create a vertical box to add widgets
        vbox = Gtk::Box.new(:vertical, 10)
        vbox.margin = 20

        # Create a label to display the UID in HEX
        @label = Gtk::Label.new("Waiting for UID...")
        @label.override_color(:normal, Gdk::RGBA.new(1, 1, 1, 1))  # White text
        vbox.pack_start(@label, :expand => true, :fill => true, :padding => 10)

        # Create a button to clear the label
        clear_button = Gtk::Button.new(label: "Clear")
        clear_button.override_background_color(:normal, Gdk::RGBA.new(0.2, 0.4, 0.7, 1)) # Modern blue button
        clear_button.override_color(:normal, Gdk::RGBA.new(0, 0, 0, 1)) # Black button text
        clear_button.signal_connect('clicked') { clear_label }
        vbox.pack_start(clear_button, :expand => false, :fill => false, :padding => 10)

        # Connect the container to the window
        @window.add(vbox)

        # Connect the signal to close the window
        @window.signal_connect('destroy') { Gtk.main_quit }

        # Show all widgets
        @window.show_all

        # Start the process to read the UID from the first script
        uid_read
    end

    # Clears the label and resets it to the waiting state.
    #
    # @return [void]
    def clear_label
        @label.text = "Waiting for UID..."
    end

    # Starts the RFID reader in a separate thread and updates the GTK label
    # with the converted HEX UID.
    #
    # @return [void]
    def uid_read
        Thread.new do
            uid_inst = UID.new
            loop do
                input = IO.console.noecho(&:gets).chomp

                # Check if the input consists only of digits.
                if input.match?(/\A\d+\z/)
                    uid_inst.uid = input
                    hex_value = uid_inst.hex_uid

                    # Update the label in the GTK main thread with the HEX UID or error message
                    if hex_value
                        GLib::Idle.add { @label.text = "UID (HEX): #{hex_value}"; false }
                    else
                        GLib::Idle.add { @label.text = "Error: Can't convert UID"; false }
                    end
                else
                    GLib::Idle.add { @label.text = "Error: Invalid UID format"; false }
                end
            end
        end
    end
end

# Initialize the GTK application
Gtk.init
GUI.new
Gtk.main