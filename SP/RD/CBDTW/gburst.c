#include <gasp-conf.h>

#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


#define DFT 1
#define IDFT -1
#define MAXSWAP 8
#define SAMPFREQ 16000
#define IOBUFSIZE 16384
#define SSIZE sizeof(short)
#define FSIZE sizeof(float)
#define SWAP(a,b) tempr=(a);(a)=(b);(b)=tempr
#define PI        3.14159265358979
#define PI2       6.28318530717959
 

FILE	*intimit, *outgfe, *inscript;
char	swapstr[MAXSWAP][255];
char	gfefname[255], timitfname[255], temp[255];
char	scriptfname[255], change[255], iobuf[IOBUFSIZE];
short	*filebuf, *data, *datain;
int	ppf, verbose, script, lastswap;
int	framelen, step, fftlen, fftorder, numcoeffs;
long	frame, numframes, numsamples;
float	preemph, lastsamp;
float	*fftdata, *fdata, *coeff, *hamm;
double  *sine, *sinesqr;


void	parse(void);
void	strrpl(char *str, char *find, char *rpl);
void	exchange(void);
void 	getflags(int argc, char *argv[]);
void 	showflags(void);
void 	showinfo(void);
void 	showdata(void);
void 	opengfe(void);
void 	getmemory(void);
void 	freememory(void);
void 	getframe(void);
void	getfilebuf(void);
void 	calc_coeff(void);
float   calc_spec(int lo, int hi);
float	calc_median(int lo, int hi);
void 	fftfour(float *data, int nn, int isign);
void	calc_sine(void);
void	calc_hamm(void);
void 	hamming(void);
float 	hz2bark(float f);
float 	bark2hz(float z);
int	qscompare(float *x, float *y);
float 	roundup(float num);



int main(int argc, char *argv[])
{
  ppf = 1;
  step = 160;
  framelen = 400;
  fftlen = 512;
  fftorder = 9;
  numcoeffs = 32;
  preemph = 0.0;
  verbose = 0;
  script = 0;

  if (argc < 3)
  {
    printf("Usage : gburst [-l L -s S -f F -p P -v V -S] infile outfile {1.51}\n");
    printf(" -l L : frame length in samples (400)\n");
    printf(" -s S : step size in samples (160)\n");
    printf(" -f F : number of FFT coeffs (32)\n");
    printf(" -p P : preemphasis (0.0)\n");
    printf(" -v V : verbose (0)\n");
    printf(" -S   : script (infile)\n");
    exit(0);
  }

  getflags(argc,argv);
  if (verbose) showflags();

  getmemory();
  
  calc_hamm();
  calc_sine();

  if (script)
  {
    if ((inscript = fopen(scriptfname,"rt"))==NULL) 
    {
      printf("Unable to open SCRIPT file %s\n",scriptfname);
      exit(0);
    }

    if (fgets(timitfname,255,inscript) == NULL)
    {
      printf("Unable to read SCRIPT file %s\n",scriptfname);
      exit(0);
    }

   parse();
  }

  do
  {
    if (script)
    {
      strncpy(temp,"",255);
      strncpy(temp,timitfname,strlen(timitfname)-1);
      strcpy(timitfname,temp);
      exchange();
    }

    if (!strcmp(timitfname,gfefname))
    {
      printf("Input and output are the same\n%s\n%s\n",timitfname,gfefname);
      exit(0);
    }

    getfilebuf();
    opengfe();

    if (verbose) showinfo();

    frame = 0;

    while (frame < numframes)
    {
      getframe();
      hamming();
      calc_coeff();

      coeff[0] = calc_spec(0,1000);
      if (coeff[0] >= 10.0) coeff[0] = 1.0;
      else coeff[0] = 0.0;
/*
      coeff[0] = calc_spec(1500,3500);
      if (coeff[0] >= 100.0) coeff[0] = 1.0;
      else coeff[0] = 0.0;
*/
      fwrite(&coeff[0],FSIZE,ppf,outgfe);

      if (verbose >= 2) showdata();
    }

    if (!verbose) printf("%s\n",gfefname);

    fclose(outgfe);
    free(filebuf);
  }
  while (script && fgets(timitfname,255,inscript) != NULL);
  
  if (script) fclose(inscript);

  freememory();

  return(0);
}


