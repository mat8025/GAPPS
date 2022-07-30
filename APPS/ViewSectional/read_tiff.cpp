

#include "stdio.h"
#include <stdlib.h>
#include "tiffio.h"

main(int argc, char* argv[])
{
    TIFF* tif = TIFFOpen(argv[1], "r");
    //TIFF* tif = TIFFOpen("myfile.tif", "r");
     int ac = 0;
    if (tif) {
        TIFFRGBAImage img;
        char emsg[1024];
        
        if (TIFFRGBAImageBegin(&img, tif, 0, emsg)) {
            size_t npixels;
            uint32* raster;
            
            npixels = img.width * img.height;
            raster = (uint32*) _TIFFmalloc(npixels * sizeof (uint32));
            if (raster != NULL) {
                if (TIFFRGBAImageGet(&img, raster, img.width, img.height)) {
		  fprintf(stderr,"process raster data... npix %d img.wid %d img.ht %d\n",
			 npixels ,img.width, img.height);
		  printf("# npixels %d img.wid %d img.ht %d\n",npixels ,img.width, img.height);
                  int k=0;
		 
		  for (int j =0 ; j< img.height; j++) {
		    //printf("row %d ",j);
		    for (int i =0 ; i< img.width; i++) {
		      if (raster[k] != 0xffffffff) {
			printf("%x ",i,raster[k]);
			ac++;
		      }
		      k++;
		    }
		  printf("\n");
		  }

                }
                _TIFFfree(raster);
            }
            TIFFRGBAImageEnd(&img);
        } else
            TIFFError(argv[1], emsg);
        TIFFClose(tif);
    }
    fprintf(stderr,"color pixs %d\n",ac);
    exit(0);
}

