#! /usr/local/GASP/gasp/bin/asl

proc desktopBkgCycle( dir)
{

  int k;

  pics = !!"ls ~/Pictures/$dir/"

  sz = Caz(pics)

  //<<"$sz  $pics \n"

  pics->Shuffle()

  for (k = 0; k < sz ; k++) {

  wpic = !!"gconftool-2 --get /desktop/gnome/background/picture_filename"

//<<" $wpic \n"

sleep(1)

!!"gconftool-2 -t str -s /desktop/gnome/background/picture_filename ~/Pictures/\"$dir/$pics[k]\" "

sleep(1)

sleep(8)

  }

}



dirs = !!"ls ~/Pictures/"

dsz = Caz(dirs)

<<"$sz  $dirs \n"


while (1) {
   dirs->Shuffle()

  for (i = 0; i < dsz ; i++) {

   desktopBkgCycle(dirs[i])

  }

}




#{
dir = "2008-07-04--14.09.03/"

 desktopBkgCycle( dir)

dir = "2008-01-28--11.27.43"

 desktopBkgCycle( dir)

 desktopBkgCycle("2008-07-04--13.33.28")
#}




STOP!



;