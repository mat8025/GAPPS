

enum fwos {
    CELLWO,
    SAVEWO,
    CLEARWO,
    NEXTWO,
   };


int cellwo = 47;
int savewo = 79;
int clearwo = 80;
int nextwo = 123456;

int sw_key[]  = {cellwo,savewo, clearwo, nextwo};

<<"%v$sw_key \n"

int mod_keys[] = {123,456,789,-678}

<<"%V $mod_keys\n"

int all_keys []  = sw_key @+ mod_keys;

<<"%V $all_keys\n"


<<"%V $cellwo $savewo \n"
proc foo( ewoid)
{


    index = findVal(sw_key,ewoid);
    skey = index[0];
<<"$ewoid $skey\n"    
    switch (skey) {

       case  CELLWO:
          <<" @ %V $cellwo \n"

           break;
    
      case   SAVEWO:
           <<" @ %V $savewo \n"
           break;

      case   CLEARWO:
           <<" @ %V$clearwo \n"
           break;

      case   NEXTWO:
           <<" @ %V $nextwo \n"
           break;

       default:
           <<" in default case \n"
          break;
     }

}



foo (47);

foo(79)

foo (80)

foo (410567);


foo (123456);
