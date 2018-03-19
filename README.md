# Nagios Plugins

## Templates PNP4NAGIOS
Put into `/etc/pnp4nagios/templates/` directory.

## Checks
### Check I/O Bandwidth

Requirements:
* ifstat (apt-get install ifstat)

Usage:
```bash
Usage: check_io_bw.sh [-h help] -i <interface>

  -h	Print this help message
  -i	Interface (eth0, eth1...)
```

Result:
```bash
I/O BANDWIDTH OK - input = 0.06KB/s output = 0.00KB/s | in=0.06KB/s;0.06;0.06;0 out=0.00KB/s;0.00;0.00;0
```

### Check RAM (SWAP, FREE, USED...)

Usage:
```bash
Usage: check_used_ram.sh [-h help] [-u units]

  -h    print this help message
  -u	Units output. Default: KB

  Units:
  b, byteshow output in bytes
  k, kiloshow output in kilobytes
  m, megashow output in megabytes
  g, gigashow output in gigabytes
  t, terashow output in terabytes
  p, petashow output in petabytes	
```

Result:
```bash
RAM USAGE OK - 67480 | total_ram=504268;;;0 used_ram=67480;;;0 free_ram=163084;;;0 shared_ram=5248;;;0 buff_ram=273688;;;0 available_ram=418512;;;0
```
