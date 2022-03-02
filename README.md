# My ESPHome Configs

See <https://esphome.io/> for more info

## Sensor Filter

After some experiments with [sensor filters](https://esphome.io/components/sensor/index.html#sensor-filters) the combination of `exponential_moving_average` with `send_every: 1` and `heartbeat` seems to work best for most up to date but not too extreme values.
Sensors like the DHT with low accuracy do not produce step curves and better sensors work good with the same method (but higher alpha).

`accuracy_decimals` are only used for sending out values.
Sensors with 0 or 1 decimal will also have more decimals after using filters.
A value should have at least 4 digits in total for smoother curves.
Temperature (12.345 °C) would be 5 digits which results in a smooth curve.
Pressure (1234.5 hPa) would also be 5 digits.

```yaml
accuracy_decimals: 3
filters:
  - exponential_moving_average:
      alpha: 0.1
      send_every: 1
  - heartbeat: 2min
```

### Alpha

Higher `alpha` means less flattened curves more accurate to the new value.
Lower `alpha` results in flatter curves.

Low precision sensors (DHT, RSSI) should use lower alpha (like `0.01`).
Higher precision sensors (like BME280) use higher alpha (like `0.2`).
