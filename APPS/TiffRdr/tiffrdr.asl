///
///  tiffrdr
///



enum Ftype {
       BYTE =1,
       ASCII,
       SHORT,
       LONG,
       RATIONAL,
       SBYTE,
       UNDEFINED,
       SSHORT,
       SLONG,
       SRATIONAL,
       FLOAT,
       DOUBLE
}

enum Tagtype {
       ImageWidth =256,
       ImageLength,       
       BitsPerSample =258,
       Compression = 259,
       PhotometricInterpretation = 262,
       FillOrder = 266,
       DocumentName = 269,
       ImageDescription = 270,
       Make = 271,
       Model = 272,              
       StripOffsets = 273,
       Orientation = 274,       
       SamplesPerPixel = 277,
       RowsPerStrip = 278,
       StripByteCounts = 279,
       MinSampleValue =280,              
       MaxSampleValue =281,       
       XResolution =282,
       YResolution =283,
       PlanarConfiguration =284,
       PageName = 285,
       XPosition = 286,
       YPosition = 287,              
       FreeOffsets =288,
       FreeByteCounts =289,
       GrayResponseCurve = 291,
       T4Options = 292,
       T6Options = 293,                     
       ResolutionUnit = 296,
       PageNumber = 297,
       TransferFunction = 301,
       Software = 305,       
       TransferRange = 342,              
       DateTime = 306,
       HostComputer = 316,
       Predictor = 317,
       WhitePoint = 318,       
       HalftoneHints = 321,       
       TileWidth = 322,
       TileLength = 323,
       TileOffsets = 324,
       TileByteCounts = 325,                     
       ColorMap = 320,
       InkSet = 332,
       InkNames = 333,       
       NumberOfInks = 334,
       DotRange = 336,                     
       ExtraSamples = 338,
       SampleFormat = 339,
       JPEGProc = 512,
       CopyRight = 33432,
       
}

ushort tag;
short ftype;
int count;

short sval;
long LV[100];
int IV[100];
ushort SV[100];
ushort RGB[3];

uint STRPOF[500]
uint STRPBC[500]

uchar  istrip[9000];

nstrips = 0;

proc getIFD( )
{
    static int ifd = 0;

   IFDS[ifd][::] = CF;
<<"IFDS<$ifd> $IFDS[ifd][::] \n"
    cfv = IFDS[ifd][::];
    cfv->redimn();
 //   <<"$cfv\n"
    
   bscan(cfv,0,&tag,&ftype, &count, &offset);
   fts=Ftype->enumNameFromValue(ftype);
   tags = Tagtype->enumNameFromValue(tag)
<<"%V $tag $tags  $ftype $fts $count $offset\n"
   where = ftell(A);
   fseek(A,offset,0)

   if (tag == StripByteCounts) {

       kb = fscanv(A,0,"I500",&STRPBC);

        <<"SBC\n %(10,, ,\n)$STRPBC\n"
   }

   if (tag == ImageLength) {
       nstrips = offset;
   }
   if (tag == StripOffsets) {

       kb = fscanv(A,0,"I500",&STRPOF);

        <<"SO\n %(10,, ,\n)$STRPOF\n"
   }

   if (tag == ColorMap) {

       ncm = count/3;

       for (kr = 0; kr <ncm; kr++) {
       kb = fscanv(A,0,"S3",&RGB);

        <<"$RGB\n"
       if (kr >10) break;
      }
   }



   if (ftype == ASCII) {
   cfmt = "C$count"
kb = fscanv(A,0,"$cfmt",&CV);
    wrd = sncat (CV,count)
 //  <<"%s$CV[0:count-1] \n"
      <<"$wrd \n"
   }

   if ((ftype == SHORT)) {
   if  (count > 1) {
   kb = fscanv(A,0,"S1",&sval);
   <<"[0] value is  $sval\n"
   }
   else {
   <<"value is  $offset\n"
   }
   }


 //  <<"back @ $where\n"
    fseek(A,where,0)
   
    ifd++;
}
//============================//

 fname = _clarg[1];

 A= ofr(fname)

 if (A ==-1) {
   exit()
}


int a = 0x49;

<<"%V$a\n"
 if (a == 0x49) {
<<" hex correct %x $a %d $a\n"
}


uchar IFDS[50][12];

Char CV[100];
Uchar CF[12];

int offset;

kb = fscanv(A,0,"C4,I1",&CV,&offset);

<<" %x $CV \n"
<<"%d $CV\n"
if ((CV[0] == 73) && (CV[1] == 73) && (CV[2] == 42)) {
 <<"tiff header detected!\n"
<<"little endian\n"
}

<<"%V$offset bytes\n"
// ssek to offset
int nf;
kb = fscanv(A,0,"S1",&nf);

<<"%V$nf\n"
   where = ftell(A);
 <<"%V$where \n"  
for (i= 0; i < nf; i++) {

kb = fscanv(A,0,"C12",&CF);
//<<"$i : <$kb>  $CF\n"
getIFD();

}

kb = fscanv(A,0,"I1",&offset);

<<"%V$offset bytes\n"


// show first 10 strip
if (nstrips > 500) {
 nstrips = 500;
}
for (i= 0; i <nstrips ;i++) {

where = STRPOF[i];
fseek(A,where,0)
here = ftell(A)

nvals = STRPBC[i]
sfmt = "C$nvals"
<<"offset $where $here $sfmt\n"
kb = fscanv(A,0,sfmt,&istrip);

//<<"%(25,, ,\n)$istrip[0:nvals-1]\n"
<<"%(25,, ,\n)$istrip[0:199]\n"
here = ftell(A)
<<"<$i> now @ $here\n"
}

exit();