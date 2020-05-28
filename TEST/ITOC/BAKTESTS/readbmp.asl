 
spawn_it = 1;

# use arg to set



#define BMP_END_DB  2000   // list in index into our debug buffer

enum DBG_Flags_BMP
  {
    PT_START_SECS = 1,
    PT_START_USECS,
    PT_DUR_USECS,
    PT_PER_USECS,
    POLL_WC,    
    POLL_RD,
    POLL_WD,
    POLL_IVC,
    IVCMD,
    IVPAGE, //10
    IVPAGEN, 
    IVPART,
    IVPARTID,
    WRM,
    BMP_SR_IDLE ,
    BMP_SW_IDLE ,
    BMP_NVM_FULL ,
    BMP_SP_ERROR ,
    BMP_SDLOSS ,
    BMP_SWDLOSS , //20
    BMP_SKPBUFFS , 
    BMP_SKPCBI ,
    BMP_SWD_OK ,
    NVM_WRT_FAIL ,
    NVM_SVRWRT_CNT ,
    BMP_RVDATA ,
    BMP_RWIP ,
    BMP_RWIPDLOSS ,
    BMP_RADDR ,
    BMP_MRERR ,  // 30
    BMP_CSCDB_OK , 
    NVM_ADDR,
    NVM_SD_ADDR,
    NVM_BH_ADDR,
    NVM_PSTATUS,
    BMP_NSC,
    BMP_FSQ,
    NVM_RDYTOERASE,
    NVM_VDATA,
    FSQ_STATE,  // 40
    NVM_BHWRT_REQ,
    NVM_BHWRT_CNT ,
    NVM_BHW_LEN ,
    NVM_SVRW_LEN ,
    NVM_CINDEX ,
    NVM_AREA_FULL ,
    NVM_BHWRT_OA,
    NVM_SVRWRT_OA,
    NVMWAO,
    POLL_HMANY, // 50
    NVM_BHW_ADDR , 
    NVM_BHW_BLKST,
    NVM_BHW_BLKEND,
    NVM_SVR_ADDR , 
    NVM_SVR_BLKST,
    NVM_SVR_BLKEND,
    BMP_SYNC,
    BMP_MAINT, 
    BMP_RDCMD, 
    BMP_BCAST,  //60
    BMP_CSTATE, 
    BMP_TOROLL, 
    BMP_ETON, 
    FSQ_PROC, 
    NVM_PROCFSQCNT, 
    FSQ_NEWFLT, 
    FSQ_DOITRM, 
    FSQ_CFI, 
    FSQ_ITMFLT,
    FSQ_OS, // 70
    FSQ_PART,
    NVM_VHEAD,
    BMP_FLEG,
    FSQ_FDR_ID,
    FSQ_FDR_CODE,   
    FSQ_FDR_TID, 
    FSQ_PART_INDEX,
    BMP_BHTCNT,
    BMP_CABINVAL,
    BMP_BIT, // 80
    BMP_GETFLTS, 
    BMP_OVERRUN, 
    BMP_FRQ,
    BMP_BCAST_VALID,
    BMP_FLTPHASE, 
    BMP_FP_INVALID,
    WSS_DUR,  
    MIN_REFRESH_RT,
    MAX_REFRESH_RT,
    NVM_MIN_REFRESH_RT, // 90
    NVM_MAX_REFRESH_RT,
    BMP_RTC_SYNC,
    BMP_RTC_UNSYNC,
    BCAST_VALIDATED,
    BCAST_RD_INVALID,
    BB_RD_INVALID,
    NVM_WT_REQ,
    BC_STAT_VALID,
    BH_FP_TOROLL,
    ROLL_FLEG,  // 100
    FSQ_OS_REQ,
    FSQ_PART_REQ,
    BMP_CSCDB_MERR,
    CSCDB_FSQ_PID,
    BMP_CABPOS,
    BMP_RD_NVM,
    BMP_GET_FAULTS,
    BMP_FSQX_PTR,
    BMP_FSQ_OUTPTR,
    NVM_BH_ADDR_C,  // 110
    NVM_SD_ADDR_C,
    BMP_FSQX_PTR_C,
    BMP_FSQ_OUTPTR_C,
    BMP_CSCDB_STATUS,
    BMP_CSCDB_FILE,
    CSCDB_FSQ,
    BMP_FLUSH,
    BMP_AHM_MSG,
    BMP_GETCLEG,
    BMP_TST_COMPLETE, // 120
    BMP_SYNC_IV,
    BMP_REQ_CMD,
    BMP_BADREQC,
    SP_CREATE_ERR,
    CSCDB_DATA_PTR,
    BMP_WRT_NVM,
    BMP_NVM_WADDR,
    BMP_REQ_PAGE,
    BMP_NVM_PWA,
    BMP_LSR_S1,  // 130
    BMP_LSR_S2,
    BMP_BAD_SST,
    BMP_INIT,
    BMP_X_SADDR,
    BMP_RPM_VALID,
    BMP_NVM_HDR_VALID,
    BMP_XLANE_STATUS,
    BMP_NO_NVMHDR,
    BMP_TMP_NVMHDR,
    BMP_NO_INFOREC, // 140
    BMP_FA_WA,
    BMP_FA_WA2,
    BMP_FA_SECT, 
    BMP_RD_NVMADDR,
    BMP_FND_FAREC,
    BMP_INIT_FLEGA,
    BMP_CHK_XY,
    BMP_CUR_SEC,
    BMP_YLANE_STATUS,
    BMP_FND_FLIREC, // 150
    BMP_RTC,
    BMP_WRT_SZ,
    BMP_RD_SZ,
    BMP_BAD_WRT,
    BMP_BAD_RD,
    BMP_WRT_SDNVM,
    BMP_WRT_SDSZ,
    BMP_SR_SZ,
    POLL_WD_SZ,
    RMSG_SZ,  // 160
    RMSG_SST_I,
    BMP_SST_RDI,
    CMN_FLEG_ADDR,
    CMN_FLEG_NUM,
    CMN_ACTFA_ADDR,
    CMN_FA_RDCNT,
    CMN_FA_INDEX,
    BMP_TIME_SYNC,
    FSQ_OSX_PTR,
    BMP_FSQ_OPTRFR, // 170
    BMP_TMPHDR_OFF,
    RPM_BH_ADDR,
    BMP_SYNC_SZ,
    BMP_WT_SYNC,
    BMP_WTSYNC_SZ,
    BMP_TSBUFFS,
    BMP_SKPQ_WRT,
    NVM_FLI_WADDR,
    CMN_FA_FID,
    BMP_SVR_WRTI, // 180
    BMP_SVR_SKP,
    CTS_BMP_SKP,
    CMN_MAXCL_SOFF,
    CMN_BH_FULL,
    CMN_BH_WADDR,
    CMN_CHK_BH,
    CMN_CHK_FA,
    BMP_WRT_SDMID,
    BMP_SP_NAMES,
    BMP_SVR_NAMES, // 190
    NVM_SVRWRT_REQ,
    NVM_SVR_BOUND,
    BMP_SVR_WRT,
    BMP_PROCESS,
    BMP_CNTRL_ST,
    BMP_IHP,
    BMP_MS_INVALID,
    BMP_CBM_ML, 
    BMP_IHP_SPCPY,
    FSQ_PART_OUTPTR, // 200
    FSQ_PART_INPTR,
    FSQ_FR_PTR,
    CTS_BMP_WSI,
    CTS_NVM_SVRWRT_FAIL,
    CTS_NVM_BH_SZ,
    CTS_NVM_PSTATUS,
    CTS_RD_REQ_PAGE,
    CTS_RD_REQ_PTID,
    CTS_NVM_OVERWRT,
    FSQ_CYCLE,  // 210
    BMP_UNWRT_HDR,
    CTS_BAD_FADDR,
    BMP_BH_SECT1,
    BMP_BH_SECT2,
    CTS_NVM_FR_WADDR,
    BMP_END_FLAGS, // 216 check overwrite - POLL_SVC?
    SS_READP,
    SS_WRITEP,
    CTS_WT_REQ_PAGE,
    CTS_WT_REQ_PTID,

    CTS_FLAG_CHK,



    POLL_SVC = 220,
    RMSGID= 300,
   
  }; // can use upto 375 flags --- 1500 bytes  -- UDP size pkt header of 20


