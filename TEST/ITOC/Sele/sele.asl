/* 
 *  @script sele.asl 
 * 
 *  @comment test sele function 
 *  @release CARBON 
 *  @vers 1.7 N Nitrogen [asl 6.3.8 C-Li-O] 
 *  @date Sun Jan 10 21:17:49 2021 
 *  @cdate 1/1/2001 
 *  @author Mark Terry 
 *  @Copyright © RootMeanSquare  2010,2021 → 
 * 
 *  \\-----------------<v_&_v>--------------------------//  
 */ 
                                                                    
   
   
   /* 
   sele(sv,index,nc);
   used to select part of string variable; 
   index in string (0...length-1), nc  number of chars required; 
   if nc not set (default) the selection is from index to end of string.; 
   newstr = sele(astr,3); 
   newstr contains from 4th character to end of original string.; 
   newstr = sele(astr,3,3); 
   newstr contains from 4th character to 6th character of  original string.; 
   if nc is set negative then the selected string is from the; 
   location of index minus nc to the index.; 
   sele can also be used to cut off an extension.; 
   newstr = sele("foo.dat",-5); 
   newstr is original minus the .dat extension.; 
   newstr = sele("foo.dat",-4,4); 
   newstr is  the extension.; 
   If the index is set  negative (-1) being the last character is the string,; 
   -2 the penultimate, then nc controls the number of chars selected; 
   if nc is negative then the selection is towards the beginning of the string,; 
   e.g. astr= "penultimate"; b=sele(astr,-1,-4) -- b would hold "mate".; 
   
   */
   
   
   chkIn(); 
   
   astr = "subsection"; 
   
   <<"$astr  $(slen(astr))\n"; 
   k=9; 
   newstr = sele(astr,k);
   
   <<"$k, $(slen(newstr)) $newstr\n";
   
   
   newstr = sele(astr,3);
   
   <<"3, $(slen(newstr)) $newstr\n";
   
   
   chkStr(newstr,"section"); 
   
   newstr = sele(astr,3,3); 
   
   <<"3,3 $newstr\n";
   chkStr(newstr,"sec"); 
   
   
   newstr = sele(astr,-1,3); 
   
   <<"-1,3 $newstr\n";
   
   chkStr(newstr,"n"); 
   
   
   newstr = sele(astr,-3,3); 
   
   <<"-3,3 $newstr\n";
   
   chkStr(newstr,"ion"); 
   
   
   newstr = sele(astr,-3,-3); 
   
   <<"-3,-3 $newstr\n";
   chkStr(newstr,"cti"); 
   
   
   newstr = sele(astr,-4); 
   
   <<"-4, $newstr\n";
   
   chkStr(newstr,"subsect"); 
   
   
   newstr = sele(astr,-3,-14); 
   
   <<"-3,-14 $newstr\n";
   
   chkStr(newstr,""); 
   
   newstr = sele(astr,-3,14); 
   
   <<"-3,14 $newstr\n";
   
   chkStr(newstr,"ion"); 
   
   
   newstr = sele("foo.dat",-5); 
   
   <<"$newstr\n"; 
   
   chkStr(newstr,"foo"); 
   
   
   newstr = sele("foo.dat",-4,4); 
   <<"$newstr\n"; 
   
   chkStr(newstr,".dat"); 
   
   astr= "penultimate"; b=sele(astr,-1,-4); 
   <<"$b\n";
   
   chkStr(b,"mate");
   
   
   chkOut();
   
