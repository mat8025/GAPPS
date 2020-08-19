
spawn_it = 1;

# use arg to set


//SetDebug(1)
stype = "XX"

char CW[64] = { "linux reading" }

<<" %s $CW \n"

int last_sent = 0
int last_rec = 0
int ds
int dr
int sec = 5
int last_sec = 55
int dsec
int mpk

float phz
float avehz = 0.0


int  sum_cnt = 0
uint  sum_dusec = 0

kickoff =0

int gwo = -1
int pkwo = -1
int mpkwo = -1


int max_gl
int min_gl
int pks_gl
int pkr_gl
int mpt_gl

int CBUFSZ = 500

float XVEC[CBUFSZ]
float MAXVEC[CBUFSZ]
float MINVEC[CBUFSZ]
float PKSVEC[CBUFSZ]
float PKRVEC[CBUFSZ]
float MISSPKTV[CBUFSZ]

float rx = 0
float rX = 800

float orX = rX;
float orx = 0;


float st = 0.0
float mt = 0.0
ip = ""
fw = ""


uchar CR[1024]

float tm = 0.1;
float dtx = 0.9;

int mgc
int hl
int type
int mframe
int len
ushort eidvl
ushort eidpn

uint missframes = 0
uint d_miss = 0
uint last_frame = 0
uint last_targpn_frame = 0
int plen
int dmf
ushort icsum


SKPVERS = 40
VIA_A664 = 41
SKPZLEN = 42
IP_DUSECS = 43
OP_DUSECS = 44
SP_DUSECS = 45
PF_DUSECS = 46
BMP_DUSECS = 47
HL_DUSECS = 48
AF_DUSECS = 49
ADRF_DUSECS = 50

iflg = 24

  FRAME_NUM = 22
  FRAME_GAP = 23

  BAD_LEN = iflg++ //24
  BAD_ORDER = iflg++
  BAD_NUM_MSGS = iflg++
  BAD_CHKSUM = iflg++
  BAD_END = iflg++
  BAD_OVERWRT = iflg++
  BAD_CONTENT = iflg++
  BAD_MSGLEN = iflg++
  BAD_ADDR = iflg++
  REJECT_FRM = iflg++
  BAD_VCTE = iflg++

iflg = 36
  FI_CNT = iflg++
  DMO_CNT = iflg++
  DMI_CNT = iflg++
  PFR_CNT = iflg++


CANTEST = 34
TEST_CORE = 48
TEST_ID = 49
TEST_RUN = 50
TEST_INH = 58





int IV[]




showall = 0