<<"%V $(BMP_END_FLAGS) $(CTS_FLAG_CHK) $kenum\n"





proc show_maint()
{
<<"\tBMP_CSDB_OK %8d\t$IV[BMP_CSDB_OK] "
//<<"\tNVM_SVRW_LEN %8d\t$IV[NVM_SVRW_LEN] "
<<"\tNVM_CINDEX %8d\t$IV[NVM_CINDEX] \n"


<<"\tNVM_AREA_FULL %8d\t$IV[NVM_AREA_FULL] "
<<"\tNVM_BHWRT_OA %8d\t$IV[NVM_BHWRT_OA] "

<<"\tNVM_BHW_BLKST %x\t$IV[NVM_BHW_BLKST] "
<<"\tNVM_BHW_BLKEND %x\t$IV[NVM_BHW_BLKEND]\n "

<<"\tBMP_MAINT %8d\t$IV[BMP_MAINT] "

<<"\tBMP_BCAST %x\t$IV[BMP_BCAST] "
<<"\tBMP_CSTATE %8d\t$IV[BMP_CSTATE] \n"

<<"\tBMP_TOROLL %8d\t$IV[BMP_TOROLL] "
<<"\tBMP_ETON %8d\t$IV[BMP_ETON] "
<<"\tFSQ_PROC %8d\t$IV[FSQ_PROC] "
<<"\tPROCFSQCNT %8d\t$IV[NVM_PROCFSQCNT] \n"

<<"\tNVM_BHWRT_CNT %8d\t$IV[NVM_BHWRT_CNT] "
<<"\tNVM_BHW_LEN %8d\t$IV[NVM_BHW_LEN] "
<<"\tBMP_BHTCNT %8d\t$IV[BMP_BHTCNT] "
<<"\tFR_WADDR %x\t$IV[CTS_NVM_FR_WADDR] "
<<"\n"

<<"\tFSQ_NEWFLT %8d\t$IV[FSQ_NEWFLT] " ; new_fault = IV[FSQ_NEWFLT];
<<"\tFSQ_DOITRM %8d\t$IV[FSQ_DOITRM] "
<<"\tFSQ_CFI %8d\t$IV[FSQ_CFI] "
<<"\tFSQ_ITMFLT %8d\t$IV[FSQ_ITMFLT] "
<<"\n"

<<"\tFSQ_FDR_ID %8d\t$IV[FSQ_FDR_ID] "
<<"\tFSQ_FDR_CODE %8d\t$IV[FSQ_FDR_CODE] "
<<"\tFSQ_FDR_TID %d\t$IV[FSQ_FDR_TID] "
<<"\n"



<<"\tBMP_CABINVAL %8d\t$IV[BMP_CABINVAL] "
<<"\tBMP_BIT %8d\t$IV[BMP_BIT] "
<<"\tBMP_GETFLTS %8d\t$IV[BMP_GETFLTS] "
<<"\n"

<<"\tBMP_FLTPHASE %8d\t$IV[BMP_FLTPHASE] "
<<"\tBMP_FP_INVALID %8d\t$IV[BMP_FP_INVALID] "
<<"\tWSS_DUR %8d\t$IV[WSS_DUR] "
<<"\n"

<<"\tNVM_MIN_RFS_RT %8d\t$IV[NVM_MIN_REFRESH_RT] "
<<"\tNVM_MAX_RFS_RT %8d\t$IV[NVM_MAX_REFRESH_RT] "
<<"\tBMP_RTC_SYNC %8d\t$IV[BMP_RTC_SYNC] "
<<"\tBMP_RTC_UNSYNC %8d\t$IV[BMP_RTC_UNSYNC] "
<<"\n"

<<"\tBCST_VALIDTD %8d\t$IV[BCAST_VALIDATED] "
<<"\tBCST_RD_INVLD %8d\t$IV[BCAST_RD_INVALID] "
<<"\tNVM_WT_REQ %8d\t$IV[NVM_WT_REQ] "
<<"\n"

<<"\tBC_STAT_VALID %8d\t$IV[BC_STAT_VALID] "
<<"\tBH_FP_TOROLL %8d\t$IV[BH_FP_TOROLL] "
<<"\tROLL_FLEG %8d\t$IV[ROLL_FLEG] "
<<"\tFSQ_OS_REQ %8d\t$IV[FSQ_OS_REQ] \n"

<<"\tFSQ_PART_REQ %8d\t$IV[FSQ_PART_REQ] "
<<"\tFSQ_PART_INDEX %8d\t$IV[FSQ_PART_INDEX] "
<<"\tFSQ_PART %8d\t$IV[FSQ_PART] "
<<"\tCSCDB_FSQ_PID %8d\t$IV[CSCDB_FSQ_PID] "
<<"\n"

<<"\tFSQ_PART_INPTR %8d\t$IV[FSQ_PART_INPTR] "
<<"\tFSQ_PART_OUTPTR %8d\t$IV[FSQ_PART_OUTPTR] "
<<"\tFSQ_FR_PTR %x\t$IV[FSQ_FR_PTR] "
<<"\tFSQ_CYCLE %8d\t$IV[FSQ_CYCLE] "
<<"\n"

<<"\tBMP_CABPOS %8d\t$IV[BMP_CABPOS] "
<<"\tBMP_RD_NVM %8d\t$IV[BMP_RD_NVM] "
<<"\tBMP_GET_FAULTS %8d\t$IV[BMP_GET_FAULTS] "
<<"\n"


<<"\tBMP_CSCDB_STATUS %x $IV[BMP_CSCDB_STATUS] "
<<"\tBMP_CSCDB_FILE %x $IV[BMP_CSCDB_FILE] "
<<"\tCSCDB_FSQ $IV[CSCDB_FSQ] "
<<"\tBMP_FLUSH $IV[BMP_FLUSH] "
<<"\n"
<<"\tBMP_AHM_MSG $IV[BMP_AHM_MSG] "
<<"\tBMP_GET_CLEG $IV[BMP_GET_CLEG] " 
<<"\tBMP_TST_COMPLETE $IV[BMP_TST_COMPLETE] " 
<<"\tBMP_SYNC_IV $IV[BMP_SYNC_IV] "
<<"\n"


<<"\tBMP_REQ_CMD $IV[BMP_REQ_CMD] "
<<"\tBMP_BAD_REQC $IV[BMP_BAD_REQC] "
<<"\tSP_CREATE_ERR $IV[SP_CREATE_ERR] "
<<"\tCSCDB_DATA_PTR $IV[CSCDB_DATA_PTR] "
<<"\n"



<<"\tBMP_LSR_S1\t%X$IV[BMP_LSR_S1] "
<<"\tBMP_LSR_S2\t%X$IV[BMP_LSR_S2] \n"
<<"\tBMP_BAD_SST\t%12d$IV[BMP_BAD_SST] "
<<"\tBMP_INIT\t%12d$IV[BMP_INIT] "

<<"\tBMP_RPM_VALD\t%d$IV[BMP_RPM_VALD] \n"
<<"\tBMP_NVM_HDRVALD\t%d$IV[BMP_NVM_HDRVALD] "
<<"\tBMP_XLANE_STATUS\t%x$IV[BMP_XLANE_STATUS] "
<<"\tBMP_YLANE_STATUS\t%x$IV[BMP_YLANE_STATUS] "
<<"\tBMP_NO_NVMHDR\t%d$IV[BMP_NO_NVMHDR] \n"
<<"\tBMP_TMP_NVMHDR\t%d$IV[BMP_TMP_NVMHDR] "
<<"\tBMP_NO_INFOREC \t%d$IV[BMP_NO_INFOREC] "
<<"\tBMP_FA_WA \t%x$IV[BMP_FA_WA] "
<<"\tBMP_FA_WA2 \t%x$IV[BMP_FA_WA2] "
<<"\tBMP_FA_SECT \t%d$IV[BMP_FA_SECT] \n"

<<"\tBMP_FND_FAREC \t%d$IV[BMP_FND_FAREC] "
<<"\tBMP_INIT_FLEGA \t%d$IV[BMP_INIT_FLEGA] "
<<"\tBMP_CHK_XY \t%d$IV[BMP_CHK_XY] "
<<"\tBMP_CUR_SEC \t%d$IV[BMP_CUR_SEC] \n"
<<"\tBMP_FND_FLIREC \t%d$IV[BMP_FND_FLIREC] "
<<"\tBMP_RTC \t%d$IV[BMP_RTC] "
<<"\tBMP_BAD_WRT \t%d$IV[BMP_BAD_WRT] "

<<"\tBMP_BAD_RD \t%d$IV[BMP_BAD_RD] "
<<"\n"



<<"\tCMN_FA_RDCNT \t%d$IV[CMN_FA_RDCNT] "
<<"\tCMN_FA_INDEX \t%d$IV[CMN_FA_INDEX] "
//<<"\tCMN_FA_SZ \t%d$IV[CMN_FA_SZ] "
<<"\tCMN_FA_SZ \t%d$cmn_fa_sz "
<<"\tBMP_TIME_SYNC \t%d$IV[BMP_TIME_SYNC] "
<<"\n"
}


