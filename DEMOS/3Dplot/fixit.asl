

fp =  ofr("woman.pic")

npx = 512*512
uchar PX[npx+]

// read in image file

 nc=v_read(fp,PX,(512*512),"uchar")

 redimn(PX,512,512)

 b = Cab(PX)
<<"bounds are $b \n"

 msz = Caz(PX)
 <<"PX $(Cab(PX)) sz $msz\n"


 PX=reflectRow(PX)

 MX = PX[0:-1:4][0:-1:4]

 msz = Caz(MX)

 <<" $(Cab(MX)) $msz\n"


// Redimn(MX,128,128)

stop!