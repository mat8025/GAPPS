//  input a chord name
//  will work voicings -- fingering and display
//  TBD add sound
setdebug(1)
Graphic = CheckGwm()

  spawn_it = 1

 if (Graphic) {
   spawn_it = 0;
 }

 if (spawn_it) {
     X=spawngwm()
  }


Es= 6
As= 5
Ds= 4
Gs= 3
Bs= 2
es= 1 


enum C_scale {
  C = 1,
  D ,
  E,
  F,
  G,
  A,
  B,
  Ct,
};


proc pick_major(Root,S3, S5)
{


 eir=Estr->findVal(Root)
 ei3=Estr->findVal(S3)
 ei5=Estr->findVal(S5)

<<"%V$eir $ei3 $ei5 \n"

 air=Astr->findVal(Root)
 ai3=Astr->findVal(S3)
 ai5=Astr->findVal(S5)

<<"%V$air $ai3 $ai5 \n"

 dir=Dstr->findVal(Root)
 di3=Dstr->findVal(S3)
 di5=Dstr->findVal(S5)

<<"%V$dir $di3 $di5 \n"

 gir=Gstr->findVal(Root)
 gi3=Gstr->findVal(S3)
 gi5=Gstr->findVal(S5)

<<"%V$gir $gi3 $gi5 \n"

 bir=Bstr->findVal(Root)
 bi3=Bstr->findVal(S3)
 bi5=Bstr->findVal(S5)


<<"%V$bir $bi3 $bi5 \n"
}





// get name





//  window

    vp = CreateGwindow(@title,"CHORDS",@resize,0.1,0.1,0.9,0.95,0)

    SetGwindow(vp,@pixmapon,@drawon,@bhue,"white")



 chord_wo=createGWOB(vp,"TEXT",@name,"COOR",@VALUE,"0.0 0.0",@color,"orange",@resize,0.1,0.1,0.9,0.9)

 setgwob(chord_wo,@clip,0.1,0.1,0.9,0.9,@scales,6,5.5,1,0.5)


 grid (chord_wo,1,1,6,4.5)


setgwob(chord_wo,@BORDER,@CLIPBORDER,@FONTHUE,"black", @showpixmap)



 notes = "E,F,F#,G,G#,A,A#,B,C,C#,D,D#,E,F,F#,G"

 Estr = split(notes,",")

<<"$Estr \n"

 notes = "A,A#,B,C,C#,D,D#,E,F,F#,G,G#,A,A#,B,C"

 Astr = split(notes,",")

 notes = "D,D#,E,F,F#,G,G#,A,A#,B,C,C#,D,D#,E,F"

 Dstr = split(notes,",")


 notes = "G,G#,A,A#,B,C,C#,D,D#,E,F,F#,G,G#,A,A#"

 Gstr = split(notes,",")


 notes = "B,C,C#,D,D#,E,F,F#,G,G#,A,A#,B,C,C#,D"

 Bstr = split(notes,",")

 notes = "E,F,F#,G,G#,A,A#,B,C,C#,D,D#,E,F,F#,G"

 estr = split(notes,",")


// C-major for init


 eir=Estr->findVal("C")
 ei3=Estr->findVal("E")
 ei5=Estr->findVal("G")

<<"%V$eir $ei3 $ei5 \n"

 air=Astr->findVal("C")
 ai3=Astr->findVal("E")
 ai5=Astr->findVal("G")

<<"%V$air $ai3 $ai5 \n"

 dir=Dstr->findVal("C")
 di3=Dstr->findVal("E")
 di5=Dstr->findVal("G")

<<"%V$dir $di3 $di5 \n"

 gir=Gstr->findVal("C")
 gi3=Gstr->findVal("E")
 gi5=Gstr->findVal("G")

<<"%V$gir $gi3 $gi5 \n"

 bir=Bstr->findVal("C")
 bi3=Bstr->findVal("E")
 bi5=Bstr->findVal("G")


<<"%V$bir $bi3 $bi5 \n"
 // C-Major
 pick_major("C","E","G")


 // D-Major
 pick_major("D","F#","A")


 // G-Major
 pick_major("G","B","D")


 // B-Major
 pick_major("B","D#","F#")








//  C7
//  want C_major

// so want root(1) , third, fifth notes of C_scale






// where are our three notes -- plus what other strings can we double
// or have to mute



 pad = 0.0
// plotWoSymbol(chord_wo,Bs,1+pad,"circle",15,"blue",1)
// plotWoSymbol(chord_wo,As,3+pad,"circle",15,"blue",1)
// plotWoSymbol(chord_wo,Ds,2+pad,"circle",15,"blue",1)


