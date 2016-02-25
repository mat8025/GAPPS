#! /usr/local/GASP/bin/asl
OpenDll("math")

int ADA[12+] 

<<" $ADA \n"
ADA[0:28:2] = 1
<<" $ADA \n"


// test array indexing

 ADA[0:5] = 3
<<" $ADA \n"

 ADA[6:11] = 4
<<" $ADA \n"

 ADA[12:17] = 5

 ADA[18:23] = 6

 YV = ADA[0:10] 

 <<" $YV \n"


 YV = ADA[0:7] + ADA[6:13]


 <<"\n $YV \n"


 int i = 0
 int j = i +5
 int k = j + 1
 int m = k + 5

 YV = ADA[i:j] + ADA[k:m]
 <<" $YV \n"

 
 NYV = ADA[i+1:j-1] + ADA[k+1:m-1]
 <<"\n %v $NYV \n"



 while (i < 4) {

  YV = ADA[i+1:j-1] + ADA[k+1:m-1]
  YVE = ADA[i:j] + ADA[k:m]
//  MYV = ADA[i+1:j-1] * ADA[k+1:m-1]
//  DYV = ADA[i+1:j-1] / ADA[k+1:m-1]
  <<"\n $i %v \n $ADA \n"
  <<"\n $i %v \n $YV \n"
  <<"\n $i %v \n $YVE \n"

//  <<"\n $MYV \n"
//  <<"\n $DYV \n"

 i++
 j++
 k++
 m++

<<" $i $j $k $m \n"

 }

<<" DONE \n"


STOP!
