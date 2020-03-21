A fork of the linuxserver.io [smokeping container](https://github.com/linuxserver/docker-smokeping)
with the [speedtest probe](https://github.com/mad-ady/smokeping-speedtest) installed.

Configure it by adding the probe in `Probes` and then adding an instance in `Targets.
You can get the nearest servers (and I personally pick one near an internet exchange)
by running `speedtest-cli --list | head` in the container.

#### Presentation
Make sure that the Presentation file contains the adjusted maximum value,
otherwise the overview charts will not show speedtest results.
The container already contains adjusted defaults.
```
+ overview

width = 600
height = 50
range = 10h
max_rtt = 1000000000
```

#### Probes
```
### from https://github.com/mad-ady/smokeping-speedtest
+ speedtest
binary = /usr/bin/speedtest-cli
timeout = 300
step = 3600
offset = random
pings = 3

++ speedtest-download
measurement = download

++ speedtest-upload
measurement = upload

```

#### Targets
```
++++ download_from_KPN
menu = download from KPN
title = KPN (download)
probe = speedtest-download
server = 26996
measurement = download
host = dummy.com

++++ upload_to_KPN
menu = upload to KPN
title = KPN (upload)
probe = speedtest-upload
server = 26996
measurement = upload
host = dummy.com
```
