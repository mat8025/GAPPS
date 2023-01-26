/*
  From:	Joe Sacchetti
  	Gradient Technology
	609-387-5000

  Mark:

       This mail message contain a small program which will play part
  of a file.  Please feel free to call if you have any questions.

  Joe
*/



/*  Playpart -- plays a part of a file on a Gradient DeskLab */

/*  Compile and run with:

    $ cc -o playpart -I..../desklab2/lib playpart.c ..../desklab2/lib/libgdl.a

    $ playpart  filename  start_byte  end_byte  channel
*/


#include <gasp-conf.h>

#include <fcntl.h>		/*  VAX VMS:  change to <file.h>  */
#include <stdio.h>

#include "gdesklab.h"

#define	USAGE	fprintf(stderr,\
		"Usage:  %s  filename  start_byte  end_byte  channel\n",\
		argv[0])


main (argc, argv)
     int argc;
     char **argv;
{
    long gplay_fd(), atol();
    int fd;
    long gd, channel, start_byte, end_byte;


    /*  Are all the parameters present?  */
    if (argc < 5)  {
	USAGE;
	exit(-1);
    }


    /*  open file which will be played  */
    if ((fd = open(argv[1],O_RDONLY,0)) < 0)  {
	perror("cannot open data file");
	exit(-1);
    }


    start_byte = atol(argv[2]);
    end_byte = atol(argv[3]);
    if (end_byte < start_byte)  {
	USAGE;
	fprintf(stderr,
		"%s:  end_byte (%ld) must be greater than start_byte (%ld)\n",
		argv[0],end_byte,start_byte);
	exit(-1);
    }


    if ((argv[4][0] == 'R') || (argv[4][0] == 'r') || (argv[4][0] == '2'))
      channel = G_RIGHT;
    else
      channel = G_LEFT;


    /*  Start the server and attach to DeskLab  */
    if ((gd = gdopen((char *) 0,channel)) < 0)  {
	gerror(argv[0],"can't open DeskLab");
	exit(-1);
    }


    /*  Wait for end of play before return  */
    gset_sync(gd,1);


    /*  Seek to starting position in the file  */
    if (lseek(fd,start_byte,0L) < 0)  {
	perror("can't seek to desired point in file");
	exit(-1);
    }


    /*  Play out samples (end_byte - start_byte) samples  */
    if (g2play_fd(gd,fd,end_byte - start_byte) < 0)  {
	gerror(argv[0],"can't play");
    }


    close(fd);
    gdclose(gd);
}

