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

proc getIFD( )
{

  bscan(CF,0,&tag,&ftype, &count, &offset);
   fts=Ftype->enumNameFromValue(ftype);
   tags = Tagtype->enumNameFromValue(tag)
<<"$tag $tags  $ftype $fts $count $offset\n"

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


Char CV[20];
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

for (i= 0; i < nf; i++) {

kb = fscanv(A,0,"C12",&CF);
<<"$i : <$kb>  $CF\n"
getIFD();

}

kb = fscanv(A,0,"I1",&offset);

<<"%V$offset bytes\n"

exit();