void parse()
{
  int i, j;
  char *sptr;

  for (i=0; i<MAXSWAP; i++)
    strncpy(swapstr[i],"",255);

  i = 0;
  j = 0;

  while (change[j] == '^') j++;
  strcpy(swapstr[i],change+j);
  sptr = strtok(swapstr[i],"^");
  
  do
  {
    sptr = strtok(NULL,"^");
    if (sptr != NULL) strcpy(swapstr[++i],sptr);
  }
  while (sptr != NULL && i < MAXSWAP-1);

  lastswap = i;
}


void strrpl(char *str, char *find, char *rpl)
{
  int i, j, num;
  char orgstr[255];

  if (strlen(find) > 0 && strlen(rpl) > 0 && strstr(str,find) != NULL)
  {
    strncpy(orgstr,str,255);

    num = (int)(strstr(str,find) - str);
    strncpy(str,"",255);
    strncpy(str,orgstr,num);
    strcat(str,rpl);

    j = strlen(str);
    for (i=num+strlen(find); i<strlen(orgstr); i++)
      str[j++] = orgstr[i];
  }
}


void exchange()
{
  int i;

  strcpy(gfefname,timitfname);

  for (i=0; i<=lastswap; i+=2)
    strrpl(gfefname,swapstr[i],swapstr[i+1]);
}


void getflags(int argc, char *argv[])
{
  int i;
  char ch;

  for (i=1; i<argc-1; i++)
  {
    if ((ch = *argv[i]) == '-')
    {
      switch (*++(argv[i]))
      {
        case 'l' : framelen = atoi(argv[++i]);
                   break;
        case 's' : step = atoi(argv[++i]);
                   break;
        case 'f' : numcoeffs = atoi(argv[++i]);
                   ppf = numcoeffs+2;
                   break;
        case 'p' : preemph = atof(argv[++i]);
                   break;
        case 'v' : verbose = atoi(argv[++i]);
                   break;
        case 'S' : script = 1;
                   break;
        default  : printf("Warning : flag -%c ignored\n",ch);
      }
    }
  }

  if (script)
  {
    strcpy(scriptfname,argv[argc-2]);
    strcpy(change,argv[argc-1]);
  }
  else
  {
    strcpy(timitfname,argv[argc-2]);
    strcpy(gfefname,argv[argc-1]);
  }
}


void showflags()
{
  printf("GFFT - Spectral Stuff and FFT\n\n");
  printf("P per frame : %d\n",ppf);
  printf("Frame length: %d (%4.1fms)\n",framelen,(float)framelen*1000/SAMPFREQ);
  printf("Step size   : %d (%4.1fms)\n",step,(float)step*1000/SAMPFREQ);
  printf("FFT coeffs  : %d\n",numcoeffs);
  printf("CG coeffs   : %d\n",2);
  printf("Preemphasis : %2.2f\n",preemph);
}


void showdata()
{
  int i;

  printf("\nFrame %4d :",frame);
 
  for (i=0; i<ppf; i++)
  {
    if (i % 4 == 0) printf("\n");  
    printf("%2d : % 10f  ",i,coeff[i]);
  }
  printf("\n");
}


void showinfo()
{
  printf("\n");
  printf("No. samples : %ld\n",numsamples);
  printf("No. frames  : %d\n",numframes);
  printf("Input file  : %s\n",timitfname);
  printf("Output file : %s\n",gfefname);
  if (script) printf("Script file : %s\n",scriptfname);
}


void opengfe()
{
  if ((outgfe = fopen(gfefname,"wb"))==NULL) 
  {
    printf("Unable to create GFE output file %s\n",gfefname);
    exit(0);
  }

  setvbuf(outgfe,iobuf,_IOFBF,IOBUFSIZE);
  fwrite(&ppf,sizeof(int),1,outgfe);
}


