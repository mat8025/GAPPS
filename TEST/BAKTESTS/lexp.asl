


 k = 10
 i = 0

  for (j = 0; j < 5; j++) {
   i = k++
// FIXIT --- w should eq i*2 and z should eq w
   z= (w = i*2);
<<"%V$j $i "

<<"%V$k $m $z $w\n"
  } 
<<"%V $j \n"

  for (j = 0; j < (m=10); j++) {
   i = k++

<<"%V$j $i "
<<"%V$k $m\n"
   
  } 



