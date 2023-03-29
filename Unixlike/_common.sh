#!/bin/sh
##########################
# somni.dotfiles: Common #
##########################

### This script meant to be used as a library for some common functions.
### Executing this script directly is not very meaningful.


# Command tester
test_command() {
  # Test first argument
  command -v $1 > /dev/null 2>&1

  # Return 1 if exit code is not zero, 0 otherwise
  if [ $? -ne 0 ]; then
    return 1
  else
    return 0
  fi
}

# Command tester (exit if not found)
test_command_exit() {
  # Test command with first argument
  test_command $1

  # Exit script with code 127 when tester function not returns zero
  if [ $? -ne 0 ]; then
    echo "Command '$1' is not found. Exiting."
    exit 127
  else
    return 0
  fi
}
