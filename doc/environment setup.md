# SDK

## Clone SDK repository

    git clone --recursive https://github.com/pfalcon/esp-open-sdk

## Install dependencies (Arch Linux package names)

- make
- unrar
- autoconf
- automake
- libtool
- gcc
- gperf
- flex
- bison
- texinfo
- gawk
- ncurses
- expat

- python2
- python2-pyserial

  (although it's better to use [pyenv]() to have a python2 environment and then `pip install pyserial`)

- sed
- git
- unzip
- bash
- help2man
- wget
- bzip2
- libtool

## Compile the toolchain

With `STANDALONE=y` by default

    make

Add this to path

    ./xtensa-lx106-elf/bin

# Firmware

    git clone git@github.com:nodemcu/nodemcu-firmware.git

## Select Modules

Disable modules you won't be using to reduce firmware size and free up some RAM. The ESP8266 is
quite limited in available RAM and running out of memory can cause a system panic. The default
configuration is designed to run on all ESP modules including the 512 KB modules like ESP-01 and
only includes general purpose interface modules which require at most two GPIO pins.

Edit `app/include/user_modules.h` and comment-out the #define statement for modules you don't need.

## Tag Your Build

Identify your firmware builds by editing `app/include/user_version.h`

    #define NODE_VERSION    "NodeMCU 1.5.4.1+myname"
    #ifndef BUILD_DATE
    #define BUILD_DATE      "YYYYMMDD"
    #endif

## Build your build

Optionally clean the build with

    make clean

because they might be conflicting updates. Then

    make

## Flash it!

    https://github.com/espressif/esptool#writing-binaries-to-flash

Detect flash size:

    esptool.py --port /dev/ttyUSB0 flash_id

Erase flash:

    esptool.py --port /dev/ttyUSB0 erase_flash

Flash compiled files (in `nodemcu-firmware/bin`), making sure that the
reset/GND cable is plugged in, so flashboot mode is enabled:

    esptool.py write_flash 0x00000 bin/0x00000.bin 0x10000 bin/0x10000.bin

`esptool.py` uses these defaults:

    --port /dev/ttyUSB0
    --flash_mode qio
    --flash_size detect
    --flash_freq 40m
    --before default_reset
    --after hard_reset

then unplugg GND.

## Serial port communication

picocom and luatool

Install picocom to access the integrated Lua repl

    picocom -b 115200 /dev/ttyUSB0

To exit `ctrl a`, `ctrl x`

    luatool.py -b 115200 -f <archivo>

luatool is in AUR

# Referencias

[esp8266]: http://www.esp8266.com/wiki/doku.php?id=toolchain#how_to_setup_a_vm_to_host_your_toolchain
[nodemcu]: https://nodemcu.readthedocs.io/en/master/en/build/
[pyenv]: https://github.com/yyuu/pyenv

# Lua

Inside the device `init.lua` is the file loaded during boot.