proc  show_frq(lbc, ds)
{
int dcnt
//<<"%V $lbc $ds \n"
<<"\tMIN_REFRESH_RT %8d\t$IV[MIN_REFRESH_RT] "
<<"\tMAX_REFRESH_RT %8d\t$IV[MAX_REFRESH_RT] \n"

<<"\tBMP_OVERRUN %8d\t$IV[BMP_OVERRUN] "
<<"\tBMP_FRQ %8d\t$IV[BMP_FRQ] " ; 

<<"\tBCAST_VALID %8d\t$IV[BMP_BCAST_VALID] \n"
<<"\tBMP_INIT\t%12d$IV[BMP_INIT] "
<<"\tBMP_PROCESS\t%12d$IV[BMP_PROCESS] "
<<"\tBMP_CNTL_ST\t%12d$IV[BMP_CNTL_ST] "
<<"\tBMP_IHP\t%12d$IV[BMP_IHP] \n"
<<"\tBMP_MS_INV\t%12d$IV[BMP_MS_INVALID] "
<<"\tBMP_CBM_ML\t%12d$IV[BMP_CBM_ML] "
<<"\tBMP_IHP_SPCPY\t%12d$IV[BMP_IHP_SPCPY] "
<<"\tBMP_CSDB_MERR %8d\t$IV[BMP_CSDB_MERR] "
<<"\n"

k = CTS_FLAG_CHK
<<"%V $BMP_END_FLAGS $CTS_FLAG_CHK %x $IV[BMP_END_FLAGS] nflags $k\n"

#{
<<"\n 
for (jj= 0 ; jj < 3; jj++) {
<<"CTS_FLAG_CHK $k %x $IV[k] "
k++
}
<<"\n"
#}

 bmp_cnt = IV[BMP_FRQ];  
// dcnt = (bmp_cnt - last_bmpcnt)
 dcnt = (bmp_cnt - lbc)

//<<"%V $dcnt $bmp_cnt  $last_bmpcnt \n"

// bmp_frq = ( dcnt / (dusec/1000000.0))
   bmp_frq = ( dcnt / (ds/1000000.0))
 //last_bmp_cnt = bmp_cnt

#<<"$dusec $dcnt $last_bmp_cnt \tBMP_FRQ  \t %f $bmp_frq \n" ;

   <<"\tBMP_FREQ  \t %f $bmp_frq \n" ;
   <<"----------------------  MEM ------- $eb ------------------\n"
   return bmp_cnt
}


