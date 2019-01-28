
na = argc();
 num=55
 
 
 
 
 
 
 
 cdate = "1/1/1997"
 for (i=1; i<na; i++) {
  y = _clarg[i];
  name = scut(y,-4)
//  <<"$i $y \n"
  <<"$i asl ../chead.asl $y 1.$num ' $name ' $cdate > ../DIR2/$y\n"
!!"asl chead.asl $y 1.$num $name  $cdate > ../DIR2/$y"
  num++
}

