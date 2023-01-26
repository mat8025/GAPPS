
#include <gasp-conf.h>

#include <stdio.h>
#include <fcntl.h>

gs_apget () {


   int   idx, fd, pid, apflag;

   apflag = open ("/dev/va/va0", O_RDWR);
   close (apflag);
   fd = open ("/usr/spool/locks/gs_aplock", O_RDONLY);
/*   printf ("apflag value = %d\n", apflag); */
   if (apflag != -1) {		/* AP available */
      fd = creat ("/usr/spool/locks/gs_aplock", 0666);
      pid = getpid ();
      write (fd, &pid, sizeof (int));
      close (fd);

      if (idx = mapinit (1)) {
	 dbprintf (1,"VA init failed: %d\n", idx);
	 exit (-1);
      }
      idx = maprndze ();
      mapsync (idx);
      return (1);
   }

   else {			/* AP not available */
      if (fd > 0) {		/* AL-AP lock file present */
	 read (fd, &pid, sizeof (int));
	 if (pid == getpid ()) {
	    dbprintf (1,"VA is already locked by you.\n");
	    return (1);
	 }
	 else {
	    dbprintf (1,"VA locked by another VA user.\n");
	    return (-1);
	 }
      }
      else {
	 dbprintf (1,"VA locked by another non-VA user.\n");
	 return (-1);
      }
   }
}

gs_aprel () {


   int   idx, fd, pid, apflag;

   apflag = open ("/dev/va/va0", O_RDWR);
   close (apflag);

   fd = open ("/usr/spool/locks/gs_aplock", O_RDONLY);

   if (apflag != -1) {		/* AP available */
      if (fd > 0) {		/* AL-AP lock file present */
	 close (fd);
	 system ("rm /usr/spool/locks/gs_aplock");
      }
   }

   else {			/* AP not available */
      if (fd > 0) {		/* AL-AP lock file present */
	 read (fd, &pid, sizeof (int));
	 if (pid == getpid ()) {/* Your lock file */
	    idx = mapfree ();
	    if (idx == -1)
	       printf ("Unable to release AP!\n");
	    else
	       printf ("VA released!\n");
	    close (fd);
	    system ("rm /usr/spool/locks/gs_aplock");
	 }
      }
   }
   return (-1);
}

