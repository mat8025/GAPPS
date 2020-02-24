
//
//  test file browser
// 

   Graphic = checkGWM()

  if (!Graphic) {
    Xgm = spawnGWM()
  }

//vox_type = 'vox\|pcm\|wav' ; // regex for vox or pcm
vox_type = 'pcm|vox|wav' ; // regex for vox or pcm

vox_dir= "/home/mark/gapps/ASR/Vox"; // no trailing spaces for chdir to work
vox_file =  "";

proc get_the_file ()
{

 fname = naviwindow("Vox/pcm Files ", " Search for vox/pcm files ", \
                      "a.vox", vox_type, vox_dir);

 ok = fstat(fname,"size") ; // read 

<<"%V $fname $ok \n"

// vox_dir should be updated

  return ok;
}
//=======================================================

chdir (vox_dir);

!!"ls -l"


 while(1) {
 
  fn=get_the_file()
  <<"$fn\n"
// if (fn <= 0)     break;
}



