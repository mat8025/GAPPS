//  test some ways of plotting an image file
//  in this case input csv file Rows x Cols of float values 

//  input 120 x 256 cells between 0- 100 in value



setdebug(1)
opendll("math")
opendll("image")
opendll("plot")

proc redraw()
{

  plotPixRect(lri_wo,UL,mapi)

  plotPixRect(lri_wo,N_UL,mapi,320,0)


  plotPixRect(sri_wo,U,mapi)


}



fn = _clarg[1]

<<"$fn \n"



 // A= ofr(fn)


  A= ofr("vfe_SRI_20100714_231135.csv")
  B= ofr("vfe_LRI_20100714_231135.csv")

uchar U[]
uchar UL[]

// read data into 2d array
R= readRecord(A,@del,',')

// fix if row finishes with , and no follwing data -- we get extra col with a zero value -- 
// so if no data following a comma then adjust


b = Cab(R)

<<"$b\n"

//<<"$R[10][::]\n"
//<<"$R[0:10][185] \n"

//  create color map - manipulate

  U = R


// LRI

  R= readRecord(B,@del,',')

  RZ=rowZoom(R,300,1)


  //T = Transpose(RZ)

  //RZ=rowZoom(T,200,1)

  //T = Transpose(RZ)

  //T =rowZoom(Transpose(RZ),200,1)

 // RZ = Transpose(T)


    NRZ = RZ

//    NRZ = vrange(RZ,20,65,20,65)

b = Cab(NRZ)

<<"$b\n"


<<"$NRZ[0:5][0:10]\n")

  UL =  Transpose(rowZoom(Transpose(NRZ),220,1))



N_UL=imop(UL,"laplace")
//N_UL=imop(UL,"sobel")



 // UL = T


b = Cab(RZ)

<<"$b\n"

b = Cab(UL)

<<"$b\n"



<<"%(10,, ,\n)$U[0:100][::] \n"

/////////////////////////////// Color Map ------- Cloud dbZ
///////////////////////////////

mapi = 100

mapki = mapi
// black



 rgb_v = getRGB("BLACK")
<<"$rgb_v BLACK\n"

// 0 - 5 dBZ
 for (i = 0; i < 10; i++) {

  setrgb(mapki,rgb_v[0],rgb_v[1], rgb_v[2])
  mapki++

 }



// 5-15

    pi = getColorIndexFromName("skyblue")

 rgb_v = getRGB("skyblue")
<<"$rgb_v SKYBLUE\n"

<<"%V$pi  Skyblue\n"


 for (i = 10; i < 15; i++) {

    //setrgb(mapki,0,0.9,0)

    setrgb(mapki,rgb_v)

    //setrgbfromIndex(mapki,pi)

 r_rgb_v = getRGB(mapki)

<<"$mapki $r_rgb_v \n"

  mapki++

 }





// yellow

// 15 -25

 for (i = 15; i < 20; i++) {

//  setrgb(mapki,0.0,0.0,0.9)
  setrgbfromIndex(mapki,BLUE)
  mapki++

 }


    pi = getColorIndexFromName("green")

 for (i = 20; i < 30; i++) {

  //setrgb(mapki,0,0.9,0)


<<"%V$pi\n"
  setrgbfromIndex(mapki,pi)
  mapki++

 }


 for (i = 30; i < 40; i++) {

  //setrgb(mapki,0.9,0.9,0)

  setrgbfromIndex(mapki,YELLOW)

  mapki++

 }



// red

// 25 -45

 pi = getColorIndexFromName("red")
<<"%V$pi  RED\n"

 for (i = 40; i < 50; i++) {

  // setrgb(mapki,0.9,0.0,0)
    setrgbfromIndex(mapki,RED)
    mapki++
 }



// white

// 45 ->>

  pi = getColorIndexFromName("purple")
<<"%V$pi\n"

 for (i = 50; i < 65; i++) {
    setrgbfromIndex(mapki,pi)
    mapki++
 }

  pi = getColorIndexFromName("white")
<<"%V$pi white\n"

 for (i = 65; i < 200; i++) {
   setrgbfromIndex(mapki,WHITE)
    mapki++
 }



/////////////////////////////////////////////////////////////////

// Window

    aw= CreateGwindow(@title,"CLOUD_SWEEP")

//<<" CGW $aw \n"

    SetGwindow(aw,@resize,0.1,0.1,0.9,0.9,0)
    SetGwindow(aw,@drawon)
    SetGwindow(aw,@clip,0.1,0.1,0.8,0.9)

  // GraphWo

   lri_wo=createGWOB(aw,@GRAPH,@resize,0.15,0.02,0.95,0.49,@name,"PY",@color,"white")

   setgwob(lri_wo,@drawon,@pixmapon,@clip,0.05,0.1,0.98,0.9,@scales,0,0,185,120,@savescales,0)

  // SRI_Wo

   sri_wo=createGWOB(aw,@GRAPH,@resize,0.15,0.5,0.95,0.95,@name,"PY",@color,"white")

   setgwob(sri_wo,@drawon,@pixmapon,@clip,0.1,0.1,0.9,0.9,@scales,0,0,185,120,@savescales,0)

 


//  pixel size ? 



  plotPixRect(lri_wo,N_UL,mapi)
  plotPixRect(sri_wo,U,mapi)







//  axis warping ?



//  image transforms



//  read csv image - cloud dbZ

int Minfo[]
float Rinfo[]

   while (1) {


   msg = MessageWait(Minfo,Rinfo)

   redraw()


   }