
dir = _clargs[1]
prog = _clargs[0]

<<"$_clargs   \n"

<<"$_clargs[0:-1]   \n"


<<"$prog $dir \n"

pics = !!"ls \"$dir/\"*v.JPG "

<<"%1R $pics \n"

sz = Caz(pics)

<<"%v $sz \n"
pass = 1

T=fineTime()

siPause(2.37)

dt=fineTimeSince(T,1)

<<"$dt\n"

//wpic = !!"gconftool-2 --get /desktop/gnome/background/picture_filename > foo"

!!"gconftool-2 --get /desktop/gnome/background/picture_filename > foo"
dt=fineTimeSince(T,1)

<<"$wpic $dt\n"

siPause(2)

dt=fineTimeSince(T,1)
<<"$wpic $dt\n"



while (1) {

  pics->Shuffle()

  for (k = 0; k < sz ; k++) {

wpic = !!"gconftool-2 --get /desktop/gnome/background/picture_filename"

<<"%v $wpic \n"

//  siPause(2)
siPause(0.4)
//sleep(2)

dt=fineTimeSince(T,1)
<<"$pass $k $pics[k] $dt\n"

gok= !!"gconftool-2 -t str -s /desktop/gnome/background/picture_filename \"$pics[k]\"  "
<<"%v $gok \n"

//!!" sleep 2 "
//  siPause(0.5)
//  siPause(4)
//sleep(4)
//sok=!!" sleep 1.1s "
//<<"%v $sok \n"
sleep(4.7)


  }
pass++
<<" done %v $pass \n"
}

;


stop!




;	