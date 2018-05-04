
 Rn = 10;

setdebug(1)

 trec=i_read( "delete a record 0 $(Rn-1)  :: number ? ");

 wrec=i_read( "delete a record 0 $Rn  :: number ? ");

<<"%V$wrec\n";


<<"delete a record 0 $(Rn-1)  :: number ? \n";
<<" now the iread expansion?\n"
ready= iread ("ready?:");
 trec=i_read( "delete a record 0 $(Rn-1)  :: number ? ");

<<"%V$trec\n";


<<"delete a record 0 $(Rn-1)  :: number ? \n";

