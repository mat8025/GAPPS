#/* -*- c -*- */
# 
# interactively remove files where property meets condition
# rmf [-f] files  size [LT,GT,EQ] filesize

proc rmfile()
{
  
   if (!forceit)
     yn=ttyin(" Remove $fn size $fsz  $fday [n/y/q]?")
 
       //   if (yn @= "f")         forceit = 1

	  //<<" %v $yn \n"

   if (yn @= "q")
        STOP!
 

      if (yn @= "y" || forceit) {
 
    //<<" removing $fn \n"

	    <" rm -f $fn "
 
         }
}

nargs= argc()

     //<<" %v $na $0 $1 $2 \n"

//<<" $_clarg[*] \n"

int forceit = 0
int fsz = 0

fdate = ""
// get the args
property = "size"
condition = "LT"
ac = 2

fday = "-1"

      wo2 = $ac
      if (wo2 @= "-f") {
          forceit =1
          ac++
      }


// FIX   $ac++

     fnames = $ac
       ac++

     property = $ac
        ac++

     condition = $ac
        ac++

     value = $ac
        ac++

<<" %V $fnames $property $condition $value \n"


A = <"ls -l $fnames"

     //<<" %r $A[*] \n"



nl = Caz(A)

     //<<" %v $nl \n"

     for (i = 0; i < nl ; i++) {

       //       <<" $i  $A[i] \n"

      C=Split(A[i])

       //      <<" $C[*] \n"

          <<" $i $C[8] $C[4] $fsz \n"

     fsz = C[4]
     fday = C[6]
     fn = C[8]

       //          <<" $i $C[8] $C[4] $fsz \n"

      if (property @= "size") {

	if (condition @= "LT") {
	  //    <<" $fsz LT $value  \n"
                      if (fsz < value) rmfile()
    
	    }


	if (condition @= "GT") {
          if (fsz > value) rmfile()
	    }

      }


      if (property @= "day") {

  	if (condition @= "LT") {
                      if (fday < value) rmfile()
	    }

  	if (condition @= "NE") {

                      if (fday != value) rmfile()
	    }


	if (condition @= "GT") {
          if (fday > value) rmfile()
	    }

      }




     }


STOP!

