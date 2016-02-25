# "$Id: test_ann.g,v 1.13 1998/05/03 14:20:16 mark Exp mark $"
# test ann for each wt saved
# mail/notify if good result and better than last report
# kill net process if performance is bad

set_debug(10)

ascii Wd[60]
char MS[256]

epc= 0
gpc = 0
spc = 0
jpc = 0

old_epc = 0
old_gpc = 0
old_spc = 0
old_jpc = 0

do_UPE = 1
do_FL = 1


define_proc
open_file(fname,mode)
{
      oec = o_file(fname,mode)
     if (oec == -1) {
o_print("can't open ",fname, " ",mode, "\n")
      ff=exit_si()
     }
     return oec
}


define_proc
transfer_upe_test(L)
{
  arc_f = str_cat("net_",L,".arc")
  sz = f_exist(arc_f,0,1)
    if ( sz > 0 ) {
      L_perf = str_cat(L,"_perf")
      L_cm = str_cat(L,".cm")
      command("fl_test ",L," goldws > ",L_perf)
      aa= o_file(L_perf,"rb")
      if (aa != -1) {
       nwr = r_words(aa,&Wd[0])
       pc = Wd[8]
       c_file(aa)
      }
      command("cat ",L_perf, ">> fl_perf")
      command("sip asr/scm ",L," goldws > ", L_cm)
      return pc
    }
      return -1
}



define_proc
w_comment(login)
    {
      if (gold < 70) {
        w_file(S,"shot sir! ",gold," with ",the_gold_ws,"\n")
      }

      if ((gold >=70) && (gold < 75)) {
        w_file(S,"fair shot sir! ",gold," with ",the_gold_ws,"\n")
      }

      if ((gold >= 75) && (gold < 80) ) {
        w_file(S,"good shot sir! ",gold," with ",the_gold_ws,"\n")
      }

      if ((gold >= 80) && (gold < 85)) {
        w_file(S,login," very good shot sir! ",gold," with ",the_gold_ws,"\n")
      }

      if ((gold >= 85) && (gold < 90)) {
        w_file(S,login," great shot sir! ",gold," with ",the_gold_ws,"\n")
      }

      if ((gold >= 90) && (gold < 95)) {
        w_file(S,login," excellent shot sir! ",gold," with ",the_gold_ws,"\n")
      }

      if (gold >= 95) {
        w_file(S,login," terrific shot sir! ",gold," with ",the_gold_ws,"\n")
      }
 }


define_proc
do_rec_tests()
{

command("/asr/ann/TOOLS/classify goldws > Class_perf")
command("/asr/ann/TOOLS/test_wts goldws > Rec_perf")
command("sip asr/scm tst goldws > tst.cm ")

epc=transfer_upe_test("E")
if (epc == -1) {
o_print("ERROR E transfer test ","\n")
}
spc=transfer_upe_test("S")
gpc=transfer_upe_test("G")
jpc=transfer_upe_test("J")
cpc=transfer_upe_test("C")
tpc=transfer_upe_test("T")
ipc=transfer_upe_test("I")

efl_pc=transfer_upe_test("E_FL")
if (efl_pc == -1) {
o_print("ERROR E_FL transfer test ","\n")
}

gfl_pc=transfer_upe_test("G_FL")
sfl_pc=transfer_upe_test("S_FL")
jfl_pc=transfer_upe_test("J_FL")

}


  define_proc
  cat_it(L)
  {
  fname = str_cat(L,".cm")
  sz =f_exist(fname,0,0)
  if (sz > 0) {
  command("cat  ",fname," >> good_shot")
  }

  }


define_proc
mail_news(gold)
{
      if (gold >= 94.0) {
        command("mail asr < good_shot")
      }
      else {
          if (gold >= 75.0) {
            command("mail mark < good_shot")
          }
      }
}


myname = get_uname(1)
orec_p = 0
prec_p = 0

cwd=get_dir()

# get list of ws in time-order

command("rm -f kill_ann save_ann")
command("ls -tr ws.* > wslist")
command("wc wslist > wsnum")

gold = 0

gold_num = 1
the_gold_ws = "ws.1"

sz = f_exist("gold",0,0)

  if ( sz > 0 ) {
    B=open_file("gold","rb")
    gold = r_file(B)
    gold_num = r_file(B)
    o_print("gold_num ",gold_num,"\n")
    the_gold_ws = str_cat("ws.",gold_num)
    c_file(B)
    o_print("previous best ",gold," at ws ",gold_num,"\n")
  }

# get earliest

A=open_file("wsnum","rb")

n= r_file(A)



o_print(n,"\n")

  if (n < 2) {
    ff =exit_si()
  }

Z=open_file("cr_log1","wb")

B=open_file("wslist","rb")

news = 0

  for (k = 0 ; k < n ; k = k +1) {

    the_ws= r_file(B)

    the_ws_num = str_pat(the_ws,"ws.",1)

    o_print(the_ws , " ",the_ws_num,"\n")

    command("cp ",the_ws," lastws")

    command("/asr/ann/TOOLS/classify lastws > class_perf")

    command("cat class_perf >> class_log")

    sz = f_exist("class_perf",0,1)

      if ( sz <=0 ) {
        o_print("ERROR running classify","\n")
        ff=exit_si()
      }

    C = open_file("class_perf","rb")

    class_rp = rwl_file(C,9)

    s_file(C,0,0)

    class_rms = rwl_file(C,7)

    c_file(C)

    command("/asr/ann/TOOLS/test_wts lastws > rec_perf")

    command("cat rec_perf >> rec_log")

    sz = f_exist("rec_perf",0,1)

      if ( sz <=0 ) {
        o_print("ERROR running recognition","\n")
        ff=exit_si()
      }

    C = open_file("rec_perf","rb")

    rec_p = rwl_file(C,9)
    s_file(C,0,0)
    rms_p = rwl_file(C,7)
    c_file(C)

    getting_better = 0

      improve = rec_p - orec_p

      if ((improve >= 0.1) && (rec_p > 5)) {
        getting_better = 1
      }

    prec_p = orec_p

    orec_p = rec_p

 o_print("getting_better ",getting_better, " improve ", improve,"\n")

    w_file(Z,the_ws," classify ",class_rms," ",class_rp," recog ",rms_p," ",rec_p,"\n")

      if (rec_p > gold ) {
        news = 1
        gold = rec_p
        the_gold_ws = the_ws
        gold_num = the_ws_num
        command("cp ",the_ws," goldws")
      }

      if (k < (n-3)) {
        command("rm ",the_ws)
      }
  }


