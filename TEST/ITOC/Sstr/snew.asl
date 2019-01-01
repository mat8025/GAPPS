///
///  sstr
///
     
     vers = "1.3"; 
     
     <<"%V$vers\n"; 
     
     checkIn(); 
     
     str A = "keep going until world tour"; 
     str B = "unti"; 
     
     
     iv = sstr(A,B,1); 
     
     <<"$iv\n"; 
     
     checkNum(iv[0],11); 
     
     iv = sstr(A,"XX",1); 
     
     <<"$iv\n"; 
     
     checkNum(iv[0],-1); 
     
     iv = sstr(A,"ou",1); 
     
     <<"$iv\n"; 
     
     checkNum(iv[0],24); 
     
     iv = sstr(A,"OU"); 
     
     <<"$iv\n"; 
     
     iv = sstr(A,"OU",1); 
     
     <<"$iv\n"; 
     
     checkNum(iv[0],24); 
     
     iv = sstr(A,"o",1,1); 
     
     <<"o @ $iv\n"; 
     
     checkNum(iv[0],6); 
     checkNum(iv[1],18); 
     checkNum(iv[2],24); 
     
     
     p = regex(A,"ou"); 
     
     <<"$p \n"; 
     
     str C = "mat.vox"; 
     str D = "terry.pcm"; 
     
     
     p = regex(C,"vox"); 
     
     <<"%V$p \n"; 
     
     checkNum(p[0],4); 
     
     p = regex(D,"pcm"); 
     
     
     <<"$p \n"; 
     
     checkNum(p[0],6); 
     
     p = regex(C,'vox\|pcm'); 
     
     <<"%V$p \n"; 
     
     
     p = regex(D,'vox\|pcm'  ); 
     
     <<"%V$p \n"; 
     
     
     str E = "abcxxxabcxxxabcyyy"; 
     
     
     pos = regex(E,'abc'  ); 
     
     <<"%V$pos \n"; 
     
     
     pos2 = regex(E,'xxx'  ); 
     
     <<"%V$pos2 \n"; 
     
     checkNum(pos2[0],3); 
     checkNum(pos2[1],6); 
     
     checkNum(pos2[2],9); 
     checkNum(pos2[3],12); 
     
     checkNum(pos2[4],-1); 
     
     
     
     
     checkOut(); 
