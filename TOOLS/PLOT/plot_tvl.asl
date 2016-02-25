#! /usr/local/GASP/bin/asl

// plot net out and targ 
//

OpenDll("ann","plot","math","stat")
SetDebug(0)


////////////////////// INPUT //////////////////////

////// READ from file into Vector
fn= $2
// target file
A=ofr(fn)
Tar=rdata(A,"float")
cf(A)


fn= $3
// out file

A=ofr(fn)
Out=Rdata(A,"float")
cf(A)

///////////////////  Config Data ////////////////////

// get this from net arch - # outout values

veclen = 143


///////////////////Redimn ////////////////////
tsz = Caz(Tar)
int nrows = tsz/veclen
Redimn(Tar,nrows,veclen)
<<" %v $tsz $nrows \n"

osz = Caz(Out)
nrows = osz/veclen
Redimn(Out,nrows,veclen)

<<" %v $osz $nrows \n"
/////  initial vecs //////////////////

kv =0

tvec = Tar[kv][*]
ovec = Out[kv][*]


<<"%v $tvec \n"

<<"%v $ovec \n"

////////////// parse out  - temp, vap, liq /////////////////////


temtarvec = tvec[0:46]
temnetvec = ovec[0:46]


vaptarvec = tvec[49:95]
vapnetvec = ovec[49:95]


liqtarvec = tvec[95:142]
liqnetvec = ovec[95:142]



// plot vec value versus ht

float height[]={0, 0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1,1.25,1.5,1.75,2,2.25,2.5,2.75,3,3.25,3.5,3.75,4,4.25,4.5,4.75,5,5.25,5.5,5.75,6,6.25,6.5,6.75,7,7.25,7.5,7.75,8,8.25,8.5,8.75,9,9.25,9.5,9.75,10};

///////////////// Create Window //////////////


int allwins[]
int alines[]

int nwins = 0
int nlines = 0

    ymin = -1.0
    ymax = 1.0
    xmin = 0
    xmax = veclen
    xpad = 10
    yminht = 0
    ymaxht = 10.0
    xmintem = 0.2
    xmaxtem = 0.9
    aw= CreateGwindow("title","TEMP","scales",xminten,yminht,xmaxtem,ymaxht,"savescales",0)

    allwins[nwins++] = aw
    
    SetGwindow(aw,"resize",0.02,0.1,0.3,0.9,0)
    SetGwindow(aw,"clip",0.1,0.1,0.9,0.9)

    xminvap = 0.0
    xmaxvap = 0.7
    vapw= CreateGwindow("title","VAPOR","scales",xminvap,yminht,xmaxvap,ymaxht,"savescales",0)

    allwins[nwins++] = vapw
    
    SetGwindow(vapw,"resize",0.32,0.1,0.6,0.9,0)
    SetGwindow(vapw,"clip",0.1,0.1,0.9,0.9)


    xminliq = 0.0
    xmaxliq = 0.5

    liqw= CreateGwindow("title","LIQUID","scales",xminliq,yminht,xmaxliq,ymaxht,"savescales",0)

    allwins[nwins++] = liqw
    
    SetGwindow(liqw,"resize",0.62,0.1,0.92,0.9,0)
    SetGwindow(liqw,"clip",0.1,0.1,0.9,0.9)

    SetGwindow(allwins,"pixmapon","drawon")


<<" %v $allwins \n"
//////////////   Create Glines //////////////
// these should be a vec of lines
//  what type XvY  Y ??

// allines


  alines[nlines++]=CreateGline("wid",aw,"name","target","type","XY","xvec",temtarvec,"yvec",height,"color","red","usescales",0)

  alines[nlines++]= CreateGline("wid",aw,"name","target","type","XY","xvec",temnetvec,"yvec",height,"color","green","usescales",0)

  alines[nlines++]=CreateGline("wid",vapw,"name","target","type","XY","xvec",vaptarvec,"yvec",height,"color","red","usescales",0)

  alines[nlines++]=CreateGline("wid",vapw,"name","output","type","XY","xvec",vapnetvec,"yvec",height,"color","green","usescales",0)

  alines[nlines++]=CreateGline("wid",liqw,"name","target","type","XY","xvec",liqtarvec,"yvec",height,"color", "red","usescales",0)

  alines[nlines++]=CreateGline("wid",liqw,"name","output","type","XY","xvec",liqnetvec,"yvec",height,"color", "green","usescales",0)




////////////////  LOOP and PLOT ///////////////////

         while (1) {


///////  GET NEXT INPUT ///////////////////////

             tvec = Tar[kv][*]
             ovec = Out[kv][*]


              temtarvec = tvec[0:46]
              temnetvec = ovec[0:46]

	      vaptarvec = tvec[49:95]
	      vapnetvec = ovec[49:95]


		liqtarvec = tvec[95:142]
		liqnetvec = ovec[95:142]

        il = 0

        SetGline(alines[il++],"xvec",temtarvec)

        SetGline(alines[il++],"xvec",temnetvec)

        SetGline(alines[il++],"xvec",vaptarvec)

        SetGline(alines[il++],"xvec",vapnetvec)

        SetGline(alines[il++],"xvec",liqtarvec)

        SetGline(alines[il++],"xvec",liqnetvec)

///////////////////////////////////////////////////

        SetGwindow(allwins,"clearpixmaptohue","orange")
//////////////  Plot Tar & Out vecs //////////////
         kv++
<<" %v $kv \n"
         RedrawGlines(allwins)

       SetGwindow(allwins,"showpixmap")

         w_activate(aw)

          msg = MessageWait(Minfo)
         <<" %V  $msg $Minfo \n"


/////////////// STEP FORWARD ///////


/////////////// STEP BACK //////////


         }


STOP("DONE")
