

// asl -X trig1.asl

Class Point 
{

 float x;
 float y;

 CMF set(a,b)
  {
      x = a
      y = b
  }


}



proc PlotTriangle()
{


  setgwob(gwo,@plotline,A->x,A->y,C->x,C->y,"black")

  setgwob(gwo,@plotline,A->x,A->y,B->x,B->y,"red")

  setgwob(gwo,@plotline,B->x,B->y,C->x,C->y,"green")

}


proc LabelTriangle()
{

    setgwob(gwo,@textr,"  A ",A->x,A->y,2,0,"black")

    setgwob(gwo,@textr," B ",B->x,B->y,0,90,"black")

    setgwob(gwo,@textr," C ",C->x,C->y,0)

    my = (B->y - C->y)/2.0 + C->y 
    mx = (C->x - A->x) / 2.0  + A->x

//<<"%v $B->y $C->y  $my \n"

    setgwob(gwo,@textr," a ",C->x, my ,0)

    setgwob(gwo,@textr," c ", mx , my ,2)

    setgwob(gwo,@textr," b ",mx, C->y -0.1 ,2)

}




opendll("math")

// window

    gp = CreateGwindow("title","Trig","resize",0.01,0.01,0.9,0.9,0)

    SetGwindow(gp,"pixmapon","drawon","save","bhue","white")


// wob

   gwo=CreateGWOB(gp,"GRAPH",@name,"Triangle",@resize_fr,0.2,0.2,0.92,0.92,@color,"white")

   setgwob(gwo,@scales,-2,-2,2,2, "save","redraw","drawon","pixmapon")


// a Quit button


   qwo=createGWOB(gp,"BV",@name,"QUIT?",@VALUE,"QUIT",@color,"orange",@resize_fr,0.93,0.9,0.98,0.98)
   setgwob(qwo,@BORDER,@DRAW,@CLIPBORDER,@FONTHUE,"black", "redraw")



//
 Point A
 Point B
 Point C

 A->set(0,0)
 B->set(1,1)
 C->set(1,0)


<<" $A->x $A->y \n"
<<" $B->x $B->y \n"
<<" $C->x $C->y \n"



  
    PlotTriangle()
    LabelTriangle()

// interactive graph


int Minfo[]
float Rinfo[]

  while (1) {

   msg = MessageWait(Minfo,Rinfo)
   
   PlotTriangle()
   LabelTriangle()

  if (scmp(msg,"QUIT",4)) {
       break
  }

  }


 exitGS()


;
