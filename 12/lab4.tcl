set ns [new Simulator]
set tf [open lab4.tr w]
$ns trace-all $tf
set nf [open lab4.nam w]
$ns namtrace-all $nf

proc finish {} {
global ns tf nf
$ns flush-trace
close $tf
close $nf
exec nam lab4.nam &
exit 0
}
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]
set n6 [$ns node]
set n7 [$ns node]

$ns make-lan "$n0 $n1 $n2 $n6" 1Mb 10ms LL Queue/DropTail Mac/802_3
$ns make-lan "$n7 $n3 $n4 $n5" 1Mb 10ms LL Queue/DropTail Mac/802_3
$ns duplex-link $n6 $n7 2.5Mb 10ms DropTail


set tcp [new Agent/TCP]
$ns attach-agent $n0 $tcp
set sink [new Agent/TCPSink]
$ns attach-agent $n3 $sink
$ns connect $tcp $sink
$tcp set packetSize_ 552
set telnet [new Application/Telnet]
$telnet attach-agent $tcp
$ns at 0.5 "$telnet start"
$ns at 9.0 "$telnet stop"

set udp [new Agent/UDP]
$ns attach-agent $n2 $udp
set null [new Agent/Null]
$ns attach-agent $n5 $null
$ns connect $udp $null
set cbr [new Application/Traffic/CBR]
$cbr attach-agent $udp
$cbr set packetSize_ 1000
$cbr set rate_ 0.1Mb
$cbr set random_ false
$ns at 0.5 "$cbr start"
$ns at 9.0 "$telnet stop"

set error [new ErrorModel]
$ns lossmodel $error $n6 $n7
$error set rate_ 0.05
$ns set datarate_ 10Mb

$ns at 10.0 "finish"
$ns run

