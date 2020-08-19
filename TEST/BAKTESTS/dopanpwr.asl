

int np = atoi(_clarg[1])

<<"%V $np\n"

int ipw[10];  //TBF
<<" int \n"
      for (i=0; i < 10 ;i++) {
            ipw[i] = i^np ;
	    <<"<$i> $ipw[i] \n"
      }



long lpw[10];  //TBF
<<" long \n"
      for (i=0; i < 10 ;i++) {
            lpw[i] = i^np ;
	    <<"<$i> $lpw[i] \n"
      }


ulong ulpw[10];  //TBF
<<" ulong \n"
      for (i=0; i < 10 ;i++) {
            ulpw[i] = i^np ;
	    <<"<$i> $ulpw[i] \n"
      }




pan pw[10];  //TBF

<<" pan \n"
      for (i=0; i < 10 ;i++) {
            pw[i] = i^np ;
	    <<"<$i> $pw[i] \n"
      }
