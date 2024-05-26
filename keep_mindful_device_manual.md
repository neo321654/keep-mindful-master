# Keep Mindful device manual.

## Information on working with GATT.

### Services:

There will be one main service on the device, which will contain
characteristics for writing and reading commands. The service GUID must
be written in 128-bit form (more
information
[<u>https://learn.adafruit.com/introduction-to-bluetooth-low-energy/gatt</u>](https://learn.adafruit.com/introduction-to-bluetooth-low-energy/gatt)).

Example:

Service GUID: 1acd4a22-ba7d-44d8-9ff4-5639a3ee3e79
</br>

### Characteristics:

The device will have two main characteristics. One characteristic will be used for
reading, other one will be used for writing. The GUID format of the
characteristics should also be written in 128-bit form.

Example:

Read GUID: 35b0575a-08f5-45be-ada9-4ca8c90590ef

Write GUID: 506bca37-01a5-457e-b337-f669bb464d2e
</br>

## Information on working with commands.

### Sending commands:

Sending commands is done through the command recording characteristic.

Example:

AA 01 01 06 c0 a8 01 01 1F 90 19 EF

> 1\. A.A – defines the beginning of the command;
>
> 2\. 01 – command;
>
> 3\. 01 – key;
>
> 4\. 06 – number of bytes of value;
>
> 5\. c0 a8 01 01 1F 90 – a value that is 192168118080 (192.168.1.1:
> 8080), each value must be converted to hex;
>
> 6\. 19 – checksum, the formula for calculation is given below;
>
> 7\. EF – defines the end of bytes.

The checksum is calculated using the formula:

*int bytesSum = 0xc0 + 0xa8 + 0x01 + 0x01 + 0x1F + 0x90;*

*int result = bytesSum & 255; // Perform the AND operation*

*print(unsignedByte.toRadixString(16).padLeft(2, '0')) // Output the
result as an unsigned byte*

*// Checksum is equal to 19*

</br>

### Receiving commands:

The values are read using the command reading characteristic.

Example (battery):

AA 02 02 01 03 03 EF

> 1\. A.A – defines the beginning of the command;
>
> 2\. 02 – command;
>
> 3\. 02 – key;
>
> 4\. 01 – number of bytes of value;
>
> 5\. 03 – value, in this case from 1 to 4;
>
> 6\. 03 – checksum (see sending commands);
>
> 7\. EF – defines the end of the command.
</br>

### List of commands

| Command              | Key  | Information                                                                        |
|----------------------|------|------------------------------------------------------------------------------------|
| 0x01 (Write)         | 0x01 | Example, not used                                                                  |
|                      | 0x02 | Find Ring (Enable/Disable)                                                         |
|                      | 0x03 | Change device name                                                                 |
|                      | 0x04 | Unpair                                                                             |
|                      | 0x05 | Set time                                                                           |
|                      | 0x06 | Set date                                                                           |
|                      | 0x07 | Update firmware                                                                    |
|                      | 0x08 | Setting the timer                                                                  |
|                      | 0x09 | Setting the duration (Timer)                                                       |
|                      | 0x0A | Setting the interval (Timer)                                                       |
|                      | 0x0B | Device notification type (Vibration or shock) + Notification intensity (Timer)     |
|                      | 0x0C | Notification check (Timer)                                                         |
|                      | 0x0D | Setting the metronome values                                                       |
|                      | 0x0E | Device notification Type (Vibration or Shock) + Notification Intensity (Metronome) |
|                      | 0x0F | Notification Check (Metronome)                                                     |
|                      | 0x10 | Setting the alarm values                                                           |
|                      | 0x11 | Disable all alarms until now                                                       |
|                      | 0x12 | Set language                                                                       |
| 0x02 (Read)          | 0x01 | Firmware version number                                                            |
|                      | 0x02 | Battery status                                                                     |
| 0x03 (Notifications) | 0x01 | Ring found                                                                         |
|                      | 0x02 | Ring reset when holding reset button                                               |
</br>

### Commands descriptions

#### 1.1.Find the ring (0x02)

| Value 1 byte |             |
|--------------|-------------|
| 0 - enable   | 1 - disable |

> Query:
>
> Enabling:
>
> AA 01 02 01 01 01 EF
>
> Disabling:
>
> AA 01 02 01 00 00 EF
</br>

#### 1.2.Change device name (0x03)

String could be a UTF8 encoded. 

| Value 0-40 bytes |
|------------------|
| Device name      |

> Request:
>
> “My ring”
>
> AA 01 03 07 4d 79 20 72 69 6e 67 96 EF
</br>

#### 1.3.Unpair (0x04)

> No values required, just command + key
>
> Request:
>
> AA 01 04 00 00 EF
</br>

#### 1.4.Set time (0x05)

| Value 2 bytes |                 |
|---------------|-----------------|
| Hours 00 – 23 | Minutes 00 - 59 |

> Request:
>
> Example: 22:30
>
> AA 01 05 02 16 1e 34 EF
</br>

#### 1.5.Set date (0x06)

| Value 4 bytes |            |          |                     |
|---------------|------------|----------|---------------------|
| Year 00-99    | Month 1-12 | Day 1-31 | Day of the week 1-7 |

> Request:
>
> Example: 2023 12 29 5
>
> AA 01 06 04 17 0c 1d 05 45 EF
</br>

#### 1.6.Update firmware (0x07)

> Information must be obtained from the manufacturer.
</br>

#### 1.7.Setting the timer (0x08)

The timer provides the ability to enter a time interval (countdown
timer), indicating after how long the gadget will begin to vibrate.

By default, if no duration is specified, then every minute after the
timer has passed and the first vibration has occurred, these vibration
actions will be repeated once per minute and will end exactly one hour
after the first vibration.

| Value 5 bytes |            |          |               |                 |
|---------------|------------|----------|---------------|-----------------|
| Year 00-99    | Month 1-12 | Day 1-31 | Hours 00 – 23 | Minutes 00 - 59 |

> Request:
>
> Example: 2023.12.29, 22:30
>
> AA 01 08 05 17 0c 1d 16 1e 74 EF
>
> To reset the timer, use the 00 value:
>
> AA 01 08 00 00 EF
</br>

#### 1.8.Setting the timer duration (0x09)

We have the time of the first vibration (timer time), for example
after 12 minutes 15 seconds. This means the user can specify a
duration of no less than 12 minutes 15 seconds. For example, enter 17
minutes 30 seconds. This means the first vibration will be 12 minutes
15 seconds after starts the timer and will play every 15 seconds
(specified interval) until 17 minutes 30 seconds from the start of the
timer.

As sum: the timer indicates the time of the first vibration. Duration
serves as a limit for the last vibration.

| Value 5 bytes |            |          |               |                 |
|---------------|------------|----------|---------------|-----------------|
| Year 00-99    | Month 1-12 | Day 1-31 | Hours 00 – 23 | Minutes 00 - 59 |

> Request:
>
> Example: 2023.12.29, 22:30
>
> AA 01 09 05 17 0c 1d 16 1e 74 EF
>
> To reset the timer duration, use the 00 value:
>
> AA 01 09 00 00 EF
</br>

#### 1.9.Setting the timer interval (0x0A)

| Value 2 bytes   |                 |
|-----------------|-----------------|
| Minutes 00 – 59 | Seconds 00 - 59 |

> Request:
>
> Example: 30:15
>
> AA 01 0A 02 1e 0f 2d EF
</br>

#### 1.10.Notification type on device (Vibration or shock) + Notification intensity (Timer) (0x0B)

| Value 2 bytes           |                    |
|-------------------------|--------------------|
| 0 – Vibration 1 - Shock | Intensity 00 - 100 |

> Request:
>
> Example: Shock with intensity of 100
>
> AA 01 0B 02 01 64 65 EF
</br>

#### 1.11.Checking the timer notification (0x0C)

> Request:
>
> No values, only key + command
>
> AA 01 0C 00 00 EF
</br>

#### 1.12.Setting metronome values (0x0D)

| Value 3 bytes |           |                                    |
|---------------|-----------|------------------------------------|
| BPM 0 - 240   | Tact 1-10 | Skip 1 bar 0 - don't skip 1 - skip |

> Request:
>
> Example: 240, 4, 1
>
> AA 01 0D 03 f0 04 01 f5 EF
>
> To reset we use the values ​​00:
>
> AA 01 0D 00 00 EF
</br>

#### 1.13.Notification type on device (Vibration or shock) + Notification intensity (Metronome) (0x0E)

| Value 2 bytes           |                    |
|-------------------------|--------------------|
| 0 – Vibration 1 - Shock | Intensity 00 - 100 |

> Request:
>
> Example: Shock with intensity of 100
>
> AA 01 0E 02 01 64 65 EF
</br>

#### 1.14.Checking the metronome notification (0x0F)

> Request:
>
> No values, only key + command
>
> AA 01 0F 00 00 EF
</br>

#### 1.15.Setting alarm values (0x10)

> Each date will be separated by a comma if there is another date after
> it.

| Value N bytes |            |          |               |                 |                                        |
|---------------|------------|----------|---------------|-----------------|----------------------------------------|
| Year 00-99    | Month 1-12 | Day 1-31 | Hours 00 – 23 | Minutes 00 - 59 | “00” is added if there is another date |

Request:

Example:

Dates – 09/23/29 5:00, 12/23/29 13:00, 12/23/29 15:00

AA 01 10 11 17 09 1d 05 00 00 17 0c 1d 0d 00 00 17 0c 1d 0f 00 de EF

</br>

#### 1.16.Disable all alarms until the current time (0x11)

If an alarm clock triggered, and after it another one triggered. Then when turn off command sent, both of them will be turned off

> Request:
>
> No values, only key + command
>
> AA 01 11 00 00 EF
</br>

#### 1.17.Setting the language (0x12)

| Value 1 byte                        |
|-------------------------------------|
| Language number, default to English |

> Request:
>
> Example: 1 - RU
>
> AA 01 12 01 01 01 EF
</br>

#### 2.1.Firmware number (0x01)

> Request:
>
> No values, only key + command
>
> AA 02 01 00 00 EF
>
> Answer:

| Value 1 byte    |
|-----------------|
| Firmware number |

> AA 02 01 01 01 01 EF
</br>

#### 2.2.Battery (0x02)

> Request:
>
> No values, only key + command
>
> AA 02 02 00 00 EF
>
> Answer:

| Value 1 byte                                 |
|----------------------------------------------|
| Battery charge 1-4, where the minimum is one |

> AA 02 02 01 01 01 EF
</br>

#### 3.1.Ring found (0x01)

> Answer:
>
> No values, only key + command
>
> AA 03 01 00 00 EF
</br>

#### 3.2.Full ring reset when holding reset button (0x02)

> Answer:
>
> No values, only key + command
>
> AA 03 02 00 00 EF
</br>

## Questions:

1\. How should the device's energy saving feature work?

2\. Provide information about how to update firmware of ring.

3\. Will it be possible to change the language on the device (ring)?

4\. Provide the correct device service and characteristics GUIDs. Described in more detail in the block "Information on working with GATT."