proc show_wrtsvr()
{
<<"--------------- WRT_SERVER ------------------------ \n"

<<"\tBMP_FSQ_ %8d\t$IV[BMP_FSQ] "
<<"\tBMP_TSBUFFS %d\t$IV[BMP_TSBUFFS] "
<<"\tBMP_SKPBUFFS %8d\t$IV[BMP_SKPBUFFS] "
<<"\tBMP_SKPCBI %8d\t$IV[BMP_SKPCBI] "
<<"\n"
<<"\tBMP_WRT_SDNVM $IV[BMP_WRT_SDNVM] "
<<"\tBMP_WRT_SDMID $IV[BMP_WRT_SDMID] "

<<"\tNVM_RDYTOERASE %8d\t$IV[NVM_RDYTOERASE] "
<<"\tNVM_VDATA %8d\t$IV[NVM_VDATA] "
<<"\n"

<<"\tBMP_REQ_PAGE\t%12d$IV[BMP_REQ_PAGE] "
<<"\tBMP_SKPQ_WRT\t%12d$IV[BMP_SKPQ_WRT] "
<<"\tBMP_NVM_PWA\t%X$IV[BMP_NVM_PWA] "
<<"\n"

<<"\tNVM_SVRWRT_REQ %8d\t$IV[NVM_SVRWRT_REQ] "
<<"\tNVM_SVRWRT_CNT %8d\t$IV[NVM_SVRWRT_CNT] "
<<"\n"

<<"\tNVM_SVR_ADDR %x\t$IV[NVM_SVR_ADDR] "
<<"\tNVM_SVR_BLKST %x\t$IV[NVM_SVR_BLKST] "
<<"\tNVM_SVR_BLKEND %x\t$IV[NVM_SVR_BLKEND] "

<<"\tNVM_SVWRT_OA %x\t$IV[NVM_SVWRT_OA] "
<<"\n"

<<"\tNVM_SVR_BOUND %x\t$IV[NVM_SVR_BOUND] "
<<"\tNVMWAO_ %8d\t$IV[NVMWAO] "
<<"\n"

<<"\tBMP_SWDLOSS %8d\t$IV[BMP_SWDLOSS] "
<<"\tBMP_SWD_OK %8d\t$IV[BMP_SWD_OK] "
<<"\tNVM_WRT_FAIL %8d\t$IV[NVM_WRT_FAIL] "
<<"\tCTS_NVM_SVRWRT_FAIL %8d\t$IV[CTS_NVM_SVRWRT_FAIL] "
<<"\n"


<<"\t    BMP_SVR_WRTI %8d\t$IV[BMP_SVR_WRTI] "
<<"\t    BMP_SVR_SKP   %8d\t$IV[BMP_SVR_SKP]"
<<"\n"
}



proc show_pollsvr()
{
<<"--------------- POLL SERVER ------------------------ \n"
<<"\tPOLL_WC %8d\t$IV[POLL_WC] "
<<"\tPOLL_RD %8d\t$IV[POLL_RD] "
<<"\tPOLL_WD %8d\t$IV[POLL_WD] "
<<"\tPOLL_IVC %8d\t$IV[POLL_IVC] "
<<"\n"

<<"\tIVCMD__ %8d\t$IV[IVCMD] "
<<"\tIVPAGE_ %8d\t$IV[IVPAGE] "
<<"\tIVPAGEN %8d\t$IV[IVPAGEN] "
<<"\tIVPART_ %8d\t$IV[IVPART] "
<<"\n"

<<"\tIVPARTID %8d\t$IV[IVPARTID] "
<<"\tWRM____ %8d\t$IV[WRM] "
<<"\tBMP_SR_IDLE %8d\t$IV[BMP_SR_IDLE] "
<<"\tBMP_SW_IDLE %8d\t$IV[BMP_SW_IDLE] "
<<"\n"

<<"\tBMP_NVM_FULL %8d\t$IV[BMP_NVM_FULL] "
<<"\tBMP_SP_ERROR %8d\t$IV[BMP_SP_ERROR] "
<<"\tBMP_SDLOSS %8d\t$IV[BMP_SDLOSS] "
<<"\tPOLL_HMANY %8d\t$IV[POLL_HMANY] "
<<"\n"

<<"\tBMP_SYNC %8d\t$IV[BMP_SYNC] "
<<"\tBMP_SYNC_SZ \t%d$IV[BMP_SYNC_SZ] "
<<"\tBMP_WT_SYNC \t%d$IV[BMP_WT_SYNC] "
<<"\tBMP_WTSYNC_SZ \t%d$IV[BMP_WTSYNC_SZ] "
<<"\n"



//  POLL_SRV INPUT
   psvri = POLL_SVC


   for (pi = 0; pi < 7; pi++) {
// FIX <<"\t$IV[psvri] \t%d$IV[(psvri + 1)] \n"
<<"\t$IV[psvri] " ; psvri++
<<"\t$IV[psvri] " ; psvri++
<<"\t$IV[psvri] " ; psvri++
<<"\t$IV[psvri] " ; psvri++
<<"\t$IV[psvri] " ; psvri++
<<"\t$IV[psvri] " ; psvri++
<<"\t%d$IV[psvri] \n"
    psvri++
   } 


<<"\tNVM_ADDR %x\t$IV[NVM_ADDR]   "
<<"\tBMP_RADDR %x\t$IV[BMP_RADDR] "
<<"\tNVM_SD_ADDR %x\t$IV[NVM_SD_ADDR] "
<<"\tBMP_X_SADDR\t%x$IV[BMP_X_SADDR] "
<<"\n"

<<"\tBMP_RDCMD %8d\t$IV[BMP_RDCMD] "
<<"\tNVM_PSTATUS %x\t$IV[NVM_PSTATUS] "
<<"\tCTS_PSTATUS %x\t$IV[CTS_NVM_PSTATUS] "
<<"\n"

<<"\tBMP_RVDATA %8d\t$IV[BMP_RVDATA] "
<<"\tBMP_RWIP_ %8d\t$IV[BMP_RWIP] "
<<"\tBMP_RWIPDLOSS %8d\t$IV[BMP_RWIPDLOSS] "
<<"\n"

<<"\tPOLL_WD_SZ \t%d$IV[POLL_WD_SZ] "
<<"\tRMSG_SZ \t%d$IV[RMSG_SZ] "
<<"\tRMSG_SST_I \t%d$IV[RMSG_SST_I] "
<<"\tBMP_SST_RDI \t%d$IV[BMP_SST_RDI] "
<<"\n"
}



//SetDebug(1)
stype = "XX"

char CW[64] = { "linux reading" }

//<<" %s $CW \n"
uint how_many = 0
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


uchar CR[2000]


int IV[500]
int BMPIV[500]
int SPIV[500]
int PFIV[500]
int seen_pf = 0

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


