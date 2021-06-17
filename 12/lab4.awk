BEGIN{
TotalPackets=0;
Size=500;
Throughput=0.0;
CbrPkts=0;
TcpPkts=0;
}

{
	if(($1=="+")&&($3=="6")&&($4=="7")&&($5=="cbr"))
	{
		CbrPkts++;
	}
	if(($1=="+")&&($3=="6")&&($4=="7")&&($5=="tcp"))
	{
		TcpPkts++;
	}
}
END{
        TotalPackets = CbrPkts + TcpPkts; 
	Throughput=((TotalPackets*Size*8)/(9*1000000));
	printf("\n Throughput =%f \n",Throughput);
}
