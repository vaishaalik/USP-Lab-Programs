BEGIN{
 tcpsend=0;
 cbrsend=0;
 tcpDrop=0;
 cbrDrop=0;
 tcparrivalratio=0.0;
 cbrarrivalratio=0.0;
 tcpdropratio=0.0;
 cbrdropratio=0.0;
}
{
   event=$1; src=$3;
   dest=$4; pktype=$5;
    if((event=="+") && (src=="0") && (dest=="2"))
    {
        tcpsend++;
    }
 
    if((event=="+") && (src=="1") && (dest=="2"))
    { 
      cbrsend++;
    }

    if((event=="d") && (pktype=="tcp"))
    {
        tcpDrop++;
    }
    if((event=="d") && (pktype=="cbr"))
     {
        cbrDrop++;
     }
}

END{
 tcparrivalratio=(tcpsend-tcpDrop)/tcpsend;
 cbrarrivalratio=(cbrsend-cbrDrop)/cbrsend;
 tcpdropratio=tcpDrop/tcpsend;
 cbrdropratio=cbrDrop/cbrsend;
 printf "TCP Drop in link1=%f\n",tcpdropratio;
 printf "TCP Drop in link2=%f\n",cbrdropratio;
 printf "TCP Arrival ratio=%f\n",tcparrivalratio;
 printf "TCP Arrival ratio=%f\n",cbrarrivalratio;
}
