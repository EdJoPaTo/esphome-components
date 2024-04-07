# My ESPHome Components

This repo contains components used in my device configs.

See <https://esphome.io/> for documentation.

## Example Usage

```yaml
---
<<: !include nodemcuv2.yaml

substitutions:
  devicename: terrace

sensor:
  - !include sensor-wifi-signal.yaml
  - !include sensor-nodemcuv2-dht22.yaml
```

## Sensor Filter

After some experiments with [sensor filters](https://esphome.io/components/sensor/index.html#sensor-filters) the `exponential_moving_average` seems to work best for most up to date but not too extreme values.
Sensors like the DHT with low accuracy do not produce step curves and better sensors work good with the same method (but higher alpha).

`throttle_average` is way simpler to configure and needs less testing for a fitting alpha value but produces less steady curves.
It's good when only one of a kind sensor exists and testing is not worth the time.

`accuracy_decimals` are only used for sending out values.
Sensors with 0 or 1 decimal will also have more decimals after using filters.
A value should have at least 4 digits in total for smoother curves.
Temperature (12.345 °C) would be 5 digits which results in a smooth curve.
Pressure (1234.5 hPa) would also be 5 digits.

```yaml
accuracy_decimals: 3
update_interval: 10s
filters:
  - exponential_moving_average:
      alpha: 0.1
      send_every: 12 # 6 per minute * 2min
      send_first_at: 6
```

### Alpha

Higher `alpha` means less flattened curves more accurate to the new value.
Lower `alpha` results in flatter curves.

Low precision sensors (DHT, RSSI) should use lower alpha (like `0.01`).
Higher precision sensors (like BME280) use higher alpha (like `0.2`).