int l_rdnvm = 0
int l_wtnvm = 0
int l_sdnvm = 0 
int l_srvnvm = 0
int l_pollwd = 0
int l_rdmsg = 0
int l_cfa = 0
int l_scq = 0 
int l_pollwc = 0
int l_srvrdnvm = 0

int nsplf = 0 
int l_nsplf = 0 
int l_rdsplf = 0 



last_pf_rdpage = 0
last_pf_wtpage = 0

last_sp_rdpage = 0
last_sp_wtpage = 0


//////////////////////////////////////////////////////////
//  read in our debug enum

////////////////////// size of structures 
// already found these
cmn_fa_sz = 12

int do_time = 1
int do_frq = 1
int do_pollsvr = 0
int do_wrtsvr = 0
int do_bh = 0
int do_maint = 0
int do_names = 0


int kenum = 1

//    uses the next 70  flags??



// these are relative to the second packet
// which transfers the Blackboard starting at char posn 1600 
// the followinf INDEX's are relative to the start of the BlackBoard

 bb_sp_off = 1600


 BB_NAME_INDEX =  1610 -bb_sp_off
 BB_SVRNAME_INDEX =  2000 -bb_sp_off


 BB_POLLWD_INDEX = 1610     -bb_sp_off
 BB_POLLSVC_INDEX = 1900    -bb_sp_off
 BB_SVRWRT_INDEX =  2200    -bb_sp_off
 BB_SR_INDEX = 2500 -bb_sp_off
 BB_BH_INDEX =  2800        -bb_sp_off



// third pkt
 bb_sp_off = 3200

 BB_SD_INDEX = 3712     -bb_sp_off
 BB_BH_INDEX = 3800     -bb_sp_off
 BB_RD_INDEX = 4000 -bb_sp_off
 BB_WT_INDEX = 4200 -bb_sp_off
 BB_SD_INDEX =  4410        -bb_sp_off
 BB_RMSG_INDEX =4600 -bb_sp_off
 BB_CFA_INDEX = 4800 -bb_sp_off
 BB_SCQ_INDEX = 5000 -bb_sp_off


////////////////////// SP ///////////////////////

    kenum = 5

    SP_NVMCLRLATCH = kenum++  
    SP_NVM_NEW_LATCHFAULT = kenum++  
    SP_NVM_READ_CMDS_SENT = kenum++
    SP_NVM_WRITE_CMDS_SENT = kenum++
    SP_NVM_INIT_BAD_DFLT = kenum++
    SP_NVM_INIT_READ_BAD_VERSION = kenum++
    SP_NVM_INIT_READ_BAD_CRC = kenum++
    SP_NVM_INIT_READ_OK_DONE = kenum++
    SP_NVM_INIT_RDPENDING_RDMAXERR = kenum++
    SP_NVM_INIT_READ_SERVER_DATA_LOSS = kenum++
    SP_NVM_INIT_READ_NUM_DLOSS_TMO = kenum++
    SP_NVM_INIT_READ_RESP_INVALID = kenum++
    SP_NVM_INIT_READ_BAD_SPORT = kenum++
    SP_NVM_INIT_READ_BAD_SPORT_MAX = kenum++
    SP_NVM_WRITE_CMPLT_RSP = kenum++
    SP_NVM_WRITE_PENDING_RSP = kenum++
    SP_NVM_WRITE_UNEXPECTED_RSP = kenum++
    SP_NVM_WRITE_UNEXPECTED_RSP_COUNT = kenum++
    SP_NVM_WRITE_RSP_PORTREADERR = kenum++
    SP_NVM_WRITE_RSP_PORTREADERR_COUNT = kenum++
    SP_NVM_WRITE_RSP_MAXWRITEATTS = kenum++
    SP_EXEC = kenum++
    SP_NVMWSM = kenum++
    SP_NVMRSM = kenum++
    SP_NVMRDERR = kenum++
    SP_NVMCRCERR = kenum++ 
    SP_NVMDLOSS = kenum++ 
    SP_NVMWPOK = kenum++
    SP_NVMRDOK = kenum++ 
    SP_NVMWIP = kenum++
    SP_NVMRDIP = kenum++
    SP_SPINVALID = kenum++
    SP_NVMSETLATCH = kenum++  
    SP_NVMLATCHPROC = kenum++
    SP_MINORFR = kenum++  
    SP_NVMRDVERR = kenum++
    SP_NVMRDVALID = kenum++
    SP_NVMRDMAXERR = kenum++
    SP_NVMSZ = kenum++
    SP_NVM_RD_COMPLETE = kenum++
    SP_NVM_RD_PEND = kenum++
    SP_NVM_DATA_LOSS = kenum++
    SP_SPORT_INVALID = kenum++ 
    SP_NVM_WRT_REQ = kenum++ 
    SP_NVM_WT_COMPLETE = kenum++
    SP_NVM_WT_PEND = kenum++
    SP_NVM_WRT_SZ = kenum++
    SP_BMPSP_ID = kenum++
    SP_NVM_LF_SZ = kenum++
    SP_RAP_MSG = kenum++

<<" SP nflags is $kenum \n"

///////////////////////////////////////


////////////////////////////// PF //////////////////////////


    kenum = 5








///////////////////////////////////////





proc StrCli()
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




char DBC[]
char LQPM[]
char BLQPM[]
char LQPRM[]
char LSPM[]
uchar SVRPAGE[]
uchar SVRRDPAGE[]

char adbc[]
char CQ[10][20]

MF = ofw("BMP.log")

<<[MF]" BMP NVM IO \n"

int last_bmpcnt 

last_bmpcnt = 0

