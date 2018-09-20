#ifndef _DEFS_H
#define _DEFS_H 1


#define ON 1
#define OFF 0
#define ARGPADLEN 16

#define DEFNBOUNDS 4

#define MAXND  2000
#define MAXDMN 50

#define MAXVARNAME 32

#define PAD_SUBI 256

#define OK               (1)
#define OKTOEXIT         1
#define ERR2EXIT         2
#define ERR3EXIT         3

#define FAIL             (-1)
#define ERRN1             (-1)
#define ERRN2             (-2)
#define ERRN3             (-3)




typedef int asl_return_code ; 

#include <ctype.h>

enum datatype {

  NOT_KNOWN_DTYPE = -3,
  UNKNOWN_TYPE	  = -2,  // max siv.h type is char - use -1 as UNSET
  UNSET  = -1,
  ASCII  =  0,          /* fixed char - record - size can be declared */
  CHAR   =  1,
  SHORT  =  2,
  INT    =  3,
  FLOAT  =  4,
  DOUBLE =  5,
  UCHAR  =  6,
  SVAR   =  7,         // array of varchars 
  PAN    =  8,          // arbitary precision number - default base 256 
  HEX    =  9,
  STRING =  10,   // vector of chars
  GSTRING = 10,   // vector of chars
  VARIABLE = 11,
  FRVALUE  = 12,
  GENERIC  = 13,   // holds anything - converted to anything on assignment */
  UINT     = 14,
  USHORT   = 15,
  PTR      = 16,   // points to an asl variable - index into array */
  LONG     = 17,
  ULONG    = 18,
  SCLASS   = 19,
  CMPLX    = 20,
  DCMPLX   = 21,
  PCMPLX   = 22,
  LDCMPLX  = 23,
  LDOUBLE  = 24,
  BOOLEAN  = 25,
  RECORD   = 26,
  TRUED    = 27,
  FALSED   = 28,
  LIST     = 29,
  SVSTRING = 30,  //  svar variable (size 1 not array) holds char vector
  STRV     =  30,  //  svar (size 1)  used to hold variable length vector of chars
  THIS     =  31,  
  HASH     =  32, 
  GEVENT   =  33, 
  GCONTOUR =  34, 
  S64     =  35, 
  U64     =  36,
  PANSTR  =  37,
  MAXTYPE = 38,  // valid type less than MAXTYPE >= 0
};
// 
//
#define ISOK 1
#define NOTOK -1
#define ABORT_STATEMENT -2
#define MAYBEOK -3

enum asl_error_codes {
 SUCCESS = 0,
 HEADER_ERROR,
 UNBALPARAN_ERROR,
 INVALID_EXP_ERROR,
 IF_SYN_ERROR,
 WHILE_SYN_ERROR,
 EOF_ERROR,
 STR_ERROR,
 MALLOC_ERROR,
 EOL_ERROR,
 FOPEN_ERROR              ,
 VAR_NOT_DEFINED          ,
 PARSE_ERROR,
 FPE_ERROR ,
 READ_ERROR               ,
 WRITE_ERROR              ,
 ARRAY_ERROR              ,
 DIMENSION_ERROR          ,
 FUNC_NOT_FOUND_ERROR     ,
 COMMAND_INVALID_ERROR    ,
 SCALE_ERROR              ,
 VAR_DEFINE_ERROR         ,
 VAR_STORE_ERROR          ,
 VAR_NOT_SET              ,
 PTR_OUT_OF_BOUNDS        ,
 MATRIX_REDIMENSION       ,
 ARG_CNT_ERROR            ,
 ARG_CNT            ,
 DECLARE_ERROR            ,
 NEW_ERROR                ,
 CONVERT_ERROR            ,
 PANCOPY_ERROR            ,
 CONCAT_ARRAY_ERROR       ,
 PROMOTE_ERROR            ,
 RUNPAST_ERROR            ,
 LINK_ERROR               ,
 WRONG_TYPE_ERROR         ,
 INVALID_SIV_ERROR        ,
 STRING_ERROR             ,
 TYPE_UNSET_ERROR         ,
 MEMBER_ACCESS_ERROR      ,
 OFFSET_ERROR             ,
 ARRAY_STORE_ERROR        ,
 POPEN_ERROR              ,
 OPERA_ERROR              ,
 SVAR_FIELD_ERROR         ,
 SVAR_SLEN_ERROR          ,
 ARRAY_COPY_ERROR,
 SYNTAX_ERROR	         ,
 NUM_ERROR	         ,
 FUNC_ARG_ERROR           ,
 MODIFY_CONST_ERROR,
 NOT_AN_ARRAY_ERROR,
 ARRAY_BOUNDS_ERROR,
 NAME_OVERRUN,
 IGNORE_ERROR,
 CREATE_VAR_ERROR,
 SCAN_ERROR,
 SIZE_ERROR,
 LIST_ERROR,
 NAME_TOO_LONG_ERROR,
 PARTIAL_WRITE_ERROR,
 SRS_RECEIVE_ERROR,
 TIME_OUT_ERROR,
 ID_ERROR,
 DYNAMIC_ERROR,
 BAD_SARGS,
 NO_FILE_DATA,
 RESULTVEC_ERROR,
 ANN_ERROR,
 GETARGSIV_ERROR,
 COMPUTE_ERROR,
 LOOKUP_CLASS_ERROR,
 INVALID_OBJMEMBER_ERROR,
 PAN_VALUE_ERROR,
 COM_SETUP_ERROR,
 WGM_ERROR,
 BAD_GLINE,
 NULL_PARA,
 NEG_PARA,
 COM_SOCK_SEND_ERROR,
 COM_SOCK_RECV_ERROR,
 RECORD_ERROR,
 PATH_ERROR,
 PIPE_ERROR,
 FORK_ERROR,
 DLL_ERROR,
 BAD_MEMP,
 NOT_CODED_ERROR,
 REALLOC_ERROR,
 PROC_NOT_FOUND_ERROR, 
  UNKNOWN_ERROR,
};


enum ds_type {
	      DS_SCALAR =1,
	      DS_VECTOR,
	      DS_MATRIX,
	      DS_STRV,
	      DS_SVAR,
	      DS_PAN,
	      DS_RECORD,
	      DS_LIST,
	      DS_BTREE,
};


////////////



int sfree(void *ptr, char *name);

void sfree(void *ptr);
void StrNCopy(char *to, const char *from, int maxn);
int strLen(const char *s);
void *scalloc_id(int n, int msize, const char *key);
void *srealloc_id(void *optr, int nbytes, const char *key);
char * AdvancePastWhite(char *t);
char * NextWhite(char *t);
void whatError( int en, const char *where) ;

int computeMemSize( int m, int type);


extern int  Floatsz;
extern int  Doublesz;
extern int  Charsz;
extern int  Intsz;
extern int  Shortsz;
extern int  Longsz;





#endif


