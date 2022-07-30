

#include "stdio.h"
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include "tiffio.h"

main(int argc, char* argv[])
{
            uint32* raster;
            raster = (uint32*) malloc (20 * sizeof (uint32));
	     mode_t mode = S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH;
             int fd =open("tiff.dat",O_WRONLY | O_CREAT |  O_TRUNC ,mode);
	     int fd2 =open("tiff_float.dat",O_WRONLY | O_CREAT |  O_TRUNC ,mode);

	    
                    int k=0;
		    uint32 val = 1;
		    double fval = 1;		    
		    uint32 uval = 4288675840;

		    for (int i =0 ; i< 20; i++) {
		      raster[k++] = val + 11 + uval;
		    val *= 2;
		    }
                    k = 0;
	            for (int i =0 ; i< 20; i++) {
		    printf("%.8x \n",raster[k]);
		    uval = raster[k];
		    fval = (double) uval;
		    k++;
		    write(fd,&uval,  sizeof(uint32));
		    write(fd2,&fval,  sizeof(double));		    
		    }
		    
}

