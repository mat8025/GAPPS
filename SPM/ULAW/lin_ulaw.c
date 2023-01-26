/* filter to convert linear to u_law using SUN tables: Mark Terry 1993 */

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
		
	eof = read(0,lin, BUFS * sizeof(short));
	
	if (eof <=0)
	break;
	k = eof/2;

	for (i = 0 ; i < k; i++)		
	mu[i] = audio_s2u(lin[i]);
	
	write(1,mu,k*sizeof(char));	

	}
}



