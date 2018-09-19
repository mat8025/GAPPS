#ifndef _SVAR_H
#define _SVAR_H 1

#include <stdint.h>

#define MAXSVARSZ 8192
#define MAXDOUBLECHAR 8192

#define NULL_CHAR  0
#define ZERO_FIELD 0
#define FIRST_FIELD 1
#define SECOND_FIELD 2
#define THIRD_FIELD 3

#define SV_NAME_LEN 16

#define SVARCHARINC 64
#define SVARPADLEN  256
#define SVALUELEN 32
#define SFVALUELEN 16





#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>


/*  bit-code svar variable attribute word */
#define INUSE		        0x1	   //<bit 0>
#define FILTER		        0x2	   //<bit 1>
#define DELREC		        0x4	   //<bit 2>
#define MEMALC		        0x8	   //<bit 3>
#define POOLSV		        0x10	   //<bit 4>


enum Svar_type {
  SVAR_VECTOR,
  SVAR_HASH,
  SVAR_TABLE,
};

class Siv;
class Key;
//class GS_Litem;


class Svar {
  int narg;
  int nfields;
  int nrecords;
  int keycol;
  int type;
  int subsize;
  int lhindex;  // should be uints?
  int lhsubsize;
  uint32_t  cw;
  int *subset;        
  int *lhsubset;        
  int *sz;

 public:
        unsigned int id;
        char name[18];
        int argc;
        int cindex;
        char  **ap;
        /////////////////////////////
        Svar();
        Svar(const char *tag);
        Svar(const char *tag,int n);
        Svar(int n);
        ~Svar();
        int init (int n);

        /////////// member functions ///////////////////////////
        int testSVCW(int wd) { return ((cw & wd)); };
	void setSVCW(int wd, int onoff)  { cw = (onoff) ? (cw | wd) : (cw & ~wd);};
	char * cptr (int index);
        char * cptr ();  // really needs to be const
        char cval (int sindex,int index);
        char * getStr (int index);
        int  getWord (int nw, Svar *ans, int index= -1);	
	char * searchKey (const char *sstr, int& keyindex, Key *keyp, int index = 0 ); // default arg
        char * sscan (const char *value);
        char * sscan (const char *value, int index);
        char * sscan (Svar *svar);
        char * sscan (Svar *svar, int index);
        const char * getCptr (int windex);
        const char *returnVarAsStr(Siv *rsivp, int windex = 0);
        float strCompare (const char *pat, int index, int sindex, int ignore_case = 1);
        int cat (const char *value);
        int cat (const char *value, int index);
        int cat (Svar *svar);
        int cCmp (char v,int sindex);
        int cCmp (char v,int sindex,int index);
        int clear (int sindex, int index);
        int copy (char *value,  int len, int index);
        int copy (Svar *sv);
        int cpy (const char *value);
        int cpy (const char *value, int index);
        int cpy (int findex, int tindex);
        int cpysubset (Svar *from ,int index);
        int cpy (Svar *svar);
        int cpy (Svar *svar, int index);
        int cpy (Svar *svar, int vindex, int index);
        int cset (char value, int sindex);
        int cset (char value, int sindex, int index, int nc = 1);
        int cut (int vec[], int n);
        int dewhite ();
        int dewhite (int index);
        int eatWhiteEnds (int index);
        int findExpBetween(char s[], char delb, char dele, int index);
        int findMatch  (char *s, int icase, int nc, int si, int dir);
        int findStr (const char *pat, int index, int sindex = 0, int scase = 1);
        int findTokens (const char s[], char c, int windex = 0, int quoted = 0, int step = 1, int online =1);
        int findVal (char *s1 , int sindex, int direction, int all, int rvec[]);
        int findWords (const char s[]);
        int findWsTokens (const char s[], int windex = 0);
        int fsgets(FILE *stream, long maxsize = -1);
        int getElementSz(int i) { if (i >= 0 && i < narg) return sz[i]; else return -1; };
        int getKeyValueIndex (int index);
        int getlhsubset () { return lhsubset[0]; };
  //int getLitemAsStr(GS_Litem *item);
  //    int getLitemAsStr(GS_Litem *item, char *fmt);
        int getNarg() { return narg ;};
        int getNumFields () { return nfields; };
        int getType () { return type; };
        int getSubSize() { return subsize;};
        int getVarAsStr (Siv *rsivp);
        int getVarAsStr (Siv *rsivp, char *fmt);
        int getVarAsStr (Siv *rsivp, int windex);
        int hashKeyLookUp (const char *key, int addkey);
        int initTable(int ssz, int ttype, int nf);
        int join ();
	int keyLookUp (const char *key, int index = 0 );
        int keySort ();
	int keyValue (const char *key, const char *value, int index = -1);  // default arg
	int keyValue (const char *key, float fvalue, int index = -1);  // default arg
	int keyValue (const char *key, int ivalue, int index = -1);  // default arg
        int lhsetsubset(int n);
        int ncat (const char *value, int ilen);
        int ncat (const char *value, int ilen, int index);
        int ncpy (const char *value, int ilen);
        int ncpy (const char *value, int ilen, int index);
        int parseTokens (char s[], int windex = 0);
        int paste (const char *value, int sindex);
        int paste (const char *value, int sindex, int index);
        int pastesubset (Svar *from, int index);
	int readWsTokens(FILE *fs);
	int readTokens(FILE *fs, char del);
	
        int SelTokens  (char *s1, int P[] , int n, int do_rem);
        int setNfieldsKey (int nf, int key);
        int setsubset( int cindex[], int n);
        int slen ( int index);
        int sort ();
        int splice (const char *value,int cindex);
        int splice (const char *value,int cindex, int index);
        int strCmp (const char *pat, int index, int sindex = 0);
        int strnCmp (const char *pat, int n, int index, int sindex = 0);
        int strMatch (const char *pat, int index, int sindex = 0);
        int strPrintf(int index,const char *format, ...);
        int strSub(const char *fors,const char *istr, int index, int sindex = 0, int dir = 1); // default arg
        int valloc (int index, int len);
        int valueNumSort ();
        int valueSort ();
        int vrealloc (int na);
        int vstrlen ();
        int vstrlen ( int index);
        int white (int len, int sindex);
        int white (int len, int sindex, int index);
        void clear (int index);
        void reverse ();
        void setNarg(int n) { narg = n ;};
        void setNumFields (int rl) { if (rl >=1) { nfields = rl ;};};
        void setType(int wtype);
        void shuffle (int ns);
        void swapRow(int si);
        void vfree ();
	void efree (int ke);
	int resize (int n);

} ;


/* 
void GetSvarVal(Siv *, int *i);
void GetSvarVal(Siv *, float *f);
void GetSvarVal(Siv *, double *d);
void GetSvarVal(Siv *, short *s);
void GetSvarVal(Siv *, long *l);
char * GetSvarVal(Siv *);
int get_var_numstr(Siv *v, Svar *svar);
int get_var_str(Siv *v, Svar *svar);
int get_var_string(Siv *sivp, Svar *svar, int svarindex);
int get_var_fmtstr(Siv *sivp, Svar *svar, char *fmt);
*/

#endif
