

N= atoi(_clarg[1])

include "colorRows.asl"

setdebug(1,@keep)

cellwo = 4567;

int rows = 20;
int cols = 10;


  colorRows(rows,cols);


<<" Still OK?\n"


  colorRows(rows,cols);

<<" Still OK?\n"

  for (i=0; i < N; i++) {

   colorRows(rows,cols);

  }

<<" Still OK? $i\n"

exit()




