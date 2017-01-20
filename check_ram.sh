#!/bin/bash
#------------------------------------------------------------------------------
# [Ivan Alejandro Marugan] 
# 	     Check RAM
# 	     Only print RAM stats
#
#------------------------------------------------------------------------------
VERSION=1.2

# Exit codes
STATE_OK=0
STATE_WARNING=1
STATE_CRITICAL=2
STATE_UNKNOWN=3

# Print help
_usage() {
echo "Usage: check_used_ram.sh [-h help] [-u units]

  -h	    	Print this help message
  -u		Units output. Default: KB

  Units:
  b, byte	show output in bytes
  k, kilo	show output in kilobytes
  m, mega	show output in megabytes
  g, giga	show output in gigabytes
  t, tera	show output in terabytes
  p, peta	show output in petabytes

  Exit status:
  0  if OK
  1  if minor problems (e.g., cannot create a temp file)
  2  if serious trouble (e.g., cannot access command-line argument)
  3  unknown
  "
        exit $STATE_OK;
}

# Arguemtns
while getopts ":u:h" opt; do
        case $opt in
                h) _usage; exit $STATE_OK;;
                u) if [[ ! -z "$OPTARG" ]]; then
			OPTS="$OPTARG"
		   fi;;
                \?) echo "Invalid option: -$OPTARG" >&2; _usage; exit $STATE_CRITICAL;;
                :) echo "Requiere an argument: -$OPTARG" >&2; _usage; exit $STATE_CRITICAL;;
        esac
done

# Check arguments
if [[ -z "$OPTS" ]]; then
        OPTS="--kilo"
else
	case $OPTS in
		b|byte) UNIT="--byte";VALUE="b";;
		k|kilo) UNIT="--kilo";VALUE="kb";;
		m|mega) UNIT="--mega";VALUE="mb";;
		g|giga) UNIT="--giga";VALUE="gb";;
		t|tera) UNIT="--tera";VALUE="tb";;
		p|peta) UNIT="--peta";VALUE="pb";;
		\?) echo "Unit not valid"; exit $STATE_CRITICAL;;
	esac
fi

# Vars
TOTAL_RAM=$(free $UNIT | sed -sn 2p | awk '{ print $2 }')
USED_RAM=$(free $UNIT | sed -sn 2p | awk '{ print $3 }')
FREE_RAM=$(free $UNIT | sed -sn 2p | awk '{ print $4 }')
SHARED_RAM=$(free $UNIT | sed -sn 2p | awk '{ print $5 }')
BUFF_RAM=$(free $UNIT | sed -sn 2p | awk '{ print $6 }')
AVAILABLE_RAM=$(free $UNIT | sed -sn 2p | awk '{ print $7 }')
PERF_DATA="| total_ram=${TOTAL_RAM}${VALUE};;;0 used_ram=${USED_RAM}${VALUE};;;0 free_ram=${FREE_RAM}${VALUE};;;0 shared_ram=${SHARED_RAM}${VALUE};;;0 buff_ram=${BUFF_RAM}${VALUE};;;0 available_ram=${AVAILABLE_RAM}${VALUE};;;0"


# Main #####################################################
if [[ $FREE_RAM -lt 0 ]]; then
	# STATE_CRITICAL
        echo "RAM FREE CRITICAL - $FREE_RAM $PERF_DATA"
        exit $STATE_CRITICAL
else
        # STATE_OK
        echo "RAM USAGE OK - $USED_RAM $PERF_DATA"
        exit $STATE_OK
fi
