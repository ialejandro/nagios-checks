<?php
#
# Copyright (c) 2016 Ivan Alejandro (ialejandro.rocks)
# Plugin: check_ram.sh
#

$ds_name[1] = "Free / Used / Cache RAM";
$opt[1]  = "--lower-limit 0 --upper-limit $ACT[1] --rigid --vertical-label \"$UNIT[1]\" --title \" $hostname / $servicedesc\" " ;

$def[1]  =  rrd::def("var1", $RRDFILE[2], $DS[2], "AVERAGE") ;
$def[1] .=  rrd::def("var2", $RRDFILE[3], $DS[3], "AVERAGE") ;
$def[1] .=  rrd::def("var3", $RRDFILE[5], $DS[5], "AVERAGE") ;


$def[1] .=  rrd::area("var1", "#8D53C0", "Used RAM", "STACK") ;
$def[1] .=  rrd::gprint("var1", array("LAST", "MAX", "AVERAGE"), "%6.1lf $UNIT[1]") ;
$def[1] .=  rrd::area("var2", "#2ECF2E", "Free RAM", "STACK") ;
$def[1] .=  rrd::gprint("var2", array("LAST", "MAX", "AVERAGE"), "%6.1lf $UNIT[1]") ;
$def[1] .=  rrd::area("var3", "#FFC539", "Cache RAM", "STACK") ;
$def[1] .=  rrd::gprint("var3", array("LAST", "MAX", "AVERAGE"), "%6.1lf $UNIT[1]") ;

$ds_name[2] = "Available / Shared / Cache RAM";
$opt[2]  = "--lower-limit 0 --upper-limit $ACT[1] --rigid --vertical-label \"$UNIT[1]\" --title \" $hostname / $servicedesc\" " ;

$def[2]  =  rrd::def("var1", $RRDFILE[6], $DS[6], "AVERAGE") ;
$def[2] .=  rrd::def("var2", $RRDFILE[4], $DS[4], "AVERAGE") ;
$def[2] .=  rrd::def("var3", $RRDFILE[5], $DS[5], "AVERAGE") ;

$def[2] .=  rrd::area("var1", "#1046A9", "Available RAM", "STACK") ;
$def[2] .=  rrd::gprint("var1", array("LAST", "MAX", "AVERAGE"), "%6.1lf $UNIT[1]") ;
$def[2] .=  rrd::area("var2", "#EC0033", "Shared RAM", "STACK") ;
$def[2] .=  rrd::gprint("var2", array("LAST", "MAX", "AVERAGE"), "%6.1lf $UNIT[1]") ;
$def[2] .=  rrd::area("var3", "#FFC539", "Cache RAM", "STACK") ;
$def[2] .=  rrd::gprint("var3", array("LAST", "MAX", "AVERAGE"), "%6.1lf $UNIT[1]") ;
?>
