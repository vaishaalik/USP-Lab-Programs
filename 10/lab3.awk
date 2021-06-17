BEGIN{
#include<stdio.h>
pktDropsRtr1=0;
pktDropsRtr2=0;
}

{
     if($1=="d" && $3=="2")   #d stands for the packets drops. 
     {
         pktDropsRtr1++;
     } 
     
     if($1=="d" && $3=="3")
     {
              pktDropsRtr2++; 
     }      
}

END{
printf("Number of Packets Dropped at Router1  : %d \n", pktDropsRtr1);
printf("Number of Packets Dropped at Router2  : %d \n", pktDropsRtr2);
}