void getmemory()
{
  if ((data = calloc(framelen,SSIZE)) == NULL)
  {
    printf("Unable to allocate 'data' (%d)\n",framelen);
    exit(0);
  }

  if ((datain = calloc(framelen,SSIZE)) == NULL)
  {
    printf("Unable to allocate 'datain' (%d)\n",framelen);
    exit(0);
  }

  if ((fdata = calloc(framelen,FSIZE)) == NULL)
  {
    printf("Unable to allocate 'fdata' (%d)\n",framelen);
    exit(0);
  }

  if ((hamm = calloc(framelen,FSIZE)) == NULL)
  {
    printf("Unable to allocate 'hamm' (%d)\n",framelen);
    exit(0);
  }

  if ((fftdata = calloc(2*fftlen,FSIZE)) == NULL)
  {
    printf("Unable to allocate 'fftdata' (%d)\n",2*fftlen);
    exit(0);
  }

  if ((coeff = calloc(ppf,FSIZE)) == NULL)
  {
    printf("Unable to allocate 'coeff' (%d)\n",numcoeffs);
    exit(0);
  }

  if ((sine = calloc(fftorder+1,sizeof(double))) == NULL)
  {
    printf("Unable to allocate 'sine' (%d)\n",fftorder+1);
    exit(0);
  }

  if ((sinesqr = calloc(fftorder+1,sizeof(double))) == NULL)
  {
    printf("Unable to allocate 'sinesqr' (%d)\n",fftorder+1);
    exit(0);
  }
}


void freememory()
{
  free(data);
  free(datain);
  free(fdata);
  free(hamm);
  free(fftdata);
  free(coeff);
  free(sine);
  free(sinesqr);
}


void getfilebuf()
{
  if ((intimit = fopen(timitfname,"rb"))==NULL) 
  {
    printf("Unable to open TIMIT input file %s\n",timitfname);
    exit(0);
  }

  fseek(intimit,0,0);
  fseek(intimit,0,2);

  numsamples = (ftell(intimit) - 1024) / SSIZE;
  numframes = roundup((float)(numsamples+step-framelen)/(float)(step));

  if ((filebuf = calloc(numsamples+framelen,SSIZE)) == NULL)
  {
    printf("Unable to allocate 'filebuf' (%d)\n",numsamples+framelen);
    exit(0);
  }

  fseek(intimit,1024,0);
  fread(filebuf,SSIZE,numsamples,intimit);

  fclose(intimit);
}


void getframe()
{
  memcpy(data,filebuf+(long)(frame*step),framelen*SSIZE);
/*  swab((char *)datain,(char *)data,framelen*SSIZE);*/
  frame++;
}


void calc_coeff()
{
  int i, j, k, n, avg;
  double sum, rsum, isum;

  for (i=0; i<fftlen; i++)
  {
    if (i >= framelen)
    {
      fftdata[2*i] = 0.0;
      fftdata[(2*i)+1] = 0.0;
    }
    else
    {
      fftdata[2*i] = fdata[i];
      fftdata[(2*i)+1] = 0.0;
    }
  }

  fftfour(fftdata-1,fftlen,DFT);

  avg = (fftlen>>1)/numcoeffs;

  fftdata[0] = 0.0;
  fftdata[1] = 0.0;
/*
  for (n=0; n<numcoeffs; n++)
  {
    rsum = 0.0;
    isum = 0.0;
    sum = 0.0;

    for (j=n*avg; j<avg*(1+n); j++)
    {
      rsum = fftdata[2*j];
      isum = fftdata[2*j+1];
      sum += sqrt(rsum*rsum + isum*isum);
    }

    if (sum > 1.0e-6) 
      coeff[n] = log(sum/avg);
    else coeff[n] = -1.0e10;
  }
*/
}


