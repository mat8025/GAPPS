
/// ?? que?


int  goalwos[10] = {-2,0, 1, 2, 3, -1,5,6,7,8,9};

goalwos.pinfo();


 first = goalwos[0];
 last = goalwos[3];
 ha = goalwos[4];

first.pinfo();
last.pinfo();
ha.pinfo();

<<"%V $goalwos  $first $last $ha\n"; 



  int i = 0;

  while (1) {
  <<"%V $i $goalwos[i] \n";

    goalwos.pinfo();



   if (goalwos[i] < 0) {
   <<" break neg goalwo  $goalwos[i]\n"
       break;
       }
    else {
<<" break neg goalwo test fail $goalwos[i]\n"
    }

   if (goalwos[i] == -2) {
   <<" break  goalwo == -2\n"
       break;
       }



    last = goalwos[i];
<<"%V $i $last \n"  
last.pinfo();
!a
  if (last < 0) {
<<" break on last < 0\n"
    break;
  }

  if (last == -1) {
<<" break on last == -1\n"
    break;
  }

  if (last == 7) {
<<" break on last == 7\n"
     break;
  }
       
    //sWo(_WOID,goalwos[i],_WREDRAW,ON_);
    i++;
    if (i > 8) {
         break;
    }
  }

