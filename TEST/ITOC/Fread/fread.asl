//%*********************************************** 
//*  @script fread.asl 
//* 
//*  @comment test fread,wdata,rdata SF  
//*  @release CARBON 
//*  @vers 1.2 He Helium [asl 6.2.99 C-He-Es]                                
//*  @date Sat Dec 26 11:25:56 2020 
//*  @cdate 1/1/2004 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%

chkIn(_dblevel)

float f

VF=vgen(FLOAT_,10,0,0.5)

<<"$VF\n"




A=ofw("data.bin")
for (i=0;i<10;i++) {
f=VF[i]
nir = fwrite(&f,4,1,A)
    chkR(f,VF[i]);
}

wdata(A,VF)

cf(A)
//would write a float to the file


  A= ofr("data.bin")
  for (i = 0; i < 20; i++) {

    fread(&f,4,1,A)

<<"[${i}] $f\n"

  }

cf(A)


A= ofr("data.bin")

R=rdata(A,FLOAT_)

R->info(1)

<<"$R\n"

chkOut()