///
///
///

//  TBF 8/7/24   tokpara expand bad in assigning to str

 db_ask = 0;
 db_allow = 1;

 checkMemory(0)
 alm =alignMemory(32)
 <<"%V $alm\n"

  chkIn(1)
  
  allowDB("prep,proc,spe,rdp,pex,ic",db_allow)

 
  Str cb = "abcd  then append the Svar to the new"

  <<"%V $cb \n"



  Author = "Mark Terry $cb read current vers "  

  <<"%V $Author \n"

  chkStr( Author, "Mark Terry $cb read current vers ")
  
 memUsed()


 chkOut(1)
 
 exit(-1)

// FIXED 8/7/24   paramexpand  of str srg ok


 