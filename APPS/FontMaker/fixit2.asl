setdebug(1,"trace")

enum fwos {
    CELLWO=1,
    SAVEWO,
    CLEARWO,
    NEXTWO,
   };


int cellwo = 47;
int savewo = 79;
int clearwo = 80;
int nextwo = 123456;


proc foo( cn)
{

    switch (cn) {

      case  0:
          <<" @ %V $cn  zero OK? \n"
          break;

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

      case  47:
          <<" @ %V $cn 47 silver \n"
          break
      case  -7:
          <<" @ %V $cn -7 negative OK \n"
          break;

      case  -1:
          <<" @ %V $cn -1 negative OK \n"
          break;
// want to allow
//  default :
//  default:

// default is -666 ---- but should be called if another fits
     default: 
     <<"in default case with val $cn \n"
          break;
     }

}



foo (CELLWO);

foo(SAVEWO)

foo (47)
foo (-1);


foo (-7);




foo (0);



foo (-667);

