# RFID Reader

A simple Ruby program that reads RFID UID input from the user, validates it as a numeric string, and converts it to a hexadecimal format. The program runs in a loop, allowing continuous input until the user chooses to quit.

## Features

- Reads user input for RFID UIDs.
- Validates input to ensure only numeric values are accepted.
- Reverse the UID byte order for the reader's reading method.
- Converts valid UIDs to a hexadecimal format.
- Allows the user to exit the program gracefully.

## Requirements

- Ruby (version 2.0 or higher)

## Usage

1. Clone the repository:

   ```bash
   git clone https://github.com/ivancedo/RFID-Reader.git
   cd RFID_Reader
   
1. Run program:

   ```bash
   ruby main.rb
