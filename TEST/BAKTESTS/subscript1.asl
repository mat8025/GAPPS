#! /usr/local/GASP/bin/asl
OpenDll("math")

  XV =Igen(20,0,2)

 <<" %v $XV \n"

 YV = XV[0:9:3] 

 <<" %v $YV \n"

int ADA[12+] 
int BDA[12+] 

<<" $ADA \n"

 ADA[0:28:2] = 1

<<" $ADA \n"

 BDA[0:28:3] = 2

<<" $BDA \n"

 ADA = Igen(30,0,1)
<<" $ADA \n"
 BDA = Igen(30,0,1)
<<" $BDA \n"


 YV = ADA[0:5] + BDA[6:11]

 <<" %v $YV \n"


 ZV = ADA[0:5] + ADA[6:11]

 <<" %v $ZV \n"



STOP!

 i = 0
 j = i +5
 k = j + 1
 m = k + 5

 YV = ADA[i:j] + ADA[k:m]
 <<" %v $YV \n"

 
 NYV = ADA[i+1:j-1] + ADA[k+1:m-1]
 <<" %v $NYV \n"


 while (i < 30) {

  YV = ADA[i+1:j-1] + ADA[k+1:m-1]
  MYV = ADA[i+1:j-1] * ADA[k+1:m-1]
  DYV = ADA[i+1:j-1] / ADA[k+1:m-1]
  <<" $ADA \n"
  <<" $YV \n"
  <<" $MYV \n"
  <<" $DYV \n"
 i++
 j++
 k++
 m++
 }

<<" DONE \n"
STOP!
