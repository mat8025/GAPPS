

#include "stdio.h"
#include <stdlib.h>
#include "tiffio.h"

main(int argc, char* argv[])
{
    TIFF* tif = TIFFOpen(argv[1], "r");
    //TIFF* tif = TIFFOpen("myfile.tif", "r");
    
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
		    for (int i =0 ; i< img.width; i++) {
		    printf("%x ",raster[k++]);
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
    exit(0);
}