float calc_spec(int lo, int hi)
{
  int j;
  float half, centre, freqbin;
  double rsum, isum;

  freqbin = (float)SAMPFREQ/fftlen;
  lo /= freqbin;
  hi /= freqbin;

  rsum = 0.0;
  isum = 0.0;
  half = 0.0;

  for (j=lo; j<=hi; j++)
  {
    rsum = fftdata[2*j];
    isum = fftdata[2*j+1];
    half += sqrt(rsum*rsum + isum*isum);
  }

  rsum = 0.0;
  isum = 0.0;
  centre = 0.0;

  for (j=lo; j<=hi; j++)
  {
    rsum = fftdata[2*j];
    isum = fftdata[2*j+1];
    centre += sqrt(rsum*rsum + isum*isum);
    if (centre >= half/2)
    {
      break;
    }
  }

  return((float)j);
}


float calc_median(int lo, int hi)
{
  int i, j;
  float freqbin, median;
  double rsum, isum;

  freqbin = (float)SAMPFREQ/fftlen;
  lo /= freqbin;
  hi /= freqbin;

  rsum = 0.0;
  isum = 0.0;
  i = 0;

  for (j=lo; j<=hi; j++)
  {
    rsum = fftdata[2*j];
    isum = fftdata[2*j+1];
    fdata[i] = sqrt(rsum*rsum + isum*isum);
    i++;
  }

  qsort(fdata,(1+hi-lo),FSIZE,(void *)qscompare); 

  if (hi-lo & 0x01 == 1)
    median = 0.5*(fdata[(1+hi-lo)/2]+fdata[(hi-lo-1)/2]);
  else median = fdata[(hi-lo)/2];

  return(median);
}


void fftfour(float *data, int nn, int isign)
{
  int i, j, istep, n, mmax, m, c;
  double wtemp, wr, wpr, wpi, wi;
  float tempr, tempi;

  n = nn << 1;
  j = 1;

  for (i=1; i<n; i+=2)
  {
    if (j > i)
    {
      SWAP(data[j],data[i]);
      SWAP(data[j+1],data[i+1]);
    }
    m = n >> 1;
    while (m >=2 && j > m)
    {
      j -= m;
      m >>= 1;
    }
    j += m;
  }

  c = 1;
  mmax = 2;
  while (n > mmax)
  {
    istep = 2*mmax;

    wpr = isign*sinesqr[c];
    wpi = isign*sine[c];
    c++;
    wr = 1.0;
    wi = 0.0;

    for (m=1; m<mmax; m+=2)
    {
      for (i=m; i<=n; i+=istep)
      {
        j = i+mmax;
        tempr = wr*data[j]-wi*data[j+1];
        tempi = wr*data[j+1]+wi*data[j];
        data[j] = data[i]-tempr;
        data[j+1] = data[i+1]-tempi;
        data[i] += tempr;
        data[i+1] += tempi;
      }
      wr = (wtemp=wr)*wpr-wi*wpi+wr;
      wi = wi*wpr+wtemp*wpi+wi;
    }
    mmax = istep;
  }
}


void calc_sine()
{
  int i;

  for (i=1; i<=fftorder; i++)
  {
    sine[i] = sin(PI2/pow(2,i));
    sinesqr[i] = -2.0*sin(PI/pow(2,i))*sin(PI/pow(2,i));
  }
}

 
void calc_hamm()
{
  int i;
  double hammy;
 
  hammy = PI2/(framelen-1);
 
  for (i=0; i<framelen; i++)
    hamm[i] = (0.54-0.46*cos(i*hammy));
}
 

void hamming()
{
  int i;
 
  for (i=0; i<framelen; i++)
  {
    fdata[i] = (data[i] - (preemph*lastsamp))*hamm[i];
    lastsamp = data[i];
  }
}
 

float hz2bark(float f)
{
  float y, z;

  y = f/600.0;
  z = 6.0*log(y + sqrt(1+y*y));

  return(z);
}


float bark2hz(float z)
{
  return(600.0*sinh(z/6.0));
}


int qscompare(float *x, float *y)
{
  int diff;

  if (*x > *y) diff = 1;
    else if (*x < *y) diff = -1;
    else diff = 0;

  return(diff);
}
 

float roundup(float num)
{
  if (num - (int)(num) != 0)
    num = (int)(++num);

  return(num);
}

