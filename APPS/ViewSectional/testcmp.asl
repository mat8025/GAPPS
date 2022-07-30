///
///
///


     AF= ofr("den103.cmp")

uint PH[3]

nir=vread(AF,PH,3,UINT_)


int npix = PH[0]
int drows = PH[2]
int dcols = PH[1]

<<"%V $npix $drows $dcols \n"


uchar CPIX[>2000]


  for (j=0;j<drows;j++) {
   nir=vread(AF,CPIX,dcols,UCHAR_)

<<"$CPIX[0:dcols-1:10]\n"
ans=query()
if (ans @= "q")
    break;
  }

nrows = 10
ncols = dcols
sec_row = 0
sec_col = 0
skip_row = 0
skip_col = 0;

    fseek(AF,12,0)

     npixr = mread(AF,CPIX,nrows,ncols,drows,dcols,sec_row,sec_col,skip_row,skip_col)

<<"$npixr    $(Cab(CPIX)) \n"
ans=query()
  for (j=0;j<nrows;j++) {
<<"$CPIX[j][0:ncols-1:10]\n"
ans=query()
if (ans @= "q")
  exit()

  }



///////////// BUG ///////////////////
//<<"$CPIX[0:(dcols-1):10]\n"

// experssion in range spec not parsed