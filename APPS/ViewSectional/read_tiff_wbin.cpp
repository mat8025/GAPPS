

#include "stdio.h"
#include <stdlib.h>
#include <unistd.h>

#include "tiffio.h"
#include <fcntl.h>

main(int argc, char* argv[])
{
    TIFF* tif = TIFFOpen(argv[1], "r");
    //TIFF* tif = TIFFOpen("myfile.tif", "r");
    mode_t mode = S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH;

     int fd =open("tiff.dat",O_WRONLY | O_CREAT |  O_TRUNC ,mode);
    // int fd =open("tiff.dat",(O_WRONLY | O_CREAT |  O_TRUNC) );
    if (fd == -1) {
      fprintf(stderr,"error open op file\n");
    }
    if (tif) {
        TIFFRGBAImage img;
        char emsg[1024];
        
        if (TIFFRGBAImageBegin(&img, tif, 0, emsg)) {
            size_t npixels;
	    uint32 npix;
            uint32 *raster;
            uint32 *bufp;
            npixels = img.width * img.height;
	    npix = npixels;
	     uint32 wid = img.width ;
	     uint32 ht =  img.height;	     
            raster = (uint32*) _TIFFmalloc(npixels * sizeof (uint32));
            if (raster != NULL) {
                if (TIFFRGBAImageGet(&img, raster, img.width, img.height)) {
		  fprintf(stderr,"process raster data... npix %d img.wid %d img.ht %d\n",
			 npixels ,img.width, img.height);
		  printf("# npixels %d img.wid %d img.ht %d\n",npixels ,img.width, img.height);
                  write(fd,&npixels,  sizeof(uint32));
                  write(fd,&wid,  sizeof(uint32));
                  write(fd,&ht,  sizeof(uint32));		  		  
                  int k=0;
		  uint32 nbw = 0;
                  bufp= raster;
		  for (int j =0 ; j< img.height; j++) {
                    nbw = write(fd,(void *) bufp, img.width* sizeof(uint32));
		    // bufp += (img.width* sizeof(uint32));
		    k += img.width;
		    bufp += img.width;
		    printf("row %d k %d nbw %d\n",j,k,nbw);
		    }

		    printf("# npixels %d img.wid %d img.ht %d\n",npixels ,img.width, img.height);
                }
                _TIFFfree(raster);
            }
            TIFFRGBAImageEnd(&img);
        } else
            TIFFError(argv[1], emsg);
        TIFFClose(tif);
    }
    exit(0);
}

