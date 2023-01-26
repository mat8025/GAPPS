/* filter to convert u_law to linear using SUN tables: Mark Terry 1993 */

#include <gasp-conf.h>

#include <stdio.h>
#include "multimedia/ulaw2linear.h"



#define BUFS 512

main()
{
short lin[BUFS];
unsigned char mu[BUFS];
int eof;
int k,i;

	while(1) {
		
	eof = read(0,mu,BUFS *sizeof(char));
	
	if (eof <=0)
	break;
	k = eof;
	for (i = 0 ; i < k; i++)		
	lin[i] = audio_u2s(mu[i]);
	
	write(1,lin,k*sizeof(short));	

	}
}


