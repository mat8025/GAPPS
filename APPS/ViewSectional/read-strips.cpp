
#include "stdio.h"
#include <stdlib.h>
#include "tiffio.h"

main(int argc, char* argv[])
{
    TIFF* tif = TIFFOpen(argv[1], "r");
    if (tif) {
        tdata_t buf;
        tstrip_t strip;
        uint32* bc;
        uint32 stripsize;
        
        TIFFGetField(tif, TIFFTAG_STRIPBYTECOUNTS, &bc);
        stripsize = bc[0];
        buf = _TIFFmalloc(stripsize);
        for (strip = 0; strip < TIFFNumberOfStrips(tif); strip++) {
            if (bc[strip] > stripsize) {
                buf = _TIFFrealloc(buf, bc[strip]);
                stripsize = bc[strip];
            }
	    printf("process raster strip data... %d ssize %d\n",strip,stripsize);
            TIFFReadRawStrip(tif, strip, buf, bc[strip]);
        }
        _TIFFfree(buf);
        TIFFClose(tif);
    }
}

