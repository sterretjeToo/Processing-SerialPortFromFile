## Introduction

An example of a simple to use functionality to read a port-to-use from a configuration file in a Processing sketch. Useful when using an exported Processing sketch so one does not have to export again when there is a need to change the port.

Intended for use with a microcontroller (e.g. Arduino) where the configuration is usually fixed (baudrate, stopbits etc).

## How to use

Copy the two functions *`readPortFromFile()`* and *`chkPortExists()`* in your sketch. The basic example sketch demonstrates how you can use it; in *`setup()`* it reads the port-to-use from the specified file and opens the port.
Adjust the file *data/PortConfig.txt* to your needs. The serial port must be on the first line !

## Support
I do not actively support this. If needed, you can ask questions on https://discourse.processing.org/t/selecting-a-serial-port-using-a-configuration-file-a-quick-tip/42642 and I will hopefully see it.