<?php
#
# Copyright (c) 2016 Ivan Alejandro (ialejandro.rocks)
# Plugin: check_io_bw.sh
#

$opt[1]  = "--vertical-label \"$UNIT[1]\" -l 0 --title \" $hostname / $servicedesc\" ";

// Header
$def[1]  =  rrd::def("var1", $RRDFILE[1], $DS[1], "AVERAGE") ;
$def[1] .=  rrd::def("var2", $RRDFILE[2], $DS[2], "AVERAGE") ;

// Input
$def[1] .=  rrd::area("var1", "#000AD0", "Input") ;
$def[1] .=  rrd::gprint("var1", array("LAST", "MAX", "AVERAGE"), "%6.2lf $UNIT[1]") ;

//Output
$def[1] .=  rrd::line2("var2", "#00DB26", "Output") ;
$def[1] .=  rrd::gprint("var2", array("LAST", "MAX", "AVERAGE"), "%6.2lf $UNIT[2]") ;
?>