// find root -- then 3 then 5 -- after double up on root?
 found_root = 0
 found_third = 0
 found_fifth = 0


 pick_E = 0
 pick_D = 0
 pick_A = 0
 pick_G = 0
 pick_B = 0
 pick_e = 0



 if (eir <= 5) {

 found_root =1

 if (eir > 0) {
 plotWoSymbol(chord_wo,Es,eir+pad,"circle",15,"red",1)
 }

 pick_E = 1
 E_pick = eir

 }



 if (ei3 <= 5 && !pick_E) { 

  found_third = 1
  if ( ei3 > 0) {
  plotWoSymbol(chord_wo,Es,ei3+pad,"circle",15,"red",1)
  }
  pick_E =1

  E_pick = ei3
 
 }

 if (ei5 <= 5 && !pick_E) { 

  found_fifth = 1
  if ( ei5 > 0) {
  plotWoSymbol(chord_wo,Es,ei5+pad,"circle",15,"red",1)
  }
  pick_E =1

   E_pick = ei5
 
 }



 if (air <= 5 && !found_root) {

  found_root =1

  if ( air > 0) {
   plotWoSymbol(chord_wo,As,air+pad,"circle",15,"red",1)
  }
  pick_A = 1

 }


 if (ai3 <= 5 && !pick_A) { 

  found_third = 1
  if ( ai3 > 0) {
  plotWoSymbol(chord_wo,As,ai3+pad,"circle",15,"red",1)
  }
  pick_A =1
 }

 if (ai5 <= 5 && !pick_A) {
 found_fifth = 1
 if (ai5 > 0) {
 plotWoSymbol(chord_wo,As,ai5+pad,"circle",15,"red",1)
 }
  pick_A = 1

 }


 if (dir <= 5 && !found_root) {

  found_root =1

  if ( dir > 0) {
   plotWoSymbol(chord_wo,Ds,air+pad,"circle",15,"red",1)
  }
  pick_D = 1
 }


 if (di3 <= 5 && !pick_D) {
 
 found_third = 1

 if( di3 > 0) {
 plotWoSymbol(chord_wo,Ds,di3+pad,"circle",15,"red",1)
 }

  pick_D = 1
}

 if (di5 <= 5 && !pick_D) {
  found_fifth = 1
  if (di5 > 0) {
    plotWoSymbol(chord_wo,Ds,di5+pad,"circle",15,"red",1)
  }
  pick_D = 1
 }


// root on G

 if (gir <= 5 && found_third && found_fifth) {
 
  found_root= 1

  if( gir > 0) {
   plotWoSymbol(chord_wo,Gs,gir+pad,"circle",15,"red",1)
  }

   pick_G = 1
 }


 if (gi3 <= 5) {

   found_third = 1

   if (gi3 > 0) {
   plotWoSymbol(chord_wo,Gs,gi3+pad,"circle",15,"red",1)
   }

  pick_G = 1

 }

 if (gi5 <= 5 && !pick_G) {

  found_fifth = 1

  if( gi5 > 0) {
   plotWoSymbol(chord_wo,Gs,gi5+pad,"circle",15,"red",1)
  }

    pick_G = 1

 }


 if (bir <= 5  && found_third && found_fifth) {
 
  found_root= 1

  if( bir > 0) {
   plotWoSymbol(chord_wo,Bs,bir+pad,"circle",15,"red",1)
  }

  pick_B = 1
 }


 if (bi3 <= 5 && !pick_B) {

   found_third = 1
   if (bi3 > 0) {
   plotWoSymbol(chord_wo,Bs,bi3+pad,"circle",15,"red",1)
   }

  pick_B = 1

 }


 if (bi5 <= 5 && !pick_B) {

  found_fifth = 1

  if (bi5 > 0) {
  plotWoSymbol(chord_wo,Bs,bi5+pad,"circle",15,"red",1)
  }

  pick_B = 1

 }


 if (pick_E) {

  if (E_pick > 0) {
   plotWoSymbol(chord_wo,es,E_pick+pad,"circle",15,"red",1)
  }

 }
 else {
  // anything


 }

// estr same as 1




 AxText(chord_wo,3,"E",6,1)
 AxText(chord_wo,3,"A",5,1)
 AxText(chord_wo,3,"D",4,1)
 AxText(chord_wo,3,"G",3,1)
 AxText(chord_wo,3,"B",2,1)
 AxText(chord_wo,3,"e",1,1)


 AxText(chord_wo,1,"E",6,1)
 AxText(chord_wo,1,"A",5,1)
 AxText(chord_wo,1,"D",4,1)
 AxText(chord_wo,1,"G",3,1)
 AxText(chord_wo,1,"B",2,1)
 AxText(chord_wo,1,"e",1,1)



 AxText(chord_wo,2,"1",1,2)
 AxText(chord_wo,2,"2",2,2)
 AxText(chord_wo,2,"3",3,2)
 AxText(chord_wo,2,"4",4,2)
 AxText(chord_wo,2,"5",5,2)

 AxText(chord_wo,4,"1",1,2)
 AxText(chord_wo,4,"2",2,2)
 AxText(chord_wo,4,"3",3,2)
 AxText(chord_wo,4,"4",4,2)
 AxText(chord_wo,4,"5",5,2)

setgwob(chord_wo,@BORDER,@CLIPBORDER,@FONTHUE,"black", @showpixmap)




//  chords

