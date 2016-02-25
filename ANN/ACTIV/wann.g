# "$Id: wann.g,v 1.11 1998/05/13 17:03:00 mark Exp $"
# check ann's

set_debug(0)
myname = get_uname(1)


define_proc
ping_it(host)
{
command("ping -c 1 ",host," > /tmp/hostup")

a= o_file("/tmp/hostup","rb")
isup=search_file(a,"round-trip",0)
c_file(a)
command("rm /tmp/hostup")
if (isup == -1) {
return 0
}
return 1
}


define_proc
get_file_info(the_trk_file, pat)
{
pid = -1
a= o_file(the_trk_file,"rb")
pos=search_file(a,pat,1)
if (pos != -1) {
s_file(a,pos,0)
pid = r_file(a)
}
c_file(a)
return (pid)
}

cwd=get_dir()

sweep_up = 0

FE = get_cl_arg(2)

SWEEP = get_cl_arg(3)

if (SWEEP @= "sweep") {
sweep_up = 1
}

#o_print("FE ",FE,"\n")

if (FE @= "") {
FE = "*"
}

if (FE @= "sweep") {
FE = "*"
sweep_up = 1
}


stem = "/mosquito/asr/ann/"

trk = str_cat(stem,"timit/EXP/*/",FE,"/*/tr.trk")

command("ls ",trk,">","/tmp/the_trks")

doit = 1

A=o_file("/tmp/the_trks","r")

# who is up?
# list of ann hosts

ping_list = get_alias("WORK/ping_list")

command("rsh -n mosquito ps -ax | grep 'ann -i' > ",ping_list)

if (ping_it("lancaster")) {
command("rsh -n lancaster ps -ax | grep 'ann -i'  >> ",ping_list)
}

if (ping_it("corsair")) {
command("rsh -n corsair ps -ax | grep 'ann -i' >> ",ping_list)
}

#{
if (ping_it("tomcat")) {
command("rsh -n tomcat ps -ax | grep 'ann -i' >> ",ping_list)
}

if (ping_it("hal_jr")) {
command("rsh -n hal_jr ps -ax | grep 'ann -i' >> ",ping_list)
}
#}


#o_print("FE ",FE,"\n")

o_print("exp				sweep	pats	rms	pc the_ann_pid	host","\n")

while (doit) {

the_ann= r_file(A)

if (the_ann @= "EOF") {
break
}
# does the_ann have right FE?

the_trk_file= the_ann

# is it there

there = f_exist(the_trk_file,0,0)

#o_print(there," ",the_trk_file,"\n")

if (there > 0) {
is_FE = str_pat(the_ann,"EXP",1)
the_ann = str_pat(is_FE,"/tr.trk")

#o_print(the_ann," ",is_FE,"\n")

the_ee = str_pat(the_ann,"/",1)
the_ee = str_pat(the_ee,"/")

#o_print(the_ee,"\n")

the_FE = str_pat(the_ann,"/",1)
the_FE = str_pat(the_FE,"/",1)
the_FE = str_pat(the_FE,"/")

#o_print(the_FE,"\n")

the_ann_pid = get_file_info(the_trk_file, "pid")
#o__print(the_ann_pid,"\n")

the_host = get_file_info(the_trk_file, "host")
#o__print(the_host,"\n")
}


if (si_error() ) {
command("rm -f  /tmp/how_good")
exit_si()
}

set_si_error(0)

if ((there > 0) && ( ! (is_FE @= "") ) ) {

	command("tail -1",the_trk_file,">","/tmp/how_good")
	command("chmod 666 /tmp/how_good")

        C= o_file("/tmp/how_good","r")
	
	        valid_pc = 0
		swp=r_file(C)
		rms=r_file(C)
		pc= r_file(C)

	if ( ! (pc @= "EOF")) {
	        valid_pc = 1
		rms=Fround(rms,5)
		pc= Fround(pc,2)
        }
	else {
	     rms = 0
             pc = 0
             swp = 0
        }
		c_file(C)

# alive or dead
# now are we still alive

	still_going = 0

	RP = o_file(ping_list,"rb")

        if (RP == -1) {
	        ff=exit_si()
        }

	set_si_error(0)

	chk_list = 1

	while (chk_list) {

		apid = rwl_file(RP,1)

#		o_print("apid is ",apid,"\n")

		if (apid == the_ann_pid) {
			still_going = 1
			chk_list = 0
		}

		if (apid @= "EOF" ) {
			chk_list = 0
		}
         }

	set_si_error(0)

	if (still_going) {
		aod ="alive"
	}
	else {
	aod ="done"
	}


   the_ann_dir = str_cat(stem,"/timit/EXP",the_ann)

if (aod @= "alive") {

   chdir(the_ann_dir)

    sz = f_exist("tr.trk",0,0)
                np_stage= "unknown"
    if (sz > 0) {
    command("tail -1 tr.trk > ","the_stage ")

                C= o_file("the_stage","rb")
                if ( C != -1) {
		np_stage=rwl_file(C,4)
                c_file(C)
                }
                else {
                np_stage= "unknown"
                }
     }
	set_si_error(0)
o_print(the_ann,"	",swp,"	",np_stage,"	",rms,"	",pc,"	",the_ann_pid,"	",the_host,"\n")

   if (sweep_up) {

   chdir(the_ann_dir)

#o_print("/asr/ann/TOOLS/cr_test"," ",the_ann_dir,"\n")

   command("/asr/ann/TOOLS/cr_test ",the_ann_dir, "> test_ann_log")

# check for res1

   sz = f_exist("res1",0,3)

   if (sz > 0) {
   bell()
   command("supr ",the_ee,the_FE,"leave")
   command("cp res1 resA")
   }

# if kill_ann rsh the_host kill -9 the_ann_pid

   sz= f_exist("kill_ann",0,0)

   if (sz > 0) {
o_print("killing ann ",the_ann_pid," on ",the_host,"\n")
   command("rsh -n ",the_host," kill -9 ",the_ann_pid)
   }
   chdir(cwd)
   }
}

	c_file(RP)
    } # there

}

# clean_up

command("rm  /tmp/how_good")
set_si_error(0)

ff= exit_si()


