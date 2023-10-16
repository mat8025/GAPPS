///
///
///

#include "debug.asl"

if (_dblevel >0) {
   debugON()
   <<[2]"$Use_\n"
}


chkIn(_dblevel)



 val= 0
  if (1) {

    val =1
  }

      chkN(val,1)

  if (val) {

    val =2
  }

    chkN(val,2)


int click[5]

     click.pinfo()

     click[0] = 1

     if (click[0]) {
        val = 3
        
      }

   chkN(val,3)
   click[1] = 0
     if (click[1]) {
        val = 4
	<<" should not be here\n"
	<<"No debería estar aquí \n"

      }

   chkN(val,3)

    click[2] = 66;
       if (click[2] == 66) {
        val = 5
	<<"OK  should be here\n"
	<<" Si debería estar aquí \n"

      }

chkN(val,5)



chkOut()


///