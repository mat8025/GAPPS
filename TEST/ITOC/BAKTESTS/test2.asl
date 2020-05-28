///
///
///

setDebug(1)

proc hdg(atit)
{

len = slen(atit)

<<"\n$(time()) ${atit}$(nsc(20-len,\"/\"))\n";

}
//=======================

proc changeDir(td)
{
  chdir(td)
  Curr_dir = getDir();
}

//=======================
proc Run2Test(td)
{

 changeDir(Testdir)

!!"pwd"

  hdg(td)

  Prev_dir = getDir();
  chdir(td)
  Curr_dir = getDir();
  
  <<"changing to $td dir from $Prev_dir\n"
}
//=======================
setdebug(1,"keep")
filterDebug(0,"write");

<<"XIC print \n"

updir()

Testdir = getdir();
  
<<"Test Dir is $Testdir\n"


Curr_dir = getDir();

<<"%V $Curr_dir \n"

 !!"pwd"


 Run2Test("Spat")


 !!"pwd"

  hdg("hey")

 Run2Test("Memusage")

!!"pwd"

Curr_dir = getDir();

<<" and why no pwd in xic version\n"

<<" we are here ? $Curr_dir\n"

!!"echo  echo we are here ? $Curr_dir"

!!"pwd"

//xxx=yyy