
setdebug(1)

pt_file="tran.pt"
ph_file="tran.ph"
spp_file="tran.spp"

frlen = 44
pow_thres = 65

voxname = _clarg[1];


<<"starting cepstum pitch extraction on $voxname"

//job_nu=gs_job("ceppt","-i","$voxname","-o","ceppt.df",\
//"-l",frlen,"-s",7,"-n",512,"-S",3,"-p",pt_file,"-t",1.6,"-b",60,"-e",400,"-P",pow_thres,"-A","-z",ph_file,"-x",spp_file)

//isfp =f_exist(job_nu,0,320)

<<"\n ceppt -i $voxname -o ceppt.df -l $frlen -s 7 -n 512 -S 3 -p $pt_file -t 1.6 -b 60 -e 400 -P $pow_thres -A -z $ph_file -x $spp_file \n"

ok=!!"ceppt -i $voxname -o ceppt.df -l $frlen -s 7 -n 512 -S 3 -p $pt_file -t 1.6 -b 60 -e 400 -P $pow_thres -A -z $ph_file -x $spp_file"

<<"finished cepstum pitch extraction\n"

sleep(2)

<<"$ok \n"
