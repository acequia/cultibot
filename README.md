# Cultibot

Gardening automation done with ESP8266 NodeMCU.

## Modules

### User setup

Initial WiFi configuration.

### Clock (RTC)

Uses NTP to get the correct date and time between boots.

The device do has a RTC
but it does not have an alternative power supply.

Requires an internet connection.

### I2C

Two-wire bus communication protocol.

### Temperature and humidity sensor

Uses the I2C bus or 1-Wire.

### Relays

Electrical switches for power devices control. Uses the I2C bus or GPIOs.

### Irrigation

Time-controlled. Uses the RTC and a relay.

### Lighting

Time-controlled. Uses the RTC and a relay.

### Ventilation

Sensor-controlled (temperature and humidity thresholds). Uses a relay.

### IoT communication

Sends data to an IoT platform.

Requires an internet connection.

## Limitations

* No internet connection plus reboot leave RTC out of game, time-controlled
  actuators will not work.

* WiFi password must be longer than 8 characters or it will not connect,
  this problem affects WEP authentication only.

* Initial user config time window at boot lasts 5 minutes, no more,
  no matter what.
