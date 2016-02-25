


    goon= iread("--->");

  <<"you typed $goon $(typeof(goon))\n"

   if (goon @= "quit") {
     <<" got quit\n"
    }


    goon= iread("--->");

  <<"you typed $goon $(typeof(goon))\n"

   if (goon @= "c") {
     <<" got c\n"
    }


while (1) {


    goon= iread("--->");

  <<"you typed $goon $(typeof(goon))\n"

   if (goon @= "q") {
     <<" got q  - quit\n"
      exitsi()
    }

   if (goon @= "c") {
     <<" got c \n"
    }

   res = scmp(goon,"quit",4,1,1);
   <<"scmp compare $goon with quit result is $res\n"

   res = strcmp(goon,"quit");
   <<"strcmp compare $goon with quit result is $res\n"
   
   if (scmp(goon,"quit",4)) {
     <<" got q  - quit\n"
      exitsi()
    }





}