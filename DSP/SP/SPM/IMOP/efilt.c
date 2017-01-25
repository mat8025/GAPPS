#include <gasp-conf.h>

#include <stdio.h>
#define ERR -1 /* low-level file def */
#define READ_WRITE 3
#define START 0
#define MAXPIX 262144
char image[MAXPIX];
int pic[MAXPIX];
char imouti[MAXPIX];

main(argc,argv)
char  **argv;
int argc;

{
  FILE *fp, *fpouti,*fpwin;
  register int   i,j;
  float line[512];
  static char file[80], flotfil[80],winfil[80],output[80];
  int N,M,k1,k2,n1,n2,l1,l2,k,r[10];
  float h[10], sum,min,max,diff,del,d1,d2;
  int test,size,number,code,count;
  int fd;


  if(argc != 3)
    {
      printf("The correct usage is : efilt filename size \n");
      exit(1);
    }  

  size = atoi(argv[2]);
  printf("The size of the image is : %d\n",size);

  switch (size)
    {
    case 512:
      number = 262144;
      break;
    case 256:
      number = 65536;
      break;
    case 128:
      number = 16384;
      break;
    case 64:
      number = 4096;
      break;
    case 32:
      number = 1024;
      break;
    case 16:
      number = 256;
      break;
    case 8:
      number = 64;
      break;
    default:
      printf("The size is wrong!\n");
      exit(1);
    }  

/* filter taps---------------------------------- */

  printf("Name of the operator file :\n");
  scanf("%s",winfil);
  
  if((fpwin = fopen(winfil, "r")) == NULL)
    {
      printf("operator data file can not be opened! %s\n", winfil);
      exit(1);
    }  
  for(i=1; i < 10; i++)
    {
      fscanf(fpwin, "%f", &h[i]);
      printf("i= %d h[i]= %f \n",i,h[i]);
    }  

  N=size;

/* open file and read ------------------------------- */

  if((fp = fopen(argv[1], "r")) == NULL)
    {
      printf("image data file can not be opened! %s\n", argv[1]);
      exit(1);
    }  

  test = fread(image, sizeof(char), number, fp);
  printf("no.of samples read %d\n",test);
  printf("size : %d  number : %d \n",size,number);

/* open floating point value file */

  printf("filename for the filtered (float) image :\n");

  scanf("%s",flotfil);

  if((fd = creat(flotfil, 0666)) == ERR)
    {
      printf("file can not be opened :%s\n",flotfil);
      exit(1);
    }
  printf("fd %d %s \n",fd,flotfil);

  for(i=0; i < size; i++)
    {
      line[i] = 0.0;
    }
  
  count = sizeof(float) * size;

  test = write(fd, line, count);
  printf("first line written in :%s  =  %d \n",flotfil,test);  
  printf("line no: %d  fd %d count %d test%d \n",i,fd,count,test);

/*  convert to integer format ---------------------------- */

  for(i=0; i < number; i++)
    {

      pic[i]=image[i];

      if(pic[i] < 0) pic[i]=pic[i]+256;
    }


  printf("pic array is formed!\n");

  min = max = pic[0];


/* filtering and max/min computation  */

  for(i=1; i < (size - 1); i++)
    {
	k1 =  i * size;
      for(j=1; j < (size - 1); j++)
	{
	  sum =0;
	  k = k1 + j;
	  r[1] = k - (size + 1);
	  r[2] = k - size;
	  r[3] = k - (size - 1);
	  r[4] = k - 1;
	  r[5] = k;
	  r[6] = k + 1;
	  r[7] = k + (size - 1);
	  r[8] = k + size;
	  r[9] = k + (size + 1);

	  for(n1=1; n1 < 10; n1++)
	    {
	      if(r[n1] > number)printf("error in r index: n1 %d r[n1] %d k %d\n", n1,r[n1],k);
	      sum +=  pic[r[n1]] * h[n1];
	    }  

	  if(sum > max)max = sum;
	  if(sum < min)min = sum;
	  line[j] = sum;
	}	
      test = write(fd, line, count);
	if (i % 20 == 0)
      printf("line no: %d  fd %d count %d test%d \n",i,fd,count,test);

    }

  for(i=0; i < size; i++)
    {
      line[i]=0.0;
    }
  test = write(fd, line,count);
  printf("last line written %d \n",test);

/* rewind the float file */
  close(fd);

  fd = open(flotfil, 0);
  printf("fd = %d\n",fd);
  printf("maximum value : %f \n",max);
  printf("minimum value : %f \n",min);


  diff = max - min;
  del = diff/256.0;

  for(k=0; k < size; k++)
    {
      test = read(fd,line,count);
	if ( k % 100 == 0)

      printf("line no: %d fd %d count %d test %d \n",k,fd,count,test);
      k1 = k*size;

      for(j=0; j < size; j++)
	{
	  n1 = k1 + j;

	  code = (int)((line[j] - min)/del);
	  if(code > 255 ) code = 255;

	  imouti[n1]=(char)code;
	}  

    }  

  printf("filename for the filtered (integer) image :\n");
  scanf("%s",output);

  if((fpouti = fopen(output, "w")) == NULL)
    {
      printf("file can not be opened :%s\n",output);
      exit(1);
    }

  test = fwrite(imouti, sizeof(char), number, fpouti);

  printf("no.of samples written in :%s  =  %d \n",output,test);  
  close(fd);
  fclose(fpouti);
  fclose(fp);

}


