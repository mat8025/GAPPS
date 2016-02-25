#include <stdio.h>
#include <stdlib.h>




int main (int argc, char **argv)
{
  char a;

  a = *argv[1];

  printf("argc %d %s %c argv[1] \n",argc,argv[0],*argv[1]);

  switch (a)
    {
    case 'A':

      printf ("@A %c \n",a);

      break;

    case 'B':

      printf ("@B %c \n",a);

      break;

    case 'C':
      {
      //      char b = 'E';
      printf ("@A %c \n",a);

      break;
   
      case 'D':
      printf ("@D %c \n",a);
      break;
      case 'E':
      printf ("@E %c \n",a);
      break;
      default :
      printf ("@default %c \n",a);
      break;
      }

    }

  printf("outside switch %c \n",a);

  exit(0);

}
