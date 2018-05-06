///
///   LZW coder
///

setDebug(1,@keep)



//===================================//
// compress
/{
   InitializeStringTable();
WriteCode(ClearCode);
= the empty string;
for each character in the strip {
K = GetNextCharacter();
if +K is in the string table {
= +K; /* string concatenation */
} else {
WriteCode (CodeFromString( ));
AddTableEntry( +K);
= K;
}
} /* end of for loop */
WriteCode (CodeFromString( ));
WriteCode (EndOfInformation);

/}

//====================================//
//  decompress
/{
while ((Code = GetNextCode()) != EoiCode) {
if (Code == ClearCode) {
InitializeTable();
Code = GetNextCode();
if (Code == EoiCode)
break;
WriteString(StringFromCode(Code));
OldCode = Code;
} /* end of ClearCode case */
else {
if (IsInTable(Code)) {
WriteString(StringFromCode(Code));
AddStringToTable(StringFromCode(OldCode
)+FirstChar(StringFromCode(Code)));
OldCode = Code;
} else {
OutString = StringFromCode(OldCode) +
FirstChar(StringFromCode(OldCode));
WriteString(OutString);
AddStringToTable(OutString);
OldCode = Code;
}
} /* end of not-ClearCode case */
} /* end of while loop */
The function GetNextCode() retrieves the next code from the LZW-coded data. It
must keep track of bit boundaries. It knows that the first code that it gets will be a
9-bit code. We add a table entry each time we get a code. So, GetNextCode() must
switch over to 10-bit codes as soon as string #510 is stored into the table. Simi-
larly, the switch is made to 11-bit codes after #1022 and to 12-bit codes after
#2046.
/}


proc InitializeStringTable()
{



}

//===============================//
proc WriteCode ( cd)
{

 <<"<$cd>"


}
//===============================//
proc CodeFromString()
{




}

//===============================//

proc getNextChar()
{

  cn = Input[Ic];
  Ic++;

  return cn;
}
//===============================//

char EOI;
uchar CLEARCODE = 256;

uchar Input[20] = {7,7,7,8,8,7,7,6,6};

<<"$Input \n"


ushort cs;

//short Table[5000][2];

int vi[2] = {0,0}
<<"$vi \n"

int vs[2] = {1,1}



Table = vvgen(SHORT_,10000,vi,vs)


//<<"%(2,, ,\n)$Table \n"

Table->redimn(5000,2)

//  for (i=  0; i< 258; i++) {
//      Table[i][::] = i;
//  }

<<"$Table[0:258][::]\n"

exit()


int Ic= 0;
// compress

// open file for char read

//  read char a time and build codes

// open file for output

//  write out codes


// string Table ?
// Record  [][2]

//   cs= 47;
//   <<"$cs\n";

str S="";
   cs= 256;
   <<"$cs\n";
   WriteCode(cs);

int nloop =0;
  while (1) {

     K = getNextChar();
     S = scat(S,"$K")
<<"\n$nloop  $K $S\n"     
exit()
       if ( isInTable(S) ) {
          // scat (k,pk) ; // strcat
       }
       else {

           cs = CodeFromString();
            WriteCode(cs);
            AddTableEntry(pK);
       }
    nloop++;
    if (nloop >= 1) {
     break;
    }

   }

exit();

   cs = CodeFromString();
   WriteCode(cs);
   WriteCode(EOI);


//