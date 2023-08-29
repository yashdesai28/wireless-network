
set ns [new Simulator]


set nf [open out.nam w]
$ns namtrace-all $nf


proc finish {} {
    global ns nf
    $ns flush-trace

   
    close $nf


    exec nam out.nam &

    exit 0
}

#create  nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]


#create duplex link between the nodes
$ns duplex-link $n0 $n2 1Mb 10ms DropTail
$ns duplex-link $n1 $n2 1Mb 10ms DropTail
$ns duplex-link $n3 $n2 1Mb 10ms DropTail



$ns duplex-link-op $n2 $n0 orient right-down
$ns duplex-link-op $n2 $n3 orient left
$ns duplex-link-op $n2 $n1 orient left-down

#create tcp
set tcp [new Agent/TCP]
$tcp set class_ 2
$ns attach-agent $n2 $tcp
set sink [new Agent/TCPSink]
$ns attach-agent $n0 $sink
$ns connect $tcp $sink


#create ftp
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ftp set type_ FTP
$ftp set packet_size_ 1000
$ftp set rate_ 1mb


#create tcp
set tcp1 [new Agent/TCP]
$tcp1 set class_ 2
$ns attach-agent $n2 $tcp1
set sink1 [new Agent/TCPSink]
$ns attach-agent $n1 $sink1
$ns connect $tcp1 $sink1


#create ftp
set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1
$ftp1 set type_ FTP
$ftp1 set packet_size_ 1000
$ftp1 set rate_ 1mb


#create tcp
set tcp2 [new Agent/TCP]
$tcp2 set class_ 2
$ns attach-agent $n2 $tcp2
set sink2 [new Agent/TCPSink]
$ns attach-agent $n3 $sink2
$ns connect $tcp2 $sink2


#create ftp
set ftp2 [new Application/FTP]
$ftp2 attach-agent $tcp2
$ftp2 set type_ FTP
$ftp2 set packet_size_ 1000
$ftp2 set rate_ 1mb



$ns at 1.0 "$ftp start"
$ns at 2.0 "$ftp stop"


$ns at 3.0 "$ftp1 start"
$ns at 4.0 "$ftp1 stop"


$ns at 5.0 "$ftp2 start"
$ns at 6.0 "$ftp2 stop"




$ns at 7.0 "finish"

#run  simulation
$ns run

