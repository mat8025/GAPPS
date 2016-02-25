# "$Id: fe_sann.g,v 1.1 1998/05/14 21:11:14 mark Exp mark $"

# generate input : launch net on machine
DB = 0

define_proc
parse_cla(the_cla)
{

	if (the_cla @= "UPE") {
                do_UPE = 1
	}

        if (the_cla @= "E") {
                do_English = 1
	 }

        if (the_cla @= "G") {
                do_German = 1
	 }

        if (the_cla @= "S") {
                do_Spanish = 1
	 }

        if (the_cla @= "J") {
                do_Japanese = 1
	 }

        if (the_cla @= "Lang") {

		do_English = 0
		do_German = 0
		do_Spanish = 0
	        do_Japanese = 0
		do_Italian = 0
		do_Chinese = 0
		do_Turkish = 0
	}

	if (the_cla @= "FL") {
                do_FL = 1
	}

	if (the_cla @= "FE") {
		FE = get_cl_arg(cl_i)
	        cl_i += 1
	}

	if (the_cla @= "SE") {
		SE = get_cl_arg(cl_i)
	        cl_i += 1
	}

	if (the_cla @= "sleep") {
		sleep = get_cl_arg(cl_i)
	        cl_i += 1
	}

	if (the_cla @= "host") {
		host = get_cl_arg(cl_i)
	        cl_i += 1
	}
}

host = "mosquito"

sleep = 0

FE="CRBS_1"

SE="cs6"

do_UPE = 0
do_FL = 0

do_English = 1
do_German = 1
do_Spanish = 1
do_Japanese = 1

do_Italian = 1
do_Chinese = 1
do_Turkish = 1


na = get_argc()

if (na < 3) {
o_print("usage : fe_sann FE a_fe  SE an_exp {UPE,FL} {host machine} {sleep secs} ","\n")
ff=exit_si()
}

sleep = 0

db_print(DB,na ,"\n")

cl_i = 1
cla = "NULL0"

while (! (cla @= "")) {

	cla = get_cl_arg(cl_i)

        db_print(DB,cla,"\n")

	cl_i = cl_i + 1

	if (cla @= ">") {
		cla = ""
	}
	else {
	  parse_cla(cla)
        }
}

  db_print(DB,FE," ", SE , "\n")


if (sleep > 0) {
  si_pause(sleep)
}

expdir = str_cat("/mosquito/asr/ann/timit/EXP/",SE)

db_print(DB,expdir,"\n")

chdir(expdir)

fe_name = str_cat("/mosquito/asr/ann/timit/GS_FE/",FE)

sz = f_exist(fe_name,0,0)
if (sz <= 0) {
o_print("ERROR no such FE ",fe_name,"\n")
ff=exit_si()
}

command("mkdir ",FE)

chdir(FE)

command ("cp ",fe_name, " fe_setup")

# TIMIT train/test
sexp = SE
db_print(DB,"sexp ",sexp," ",do_UPE,"\n")

command ("sip asr/gen_fl_input  train staged > tr.log ")

command ("sip asr/gen_fl_input  test  > tst.log ")

# mini UPE data base

if (do_UPE) {
db_print(DB,"UPE english ","\n")

if (do_English) {
command ("sip asr/gen_fl_input  UPE English > E.log ")
}

if (do_German) {
command("sip asr/gen_fl_input  UPE German > G.log ")
}

if (do_Spanish) {
command("sip asr/gen_fl_input  UPE Spanish > S.log ")
}

if (do_Japanese) {
command("sip asr/gen_fl_input  UPE Japanese > J.log ")
}


if (do_Chinese) {
command("sip asr/gen_fl_input  UPE Chinese > C.log ")
}

if (do_Turkish) {
command("sip asr/gen_fl_input  UPE Turkish > T.log ")
}

if (do_Italian) {
command("sip asr/gen_fl_input  UPE Italian > I.log ")
}

}

# new FL data base

if (do_FL) {

if (do_English) {
command ("sip asr/gen_fl_input  FL English > EFL.log ")
}

if (do_German) {
command("sip asr/gen_fl_input  FL German > GFL.log ")
}

if (do_Spanish) {
command("sip asr/gen_fl_input  FL Spanish > SFL.log ")
}

if (do_Japanese) {
command("sip asr/gen_fl_input  FL Japanese > JFL.log ")
}

}

#  machine ee  fe   sleep

fese_name = str_cat("/mosquito/asr/ann/timit/EXP/",SE,"/",FE)
#{
if (si_error() ) 
exit_si()
}
#}

command("rsh ",host," -n sip asr/net_launch expfe_dir ", fese_name , " > nf.log & ")

ff=exit_si()

