

#include "stdio.h"
#include <stdlib.h>
#include "tiffio.h"

main(int argc, char* argv[])
{
            uint32* raster;
            raster = (uint32*) malloc (20 * sizeof (uint32));


	    
                    int k=0;
		    uint32 val = 1;
		    uint32 uval = 4288675840;

		    for (int i =0 ; i< 20; i++) {
		      raster[k++] = val + 11 + uval;
		    val *= 2;
		    }
                    k = 0;
	            for (int i =0 ; i< 20; i++) {
		    printf("%.8x ",raster[k++]);
		    }
		    
}

