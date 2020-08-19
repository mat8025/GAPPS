SetDebug(1)
SetPCW("writeexe","writepic")
OpenDll("math")


Class TP
{

 public:
  float     x;
  float   y;
  float Alt;

  CMF Print()
   {
     <<" %V $x $y $Alt \n"


   }

}


 TP atp

float ght = 44.5
float z = 3.3

 atp->x = 2.0
 atp->y = 3.0


 atp->Alt = 1000.0
 atp->Print()

<<" %V $ght $z \n"

 z = atp->Alt + ght + 3000


 <<" $z \n"



  STOP!