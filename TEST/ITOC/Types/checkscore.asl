proc scoreTest( tname)
{
 int scored = 0;

       RT=ofr(tname);
<<"$_proc $tname fh $RT \n"

       if (RT != -1) {
//<<"$tname\n"
          fseek(RT,0,2)

          seekLine(RT,-1)

          rtl = readline(RT)
          rtwords = Split(rtl)
	<<"%V $rtwords \n"

         cf(RT);
	 }
}




fname = "float.tst"


scoreTest(fname);


scoreTest("float.xtst");
