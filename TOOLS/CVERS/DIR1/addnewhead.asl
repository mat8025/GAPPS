
na = argc();

 for (i=1; i<na; i++) {
  y = _clarg[i];
//  <<"$i $y \n"
  <<"$i asl ../chead.asl $y > ../DIR2/$y\n"
  !!"asl ../chead.asl $y > ../DIR2/$y"  
}

