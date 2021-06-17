set ns [new Simulator]
set tf [open lab3.tr w]
$ns trace-all $tf
set nf [open lab3.nam w]
$ns namtrace-all $nf

proc finish {} {
global ns tf nf
$ns flush-trace
close $tf
close $nf
exec nam lab3.nam &
exit 0
}
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]

$ns duplex-link $n0 $n2 4Mb 2ms RED
$ns duplex-link $n2 $n1 4Mb 2ms RED
$ns duplex-link $n2 $n3 4Mb 2ms RED
$ns duplex-link $n3 $n4 4Mb 2ms RED
$ns duplex-link $n3 $n5 4Mb 2ms RED

$ns queue-limit $n0 $n2 5
$ns queue-limit $n2 $n1 5
$ns queue-limit $n2 $n3 5
$ns queue-limit $n3 $n4 5
$ns queue-limit $n3 $n5 5

#position 
$ns duplex-link-op $n0 $n2 orient right-up
$ns duplex-link-op $n1 $n2 orient right-down
$ns duplex-link-op $n2 $n3 orient right
$ns duplex-link-op $n3 $n4 orient right-up
$ns duplex-link-op $n3 $n5 orient right-down

#attach label
$n0 label "ping0"
$n1 label "ping1"
$n2 label "R1"
$n3 label "R2"
$n4 label "ping2"
$n5 label "ping3"

set ping0 [new Agent/Ping]
$ns attach-agent $n0 $ping0
set ping1 [new Agent/Ping]
$ns attach-agent $n1 $ping1
set ping2 [new Agent/Ping]
$ns attach-agent $n4 $ping2
set ping3 [new Agent/Ping]
$ns attach-agent $n5 $ping3

$ns connect $ping0 $ping2
$ns connect $ping1 $ping3

#flow colors
$ns color 2 blue
$ns color 3 red
$ns color 4 yellow
$ping0 set class_ 1
$ping1 set class_ 2
$ping2 set class_ 3
$ping3 set class_ 4

Agent/Ping instproc recv {from rtt} {
  $self instvar node_
}
proc SendPingPacket {} {
  global ns ping0 ping1
  set intervalTime 0.001
  set now [$ns now]
  $ns at [expr $now+$intervalTime] "$ping0 send"
  $ns at [expr $now+$intervalTime] "$ping1 send"
  $ns at [expr $now+$intervalTime] "SendPingPacket"
}
$ns at 0.01 "SendPingPacket"
$ns at 5.0 "finish"
$ns run

