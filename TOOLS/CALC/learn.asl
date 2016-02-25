



proc learn(what)
{
<<" in learning mode\n"

<<"basic statements are :- declarations, expressions, conditionals, loops\n"
<<"and print and input statements\n"
<<"// is our comment marker anything following // on a line is ignored\n"
<<" a semi-colon finishes a statement \n\n"

<<" <<\" hello world! \\n\" ;// say hello \n\n"

<<" m = 2 ; // declare variable m and set its value to 2 \n"
<<" n = 3 ; // declare variable n and set its value to 3 \n"
<<" p = n + m ;   // declare variable p and set its value to n + m \n"
<<" <<\" \$p \\n\" // print out the value of p \n\n"


  if (what @= "types") 
    {
    <<"types are :- char,int,short,long,float,double,pan\n"
      <<"int n = 2 // set variable n integer type to two\n"
      //<<"int n = 2 ; // set variable n integer type to two\n"
	int n = 2;
	int m = 2;
        p = n + m
    <<" p = n + m \n"
    <<"$n + $m => $p \n"






    }


}


learn("types")


;