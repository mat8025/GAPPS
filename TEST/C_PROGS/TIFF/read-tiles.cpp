
#include "stdio.h"
#include <stdlib.h>
#include "tiffio.h"

int main(int argc, char* argv[])
{
     TIFF* tif = TIFFOpen(argv[1], "r");
     //TIFF* tif = TIFFOpen("myfile.tif", "r");
    
    if (tif) {
        uint32 imageWidth, imageLength;
        uint32 tileWidth, tileLength;
        uint32 x, y;
        tdata_t buf;
	tsample_t ts;
        
        TIFFGetField(tif, TIFFTAG_IMAGEWIDTH, &imageWidth);
        TIFFGetField(tif, TIFFTAG_IMAGELENGTH, &imageLength);
        TIFFGetField(tif, TIFFTAG_TILEWIDTH, &tileWidth);
        TIFFGetField(tif, TIFFTAG_TILELENGTH, &tileLength);
        buf = _TIFFmalloc(TIFFTileSize(tif));
        for (y = 0; y < imageLength; y += tileLength) {
	  for (x = 0; x < imageWidth; x += tileWidth) {
	    TIFFReadTile(tif, buf, x, y, 0, ts);
		printf("process raster tile data... x %d y %d \n",x,y);
          }
	}
        _TIFFfree(buf);
        //tiffclose(tif);
	     TIFFClose(tif);
    }
}

