#include <stdio.h>
#include <string.h>
#include <stdlib.h>

void send (int *to, int * from, int count)
{
	int n = (count + 7) / 8;
        printf("sendswitch n %d  fc %d\n",n, count  % 8);
	switch ( count  %  8)
	{
		case 0: do { *to++ = *from++;
		case 7: *to++ = *from++;
		  printf("case 7\n");
		case 6: *to++ = *from++;
		case 5: *to++ = *from++;
		case 4: *to++ = *from++;
		case 3: *to++ = *from++;
		case 2: *to++ = *from++;
		  printf("case 2\n");
		case 1: *to++ = *from++;
                  printf("n %d \n",n);
		} while ( --n > 0 );
	}
}



int main(int argc , char *argv[])
{
  int TO[256];
  int FROM[256];

  int nc = atoi(argv[1]);
  printf("nc = %d\n",nc);

  for(int i = 0; i < 255; i++)
    FROM[i] = i;
  for(int i = 0; i < 255; i++)
    TO[i] = -1;

  send (TO,FROM, nc);


  for(int i = 0; i < 24; i++)
    printf("[%d] %d \n",i,TO[i]); 


}