proc StrCli( cfd)
{

kw =0
tw =0
 // 
<<" Listening "
       first = 1

T=FineTime()
T2=FineTime()

  while (1) {

<<" . "

   kw++
   sleep(0.2)
   fflush(1)
   if (kw > 3)
   break
  }
<<" . \n"

  kw = 0
  kp = 0

int cmcf_rd = 1

char IV[]

int AHMDB[]
int A664DB[]

char LQPM[]
char BLQPM[]
char LQPRM[]
char LSPM[]

char CQ[10][20]

MF = ofw("SKP_DB.log")

int mf
int recf
last_pfr = 0
uint dt
prf_hz = 0.0
nprf = 0
  while (1) {

    //<<" Listening from socket $kw \n"

    nbr=GsockRecv(A,CR,1024)

    if (nbr > 0) {

//      <<"$kw recv %s $CR[0:nbr] \n"

    eb = nbr-1

    MB = CR[0:eb]



    eol = nbr -1

    if (nbr > 200) {


//    want to retype this
    recast(IV,"char")
    IV = MB
    recast(IV,"int")
    cmcf_rd++

    swab(IV)

//<<"%V %x $mgc\t%u $mframe\t$len\s\t$nbr\s\t$plen\s\t$eidvl\t$eidpn\t${missframes}\t$d_miss"

 if (IV[0] == 0xACE2FACE) {

    AHMDB = IV

 }

 if (IV[0] == 0xDECADE01) {

    A664DB = IV

 }


 if (IV[0] == 0xC0DEBABE) {

    SKPDB = IV

<<"\n SKP DEBUG TABLE [${cmcf_rd}] SKP_VERS\t$SKPDB[SKPVERS]\n" 



k = 0

//<<" $k    %x  $IV[k] \n" ; k++ 
k =1
<<"---------------------- SKP COUNTERS ---------------------------\n"
<<"SECS %u $IV[k] " ; k++
<<"TOVR $IV[k] " ; k++
<<"DURUSECS\t$IV[k] " ; k++
<<"\tMAXPOLLUSECS\t$IV[k] \n" ; k++

<<"FRAME_NUM %u $SKPDB[FRAME_NUM] " ;
<<"FRAME_GAP $SKPDB[FRAME_GAP] " ; 
<<"REJECT_FRAMES\t$SKPDB[REJECT_FRM]" ; 
<<"\tBAD_CHKSUM $SKPDB[BAD_CHKSUM]\n" ;
 
<<"ARP_REQS  $IV[k]" ; k++
<<"\tARP_REPS\t$IV[k] \n" ; k++
<<"UDP_SNT $IV[k] " ; k++
<<"UDP_REC  $IV[k]\n" ; recf = IV[k]; k++
<<"CMPLTD_FRAGS\t$IV[k]" ; k++
<<"\tMISSED_FRAGS\t$IV[k] " ; k++
<<"MISSED_PKTS\t$IV[k] \n" ; k++
<<"PKTSH_PER_POLL\t$IV[k] " ; k++
<<"PKTSL_PER_POLL\t$IV[k] " ; k++
<<"MF_PER_POLL\t$IV[k] \n" ; k++
<<"MISSED_FRAMES\t$IV[k] " ; mf = IV[k]; k++
<<"\tPKT_REC_RATE\t$IV[k] " ; k++
<<"\tPKT_SEND_RATE\t$IV[k] \n" ; k++
<<"CDN_RATE\t$IV[k] " ; k++
<<"\tCDN_PRATE\t$IV[k] " ; k++
<<"\tCDN_PN\t$IV[k] \n" ; k++

<<"PENET_RD_ERR\t$IV[k] \n" ; k++
<<" SBMS_ZLEN\t$SKPDB[SKPZLEN]\n" 
<<"IP_DUSECS\t$SKPDB[IP_DUSECS]" 
<<"\tOP_DUSECS\t$SKPDB[OP_DUSECS]" 
<<"\tSP_DUSECS\t$SKPDB[SP_DUSECS]" 
<<"\tPF80_DUSECS\t$SKPDB[PF_DUSECS]\n" 
<<"BMP_DUSECS\t$SKPDB[BMP_DUSECS]" 
<<"\tHL_DUSECS\t$SKPDB[HL_DUSECS]" 
<<"\tAF_DUSECS\t$SKPDB[AF_DUSECS]" 
<<"\tADRF_DUSECS\t$SKPDB[ADRF_DUSECS]\n" 

k = BAD_LEN
pr_bad = 0
for (k= BAD_LEN ; k <= BAD_ADDR ; k++) {
 if (IV[k] > 0) {
//  FIXME  can't chain logic conditions in loop !!
 if (k != BAD_CHKSUM) {
    pr_bad = 1
  }
 }
}
if (pr_bad) {
k = BAD_LEN
<<"BAD_LEN  $IV[k]" ; 
k++
<<"\tBAD_ORDER\t$IV[k]" ; 
k++
<<"\tBAD_NUM $IV[k] \n" ; 
k++
<<"BAD_CHKSUM  $IV[k]" ; k++
<<"\tBAD_END\t$IV[k]" ; k++
<<"\tBAD_OVWRT $IV[k] \n" ; k++
<<"BAD_CONTENT $IV[k]" ; k++
<<"\tBAD_MSG_LEN  $IV[k]" ; k++
<<"\tBAD_ADDR\t$IV[k]\n" ; k++

k++
<<"\tBAD_VCTE\t$IV[k]" ; k++
<<"\tBAD_RDBLK\t$IV[k]\n" ; k++
<<"\n"
}

k = FI_CNT

<<"FI_CNT\t$SKPDB[FI_CNT]" ; k++
<<"\tDMO_CNT\t$SKPDB[DMO_CNT]" ; k++
<<"\tDMI_CNT\t$SKPDB[DMI_CNT]" ; k++
<<"\tPFR_CNT\t$SKPDB[PFR_CNT]\n" ; k++

npfr = SKPDB[PFR_CNT] - last_pfr
dt=FineTimeSince(T2,1)

last_pfr = SKPDB[PFR_CNT] 
if (dt > 0) {
<<"%v $dt $last_pfr \n"
pfr_hz = npfr/ (dt / 1000000.0)
<<"\tPFR_HZ %f $pfr_hz\n" ; 
}

<<"\tCAN_TEST\t$AHMDB[CANTEST]" ; 
<<"\tTEST_CORE\t$AHMDB[TEST_CORE]" ;
<<"\tTEST_ID\t$AHMDB[TEST_ID]\n" ;  

<<" TEST RUNNING\t$AHMDB[TEST_RUN]" ;  
<<"\tTEST INH\t$AHMDB[TEST_INH]\n" ;  
<<" VIA_A664\t$SKPDB[VIA_A664]\n" 


k = 32
//<<" $k    %x  $IV[k] \n" ; k++ 
k++


   DMO = MB[256:275]
   DMI = MB[276:295]
   PFR = MB[296:315]


  <<"CMCF->AHM DMO %20R  %x [ $DMO ]\n"
  <<"AHM->CMCF DMI %20R  %x [ $DMI ]\n"
  <<"AHM->CMCF PFR %20R  %x [ $PFR ]\n"



 pmf = (mf / recf * 100.0)
<<" MissedFrame percent re total received $pmf \% \n" 


fflush(MF)




    kw++
}
}


  }

  }
}

// we want to create socket on our local machine
// on the port that the other side is sending

port = 9873    // debug data packet port
#port = 24111    // debug data packet port

 Ipa = "any"

 #{
 if (AnotherArg()) {
  Ipa = GetArgStr()

 }

 if (Ipa @= "") {
  Ipa = "any"
 }
 #}

<<"%V  $Ipa $port \n"


      A = GsockCreate(Ipa, port, "UDP")

<<" created UDP type socket index $A $port\n"

//      GsockConnect(A)

      errnum = CheckError()

<<"%v $errnum \n"


C=ofr("/usr/people/user/softbench_sbc_ip")

Ipa = rword(C)
<<" %v $Ipa \n"

    B = GsockCreate(Ipa, port, "UDP")

<<" created UDP type socket index $B $port\n"

      GsockConnect(B)

      errnum = CheckError()

<<"%v $errnum \n"
   
   n=GsockSendTo(B,"c")



  port_n = _clarg[1]
  showall = _clarg[2]





<<" now reading from it looking for port $port_n \n"

      StrCli()


      STOP!