the_cwd= get_dir(&MS[0])
str_scan(&MS[0],&the_cwd)

# append to previous run

command("cat cr_log1 >> cr_log")

# decide whether to live or let die

login=get_env_var("LOGNAME")

# Getting better ?


  if (getting_better) {

    S=open_file("good_shot","wb")

    w_file(S,"score ",gold,"\n")
    w_file(S,"net ",the_cwd," with ",the_gold_ws,"\n")
    c_file(S)

   S=open_file("gold","wb")
   w_file(S,gold," ",gold_num)
   ff=c_file(S)

  if (gold > 60) {

    S=open_file("good_shot","wb")

    w_file(S,"Results from ",the_cwd," with ",the_gold_ws,"\n")

    w_comment(login)

    w_file(S,"% inc  ",Fround(improve,2) ,"\n")

    ff=c_file(S)

    command("cp good_shot ann_specs")
    command("cat net_tr.arc >> ann_specs")
    command("cat net_tst.arc >> ann_specs")
    command("cat ../fe_setup >> ann_specs")

   }

    do_rec_tests()

    command("sip asr/get_results ",the_ws_num, " > res1")

C = open_file("fl_perf","rb")
fl_p=rwl_file(C,9)
s_file(C,0,0)
rms_p= rwl_file(C,7)
c_file(C)
trans =fl_p - gold

S=open_file("good_fl","wb")
w_file(S," FLT in ",the_cwd," timit ",gold," FL Spanish ",fl_p," transfer ",trans,"\n")
c_file(S)

  command("cat res1 >> good_fl")
  command("cat res1 >> good_shot")
  command("cat tst.cm  >> good_shot")

  cat_it("E")
  cat_it("S")
  cat_it("G")
  cat_it("J")
  cat_it("T")
  cat_it("I")
  cat_it("C")

  cat_it("E_FL")
  cat_it("S_FL")
  cat_it("G_FL")
  cat_it("J_FL")

#  command("cat  E_FL.cm S_FL.cm G_FL.cm J_FL.cm >> good_shot")

  if (do_UPE) {
  i_epc = fround((epc - old_epc),2)
  i_gpc = fround((gpc - old_gpc),2)
  i_spc = fround((spc - old_spc),2)
  i_jpc = fround((jpc - old_jpc),2)

  command("echo ",i_epc," ",i_gpc," ",i_spc," ",i_jpc," >> good_shot")
  old_epc = epc
  old_gpc = gpc
  old_spc = spc
  old_jpc = jpc
  }

   if (improve > 1.0) {
   mail_news()
   }

}



# live or let die

P=open_file("tr.trk","rb")


search_file(P,"pid")
the_pid = r_file(P)
c_file(P)

o_print(the_pid,"\n")

# now are we still alive
still_going = 0
pid_list = get_alias("WORK/pid_list")
command("ps -ax | grep ann  | grep grep -v - > ",pid_list)

RP = open_file(pid_list,"rb")

set_si_error(0)

chk_list = 1

  while (chk_list) {
    apid = rwl_file(RP,1)
      if (apid == the_pid) {
        still_going = 1
        chk_list = 0
      }
      if (si_error()) {
        chk_list = 0
      }
  }

set_si_error(0)

max_wn = 30

#command("kill -9",the_pid)
#ff=exit_si()

o_print("kill it ? ",the_pid," gold ",gold, " rec_p ",rec_p," prec_p ",prec_p, " gb ",getting_better," ws. ",the_ws_num,"\n")

  if ( !still_going) {
    o_print("net done or stopped or other host","\n")
#exit_si()
  }


killit = 1

  if ( (the_ws_num < max_wn/2) ) {
    killit = 0
  }

  if ( (the_ws_num > (max_wn/3) ) && (rec_p < 75) ) {
    killit = 1
  }

gnd = the_ws_num - gold_num

# o_print("gnd ", gnd,"\n")

  if ( (the_ws_num > (max_wn/4)) && (rec_p < gold) && ( gnd > 3) ) {
    killit = 1
  }

  if ( (improve >= 1.0) && (rec_p >= 80 ) ) {
    killit = 0
  }

  if (killit) {

# its dead Jim

    o_print(" its dead Jim","\n")

    S=open_file("kill_ann","wb")

    w_file(S,"killing ",the_pid," gold ",gold, " rec_p ",rec_p," prec_p ",prec_p, " gb ",getting_better," GN ",gold_num,"\n")

    c_file(S)

      if ( still_going) {
        command("kill -9",the_pid)
      }

    command("cat kill_ann >> good_shot")
    command("mail mark < good_shot")
    ff =exit_si()
  }

o_print("let it live ",improve, " ",rec_p,"\n")
S=open_file("save_ann","w")
w_file(S,"let_live ",the_ws_num," ",the_pid," gold ",gold, " rec_p ",rec_p," ",improve,"\n")
c_file(S)

ff=exit_si()

