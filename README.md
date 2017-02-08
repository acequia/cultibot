# Cultibot

Gardening automation done with ESP8266 NodeMCU.

## Modules

### User setup

Initial WiFi configuration.

### Clock

Uses NTP to get the correct date and time between boots.

The device do has a RTC
but it does not have an alternative power supply.

Requires an internet connection.

### I2C

Two-wire bus communication protocol.

### Temperature and humidity sensor

Uses I2C bus.

### Relays

Electrical switches for power devices control. Uses I2C bus.

### Watering

Scheduled. Uses the clock and a relay.

### Lighting

Scheduled. Uses the clock and a relay.

### Ventilation

Sensor controlled (temperature and humidity thresholds). Uses a relay.

### IoT communication

Sends data to an IoT platform.

Requires an internet connection.

## Limitations

* WiFi password must be longer than 8 characters or it will not connect,
  this problem affects WEP authentication only.

* Initial user config time window at boot lasts 5 minutes, no more,
no matter what.

## Misc

picocom --escape s --omap crcrlf /dev/ttyUSB0

picocom manda DTR y RTS a GND

--omap no es necesario con NodeMCU

esptool.py write_flash 0x00000 bin/0x00000.bin 0x10000 bin/0x10000.bin 0x7c000 ../esp-open-sdk/esp_iot_sdk_v1.5.2/bin/esp_init_data_default.bin
