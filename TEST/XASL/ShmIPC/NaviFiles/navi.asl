//
//  test file browser
// 



vox_type = 'vox\|upe\|phn' ; // regex for vox or pcm

vox_dir= "/home/mark/barn/ASR/FL/spanish/fjm"; // no trailing spaces for chdir to work
vox_file =  "";

proc get_the_file ()
{

 fname = naviwindow("Vox/pcm Files ", " Search for vox/pcm files ", \
                      "a.vox", vox_type, vox_dir);

 timit_file = scut(fname,-4);
// sig_file =  scat (timit_file,".vox");
 sig_file =  scat (timit_file,".pcm");
 vox_file =  scat (timit_file,".vox");
 ok = fstat(sig_file,"size") ; // read 

<<"%V$timit_file  $sig_file $ok \n"

// vox_dir should be updated

  return ok;
}
//=======================================================


 while(1) {
  fn=get_the_file()
<<"$fn\n"
}