int wend
int dusec = 1
str dbc_cmd = "xx"
dbc_val = 'C'

  while (1) {

    //<<" Listening from socket $kw \n"

    nbr=GsockRecv(A,CR,1500)

    if (nbr > 0) {

//      <<"$kw recv %s $CR[0:nbr] \n"

    eb = nbr-1

    MB = CR[0:eb]

//<<" %hx $MB[0] $MB[1] \n"

    eol = nbr -1



    if (nbr > 600) {





//<<"%V %x $mgc\t%u $mframe\t$len\s\t$nbr\s\t$plen\s\t$eidvl\t$eidpn\t${missframes}\t$d_miss"



 if (MB[0] == 0xDB) {
  // are we looking at a DB partition pkt ?

 <<" DB partition  %x $MB[0] $MB[1] \r"
// <<"\n"
// we want 0x10
#{
  if (MB[1] == 0x51) {
   <<" DB partition  %x $MB[0] $MB[1] \r"
  }

  if (MB[1] == 0x77) { 
   <<" DB partition  %x $MB[0] $MB[1] \n"
  }

//  if (MB[1] == 0x54) { 
//   <<" DB partition  %x $MB[0] $MB[1] \n"
//  }
#}


if ( (MB[1] == 0X80)) {
 // our debug commands
  <<"DBC %X $MB[0] $MB[1] $MB[2] $MB[3] $MB[4] $MB[5] $MB[6] \n"
  //scpy(&dbc_cmd,&MB[4])
//  dbc_cmd = MB[4:12]
    DBC = MB[0:16]
   adbc = MB[8:16]
   sscan(adbc,"\%s",&dbc_cmd)
//    dbc_cmd = MB[8]
    dbc_val = MB[8]
}





if ( (MB[1] == 0X77)) {

// <<" got the NVM mem pkt ! \r"

    recast(BMPIV,"char")
    BMPIV = MB
    recast(BMPIV,"int")

n_pollwc = IV[POLL_WC]

if (n_pollwc > l_pollwc ) {

//<<[MF]"\tPOLLWC $IV[POLL_WC] \n"

  wend = BB_POLLSVC_INDEX +IV[POLL_WD_SZ]
  wend = BB_POLLSVC_INDEX + 15

//<<[MF]"%{25\n} %2x $MB[BB_POLLSVC_INDEX:wend] \n" 
if (MB[BB_POLLSVC_INDEX] != 0) {
//<<[MF]"%(20,, ,\n) %2x $MB[BB_POLLSVC_INDEX:wend] \n" 
}
l_pollwc = n_pollwc  
//<<[MF]"--------------------------- ---------------------------\n"
}





n_pollwd =IV[POLL_WD]

if (n_pollwd > l_pollwd ) {
//<<[MF]"\tPOLLWD $IV[POLL_WD] "
//<<[MF]"\tPOLL_WD_SZ $IV[POLL_WD_SZ] \n"

#{
if ( MB[BB_POLLWD_INDEX] == 0) {
  wend = BB_POLLWD_INDEX + 2
}
else {
  wend = BB_POLLWD_INDEX +IV[POLL_WD_SZ]
}
#}

  wend = BB_POLLWD_INDEX +IV[POLL_WD_SZ]

//<<[MF]"%(25,, ,\n) %2x $MB[BB_POLLWD_INDEX:wend] \n" 
l_pollwd = n_pollwd  
}



n_cfa =IV[CMN_FA_INDEX]

if (n_cfa > l_cfa ) {
<<[MF]"\tCMN_FA_INDEX $IV[CMN_FA_INDEX] "
//<<[MF]"\tCMN_FA_SZ $IV[CMD_FA_SZ] \n"
//wend = BB_CFA_INDEX +IV[CMF_FA_SZ]
wend = BB_CFA_INDEX + cmn_fa_sz
<<[MF]"%(25,, ,\n) %2x $MB[BB_CFA_INDEX:wend] \n" 
l_cfa = n_cfa  
}



n_sdnvm =IV[BMP_WRT_SDNVM]
//<<"%V $n_sdnvm $l_sdnvm \n"
if (n_sdnvm > l_sdnvm ) {
<<[MF]"\tWRT_SDNVM $IV[BMP_WRT_SDNVM] "
<<[MF]"\tWRT_SDSZ $IV[BMP_WRT_SDSZ] \n"
wend = BB_SD_INDEX +IV[BMP_WRT_SDSZ]
wend = BB_SD_INDEX + 30   // it all zeros
<<[MF]"%(20,, ,\n) %2x $MB[BB_SD_INDEX:wend] \n" 
l_sdnvm = n_sdnvm  
}



n_srvnvm =IV[NVM_SVRWRT_REQ]
//<<"%V $n_srvnvm $l_srvnvm \n"
if (n_srvnvm > l_srvnvm ) {
<<[MF]"\tSVRWRT_CNT $IV[NVM_SVRWRT_CNT] "
<<[MF]"\tSVWRT_OA %x\t$IV[NVM_SVWRT_OA] "
<<[MF]"\tREQ_PAGE\t %d$IV[BMP_REQ_PAGE] "
<<[MF]"\tNVM_SVRW_LEN $IV[NVM_SVRW_LEN] \n"
<<[MF]"\tSD_ADDR\t %x$IV[NVM_SD_ADDR] "
<<[MF]"\tSD_C %x $IV[NVM_SD_ADDR_C] \n"

wend = BB_SVRWRT_INDEX +IV[NVM_SVRW_LEN]
<<[MF]"%(20,, ,\n) %2x $MB[BB_SVRWRT_INDEX:wend] \n" 
//<<"%(20,, ,\n) %2x $MB[BB_SVRWRT_INDEX:wend] \n" 
 SVRPAGE = MB[BB_SVRWRT_INDEX:wend]

l_srvnvm = n_srvnvm  
}


n_srvrdnvm =IV[BMP_RVDATA]
//<<"%V $n_srvnvm $l_srvnvm \n"
if (n_srvrdnvm > l_srvrdnvm ) {
<<[MF]"\tBMP_RVDATA $IV[BMP_RVDATA] \n"


wend = BB_RD_INDEX +200
<<[MF]"%(20,, ,\n) %2x $MB[BB_RD_INDEX:wend] \n" 
l_srvrdnvm = n_srvrdnvm  
}

 wend = BB_SR_INDEX + 200
 SVRRDPAGE = MB[BB_SR_INDEX:wend]



n_rdnvm =IV[BMP_RD_NVM]
if (n_rdnvm > l_rdnvm ) {
<<[MF]"\tRD_NVM $IV[BMP_RD_NVM] "
<<[MF]"\tRD_SZ $IV[BMP_RD_SZ] "
<<[MF]"\tREQ_PAGE $IV[CTS_RD_REQ_PAGE] "
<<[MF]"\tPTID $IV[CTS_RD_REQ_PTID] "
<<[MF]"\tBMP_NVM_RADDR %x $IV[BMP_RD_NVMADDR] \n"
rend = BB_RD_INDEX +IV[BMP_RD_SZ]
<<[MF]"%(25,, ,\n) %2x $MB[BB_RD_INDEX:rend] \n" 
l_rdnvm = n_rdnvm  
}







n_wtnvm =IV[BMP_WRT_NVM]
if (n_wtnvm > l_wtnvm ) {
<<[MF]"\tBMP_WRT_NVM $IV[BMP_WRT_NVM] "
<<[MF]"\tBMP_WRT_SZ $IV[BMP_WRT_SZ] "
<<[MF]"\tBMP_NVM_WADDR %x $IV[BMP_NVM_WADDR] \n"
wend = BB_WT_INDEX +IV[BMP_WRT_SZ]
<<[MF]"%(25,, ,\n) %2x $MB[BB_WT_INDEX:wend] \n" 
l_wtnvm = n_wtnvm  
}


n_rdmsg =IV[WRM]
if (n_rdmsg > l_rdmsg ) {
if (IV[RMSG_SZ] > 0) {
<<[MF]"\tWRM $IV[WRM] "
<<[MF]"\tRMSG_SZ $IV[RMSG_SZ] "

 wend = BB_RMSG_INDEX +IV[RMSG_SZ]

// fmb = MB[BB_RMSG_INDEX]


  wend = BB_RMSG_INDEX + 2




//<<"%V $fmb $wend\n"

//  wend = BB_RMSG_INDEX +IV[RMSG_SZ]

<<[MF]"%(25,,,\n) %2x $MB[BB_RMSG_INDEX:wend] \n" 
// all zeros ??

//<<[MF]" $MB[BB_RMSG_INDEX] \n"

 }
l_rdmsg = n_rdmsg  
}




n_scq =IV[BMP_SKPQ_WRT]
if (n_scq > l_scq ) {
<<[MF]"\tBMP_SKPQ_WRT $IV[BMP_SKPQ_WRT] "
rend = BB_SCQ_INDEX + 64
<<[MF]"%(25,, ,\n) %2x $MB[BB_SCQ_INDEX:rend] \n" 
l_scq = n_scq  
}



// one time
if (do_names) {

n_index = BB_NAME_INDEX
<<"%V $n_index $BB_NAME_INDEX\n"
rend = n_index + 30
<<" %x $MB[n_index:rend] \n"
nm =  MB[n_index:rend]
<<" %s $nm \n" 
for (i = 0; i < 12; i++) {
n_index += 30
rend = n_index + 30
<<" %x $MB[n_index:rend] \n"
nm =  MB[n_index:rend]
<<" %s $nm \n" 
}

nsvr_names =IV[BMP_SVR_NAMES]
<<"%v $nsvr_names \n"

n_index = BB_SVRNAME_INDEX
<<"%V $n_index $BB_SVRNAME_INDEX\n"
rend = n_index + 30
<<" %x $MB[n_index:rend] \n"
nm =  MB[n_index:rend]
<<" %s $nm \n" 


for (i = 0; i < nsvr_names; i++) {
n_index += 30
rend = n_index + 30
<<" %x $MB[n_index:rend] \n"
nm =  MB[n_index:rend]
<<" %s $nm \n" 
}

do_names = 0

}

//<<"--------------------------- ---------------------------\n"

fflush(MF)


}


if ((MB[1] == 0XAA)) {


    recast(SPIV,"char")

    SPIV = MB

    recast(SPIV,"int")

    swab(SPIV)

    nsplf = SPIV[SP_NVM_WRT_REQ]

    if (nsplf > l_nsplf) {

     <<[MF]"$SP_NVM_WRT_REQ nsplf %d $nsplf \n"
     <<[MF]"$SP_NVM_NEW_LATCHFAULT $SPIV[SP_NVM_NEW_LATCHFAULT] \n"

     l_nsplf = nsplf 

      SPDBM = MB[500:599]

      <<[MF]" %(20,, ,\n) %2x $SPDBM \n" 
 
    }


    rdsplf = SPIV[SP_NVM_RD_COMPLETE]

    if (rdsplf > l_rdsplf) {

     <<[MF]"$SP_NVM_RD_COMPLETE  $rsplf \n"
     <<[MF]"$SP_RD LATCHFAULT $SPIV[SP_NVM_RD_COMPLETE] \n"

     l_rdsplf = rdsplf 

      SPDBM = MB[800:999]

      <<[MF]" %(20,, ,\n) %2x $SPDBM \n" 
 
    }


}



///////// READ PF DEBUG /////////////

if ((MB[1] == 0X34)) {


    recast(PFIV,"char")

    PFIV = MB

    recast(PFIV,"int")

    swab(PFIV)



    PF_NVM_RDATT = PFIV[35]


    PF_CR_SP = PFIV[52]
    PF_PRE_SP = PFIV[53]
    PF_POST_SP = PFIV[54]
    PF_FREEZE = PFIV[58]
    PF_NVM_WTATT = PFIV[68]
    PF_WT_PF_BMP = PFIV[70]
    PF_RD_BMP_PF = PFIV[71]

    seen_pf = 1


}



/////////////////////BMP FLAGS & COUNTERS ///////////////////////////////////////////

//    want to retype this


 if ( (MB[0] == 0xDB) && (MB[1] == 0x10)) {

//<<" got BMP pkt \r"

    recast(IV,"char")
    IV = MB
    recast(IV,"int")
    cmcf_rd++

    swab(IV)

    dusec = FineTimeSince(T2,1)



//<<" $IV[3] $IV[4] $IV[5]\n"
//<<" $IV \n"

   FV = IV[0:111]
k = 0
//<<" %8\nR %8x $FV \n"

//<<"%x   $IV[k] \n" ; k++

if (do_time) {
<<"\n BMP DEBUG TABLE [${kw}] \n"
<<"----------------------  FLAGS ---------------------------\n"
<<"\tPT_START_SECS %8d\t$(IV[PT_START_SECS]) "
<<"\tPT_START_USECS %8d\t$(IV[PT_START_USECS]) "
<<"\tPT_DUR_USECS %8d\t$IV[PT_DUR_USECS] "
<<"\tPT_PER_USECS %8d\t$IV[PT_PER_USECS] "
<<"\n"

//   INIT //
<<"\tNVM_FLI_WADDR %x\t$IV[NVM_FLI_WADDR] "
<<"\tCMN_FLEG_ADDR \t%x$IV[CMN_FLEG_ADDR] "
<<"\tCMN_FLEG_NUM \t%d$IV[CMN_FLEG_NUM] "
<<"\tCMN_ACTFA_ADDR \t%x$IV[CMN_ACTFA_ADDR] \n"
<<"\tCMN_FA_FID \t%d$IV[CMN_FA_FID] "
<<"\tCMN_CHK_FA \t%d$IV[CMN_CHK_FA] "
<<"\tCMN_CHK_BH \t%d$IV[CMN_CHK_BH] "
<<"\n"

}


  if (do_pollsvr) {
     show_pollsvr()
  }

 if (do_wrtsvr) {
   show_wrtsvr()

}


if (do_bh) {

<<"--------------- BITE HISTORY ------------------------ \n"
<<"\tNVM_BH_ADDR %x\t$IV[NVM_BH_ADDR] "
<<"\tNVM_BHW_ADDR %x\t$IV[NVM_BHW_ADDR] "
<<" NVM_BH_ADDR_C  %x $IV[NVM_BH_ADDR_C] "
<<" NVM_SD_ADDR_C %x $IV[NVM_SD_ADDR_C] "
<<"\tBMP_RD_NVMADDR \t%x$IV[BMP_RD_NVMADDR] "
<<" \n"

<<"\tBMP_MRERR %8d\t$IV[BMP_MRERR] "
<<"\tNVM_BHWRT_REQ %8d\t$IV[NVM_BHWRT_REQ] "
<<"\tBMP_NSC %8d\t$IV[BMP_NSC] "
<<"\tFSQ_STATE %8d\t$IV[FSQ_STATE] "
<<" \n"

<<"\tFSQ_OS_ %8d\t$IV[FSQ_OS] "
<<"\tNVM_VHEAD %8d\t$IV[NVM_VHEAD] "
<<"\tBMP_FLEG %8d\t$IV[BMP_FLEG]"
<<" \n"

<<"\tFSQ_OSX_PTR \t%x$IV[FSQ_OSX_PTR] "
<<"\tBMP_FSQ_OPTRFR \t%x$IV[BMP_FSQ_OPTRFR] "
<<"\tBMP_TMPHDR_OFF \t%x$IV[BMP_TMPHDR_OFF] "
<<"\tRPM_BH_ADDR \t%x$IV[RPM_BH_ADDR] "
<<" \n"

<<" CMN_MAXCL_SOFF %d $IV[CMN_MAXCL_SOFF] "
<<" CMN_BH_FULL %d $IV[CMN_BH_FULL] "
<<" CMN_BH_WADDR %x $IV[CMN_BH_WADDR] "
<<" CTS_NVM_BH_SZ $IV[CTS_NVM_BH_SZ] "

<<" \n"
}



  if (do_maint) {
    show_maint()
  }




/////////////////////// ALWAYS ///////////////////////////


 if (do_frq) {
//<<"%V $last_bmpcnt \n"
     show_frq(last_bmpcnt, dusec)
     last_bmpcnt = IV[BMP_FRQ];  
 }


//  BMPFSQNAME = MB[1350:1379]
//<<"%V %s $BMPFSQNAME "
//  <<"DBC_CMD: %hx $DBC  \n"
//  <<"DBC_CMD:  %s $adbc $dbc_cmd\n"
  <<"DBC_CMD: %V  $dbc_val $dbc_cmd\n"
//<<"\tFSQX_PTR %x\t$IV[BMP_FSQX_PTR] "
//<<" FSQX_PTR_C %x $IV[BMP_FSQX_PTR_C] \n"

//<<"\tBMP_FSQ_OUTPTR %x\t$IV[BMP_FSQ_OUTPTR] "
//<<" BMP_FSQ_OUTPTR_C %x $IV[BMP_FSQ_OUTPTR_C] \n"
<<"\tBMP_WRT_SDNVM $IV[BMP_WRT_SDNVM] "

if (seen_pf) {
<<"  PFRD  $PF_NVM_RDATT PFWT    $PF_NVM_WTATT  \n"
<<"%V    $PF_CR_SP $PF_PRE_SP $PF_POST_SP  $PF_FREEZE\n"
<<"%V    $PF_WT_PF_BMP     $PF_RD_BMP_PF  \n"
}

<<"\tPOLL_RD %8d\t$(IV[POLL_RD]) \tPOLL_WD %8d\t$(IV[POLL_WD]) \n"
//<<"\tSS_RDP %8d\t$IV[SS_READP] SS_WRITEP %8d\t$IV[SS_WRITEP] \n"



if (IV[CTS_RD_REQ_PTID] == 52) {
last_pf_rdpage = IV[CTS_RD_REQ_PAGE]
}

if (IV[CTS_WT_REQ_PTID] == 52) {
last_pf_wtpage = IV[CTS_WT_REQ_PAGE]
}


<<"\tPF RD_PAGE $last_pf_rdpage WRT_PAGE $last_pf_wtpage \n"



if (IV[CTS_RD_REQ_PTID] == 51) {
last_sp_rdpage = IV[CTS_RD_REQ_PAGE]
}

if (IV[CTS_WT_REQ_PTID] == 51) {
last_sp_wtpage = IV[CTS_WT_REQ_PAGE]
}

<<"\tSP RD_PAGE $last_sp_rdpage WRT_PAGE $last_sp_wtpage \n"

//  POLL_SRV INPUT
   psvri = POLL_SVC


   for (pi = 0; pi < 7; pi++) {
// FIX <<"\t$IV[psvri] \t%d$IV[(psvri + 1)] \n"
<<"\t$IV[psvri] " ; psvri++
<<"\t$IV[psvri] " ; psvri++
<<"\t$IV[psvri] " ; psvri++
<<"\t$IV[psvri] " ; psvri++
<<"\t$IV[psvri] " ; psvri++
<<"\t$IV[psvri] " ; psvri++
<<"\t%d$IV[psvri] \n"
    psvri++
   } 


<<"\n\tWT_PTID $IV[CTS_WT_REQ_PTID] WT_PAGE $IV[CTS_WT_REQ_PAGE] \n"
<<"\n%(20,, ,\n) %2x $SVRPAGE \n" 

<<"\tRD_PTID $IV[CTS_RD_REQ_PTID] RD_PAGE $IV[CTS_RD_REQ_PAGE] \n"
<<"\n%(20,, ,\n) %2x $SVRRDPAGE \n" 

//  XNAME = MB[1350:1379] //<<"%V %s $XNAME \n"

//  MNAME = MB[1460:1490]
//<<" %s $MNAME \n"
// its NVM_FLASH


    kw++
    if (how_many > 0) {
     if (kw > how_many) {
        break
      }
    }

     }
    }
    }
   }
  }
}

// we want to create socket on our local machine
// on the port that the other side is sending

port = 9873    // debug data packet port

 Ipa = "any"

 #{
 if (AnotherArg()) {
  Ipa = GetArgStr()

 }

 if (Ipa @= "") {
  Ipa = "any"
 }
 #}

//<<"%V  $Ipa $port \n"


      A = GsockCreate(Ipa, port, "UDP")

<<"$Ipa created UDP type socket index $A $port\n"

//      GsockConnect(A)

      errnum = CheckError()

<<"%v $errnum \n"


C=ofr("/usr/people/user/softbench_sbc_ip")

Ipa = rword(C)

<<" %v $Ipa \n"

#{
    B = GsockCreate(Ipa, port, "UDP")

<<"created UDP type socket index $B $port\n"

      GsockConnect(B)

      errnum = CheckError()

<<"%v $errnum \n"

//<<" now sending stuff to it \n"
   
   n=GsockSendTo(B,"c")
#}

  arg1 = _clarg[1]

  arg2 = _clarg[2]

  if (arg1 > 0) {

      how_many = arg1
  }




      StrCli()


      STOP!
