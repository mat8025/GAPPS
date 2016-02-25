//  read a pcm or vox file


// swap these to switch  debug prints
#define DBPR  <<
//#define DBPR  ~! 

 Graphic = CheckGwm()


 if (!Graphic) {
     X=spawngwm()
  }



int sb = 512

 fname = _clarg[1]

 //sb = atoi(_clarg[2])

DBPR"%V$fname $sb\n"


    A=ofr(fname)


DBPR"$A\n"
//DBPR" $skp_head \n"

    hdr_size = getHdrSize(A)

DBPR"%V $hdr_size \n"

    if (hdr_size > 0) {
// does it have vox header - if so skip past it 
DBPR" skipping hdr $hdr_size \n"
      fseek(A,hdr_size,0)
    }
    else {

     if (sb > 0) {
DBPR"no header seeking $sb \n"
      //fseek(A,sb,0)
      fseek(A,sb,0)
     }
   }

DBPR"%V$dsz $npts $hdr_size\n"

    B=rdata(A,SHORT)

    int dsz = Caz(B)
  
    mm= minmax(B)

//DBPR"%(10,, ,\n)$B[0:99] \n"
//DBPR"B $mm \n"



  npts = dsz/512 * 512

DBPR"%V$dsz $npts \n"

float YS[]


      YS= B 

  mm= minmax(YS)

DBPR"%(10,, ,\n)$B[0:99]\n"

DBPR"$mm \n"





int allwins[]
int nw = 0

Vamp = 20000.0


 DBPR" create TAW \n"

 taw = CreateGwindow(@title,"TimeAmp",@scales,0,-Vamp,256,Vamp,@savescales,0)


 allwins[nw++] = taw

 SetGwindow(taw,@resize,0.1,0.02,0.95,0.75,0)
 SetGwindow(taw,@pixmapon,@hue,"red",@clip,0.01,0.01,0.99,0.99)

 setgw("clear","redraw","save")

DBPR"%V$tw $nw $allwins \n"


        SR = YS[0:32000]
        mm = minmax(SR)

        nsr = Caz(SR)

DBPR"%(10,, ,\n)6.0f$SR[0:99]\n"

DBPR"%V$nsr $mm \n"



  tagwo=CreateGwob(taw,"GRAPH",@resize,0.05,0.05,0.7,0.90)



  //SetGwob(tagwo,@penhue,"brown","name","tawave","redraw","save","drawon","pixmapon")

  SetGwob(tagwo,@drawon,@pixmapon,@penhue,"blue")

  SetGwob(tagwo,@clip,0.05,0.1,0.90,0.99)
  SetGwob(tagwo,@clear,"orange")
  SetGwob(tagwo,@clipborder,"black")
  setGWob(tagwo,@redraw);

//  setGWob(tagwo,@plotline,0,0,1024,1000,"brown");
//  setGwob(tagwo,@drawon,@pixmapon)

DBPR"%V$tagwo \n"

  // if (npts > 16000)        npts = 16000

       SYS = YS[0:npts-1]

       setGwob(tagwo,@scales,0,mm[0],npts,mm[1])

DBPR"%(10,, ,\n)6.0f$SYS[0:511]\n"

       setgwob(tagwo,@ClearPixMap)

//      DrawY(tagwo,YS[0:511],0,0.75)

        n2 = npts/4

//DrawY(tagwo,SYS,1,0.75,1,0,npts-1)
//        DrawY(tagwo,SYS,1,0.75,2,0,n2)

        //SR = YS[0:n2]
        SR = YS

        //DrawY(tagwo,SYS[0:16000],1,0.75,2,0,n2)

        mm = minmax(SR)

      nsr = Caz(SR)
      

      setGwob(tagwo,@scales,0,-Vamp,nsr,Vamp,@hue,"red")

      DrawY(tagwo,SR,1,0.95)

      setgwob(tagwo,@ShowPixMap,@save)

DBPR"%V$nsr $mm \n"
DBPR"%V$dsz $npts $hdr_size\n"


     wkeep(taw)

   //  sleep(10)

