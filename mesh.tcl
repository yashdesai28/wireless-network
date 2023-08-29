
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

#create nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]

#create duplex link between the nodes
$ns duplex-link $n4 $n0 1Mb 10ms DropTail
$ns duplex-link $n4 $n1 1Mb 10ms DropTail
$ns duplex-link $n0 $n2 1Mb 10ms DropTail
$ns duplex-link $n0 $n3 1Mb 10ms DropTail
$ns duplex-link $n0 $n1 1Mb 10ms DropTail
$ns duplex-link $n1 $n2 1Mb 10ms DropTail
$ns duplex-link $n1 $n3 1Mb 10ms DropTail
$ns duplex-link $n3 $n2 1Mb 10ms DropTail


$ns duplex-link-op $n0 $n1 orient right-up
$ns duplex-link-op $n2 $n3 orient left-down
$ns duplex-link-op $n4 $n0 orient left-up
$ns duplex-link-op $n1 $n3 orient right-down


#create tcp
set tcp [new Agent/TCP]
$tcp set class_ 2
$ns attach-agent $n0 $tcp
set sink [new Agent/TCPSink]
$ns attach-agent $n2 $sink
$ns connect $tcp $sink


#create ftp
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ftp set type_ FTP
$ftp set packet_size_ 1000
$ftp set rate_ 1mb

$ns at 1.0 "$ftp start"
$ns at 2.0 "$ftp stop"




$ns at 5.0 "finish"

#run  simulation
$ns run

