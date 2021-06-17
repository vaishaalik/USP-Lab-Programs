set ns [new Simulator]
set tf [open lab2.tr w]
$ns trace-all $tf
set nf [open lab2.nam w]
$ns namtrace-all $nf

proc finish {} {
global ns tf nf
$ns flush-trace
close $tf
close $nf
exec nam lab2.nam &
exit 0
}
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]

$ns duplex-link $n0 $n2 4Mb 2ms RED
$ns duplex-link $n2 $n1 4Mb 2ms RED
$ns duplex-link $n2 $n3 4Mb 2ms RED

$ns queue-limit $n0 $n2 5
$ns queue-limit $n2 $n1 5
$ns queue-limit $n2 $n3 5

set tcp [new Agent/TCP]
$ns attach-agent $n0 $tcp
set sink [new Agent/TCPSink]
$ns attach-agent $n3 $sink
$ns connect $tcp $sink
$tcp set packetSize_ 552
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 0.5 "$ftp start"

set udp [new Agent/UDP]
$ns attach-agent $n1 $udp
set null [new Agent/Null]
$ns attach-agent $n3 $null
$ns connect $udp $null
set cbr [new Application/Traffic/CBR]
$cbr attach-agent $udp
$cbr set packetSize_ 1000
$cbr set rate_ 0.1Mb
$cbr set random_ false
$ns at 0.5 "$cbr start"

$ns at 4.0 finish
$ns run

