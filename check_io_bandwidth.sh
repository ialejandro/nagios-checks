#!/bin/bash
#------------------------------------------------------------------------------
# [Ivan Alejandro Marugan] 
# 	     Check I/O Bandwidth
# 	     Only print I/O Bandwidth
#
# Dependences: ifstat [apt-get install ifstat]
#
#------------------------------------------------------------------------------
VERSION=1.1

# Exit codes
STATE_OK=0
STATE_WARNING=1
STATE_CRITICAL=2
STATE_UNKNOWN=3

# Print help
_usage() {
echo "Usage: check_io_bw.sh [-h help] -i <interface>

  -h		Print this help message
  -i		Interface (eth0, eth1...)

  Exit status:
  0  if OK
  1  if minor problems (e.g., cannot create a temp file)
  2  if serious trouble (e.g., cannot access command-line argument)
  3  unknown
  "
        exit $STATE_OK;
}

# Arguemtns
while getopts ":i:h" opt; do
	case $opt in
		h) _usage; $STATE_OK;;
		i) INTERFACE=$OPTARG;;
		\?) echo "Invalid option: -$OPTARG" >&2; _usage; exit $STATE_CRITICAL;;
		:) echo "Requiere an argument: -$OPTARG" >&2; _usage; exit $STATE_CRITICAL;;
	esac
done

# Check arguments
if [[ -z "$INTERFACE" ]]; then
	echo "Empty obligatory arguments."
	exit $STATE_CRITICAL
fi

# Check dependences
if [[ ! $(which ifstat) ]]; then
	echo "ifstat isn't installed. Please install it."
	exit $STATE_CRITICAL;
fi

# Vars
INPUT=$(ifstat -nqwz -i $INTERFACE 1 1 | tail -1 | awk '{ print $1 }')
OUTPUT=$(ifstat -nqwz -i $INTERFACE 1 1 | tail -1 | awk '{ print $2 }')
PERF_DATA="| in=${INPUT}KB/s;${INPUT};${INPUT};0 out=${OUTPUT}KB/s;${OUTPUT};${OUTPUT};0"


# Main #####################################################
if [[ "$OUTPUT" == 'n/a' || "$INPUT" == 'n/a' ]]; then
	# STATE_CRITICAL
	echo "INTERFACE DON'T WORK"
        exit $STATE_CRITICAL
else
        # STATE_OK
        echo "I/O BANDWIDTH OK - input = ${INPUT}KB/s output = ${OUTPUT}KB/s $PERF_DATA"
        exit $STATE_OK
fi
