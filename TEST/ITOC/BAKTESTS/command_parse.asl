

//setdebug(1,"trace")

checkin()

str pt_file;
pt_file="tran.pt"
ph_file="tran.ph"
spp_file="tran.spp"

frlen = 44
pow_thres = 65
pt_file= "tran.pt"

<<"%V$pt_file \n"
voxname = "fac.vox"
foo= "ceppt -i $voxname -o ceppt.df -l $frlen -s 7 -n 512 -S 3 -p $pt_file -t 1.6 -b 60 -e 400 -P $pow_thres -A -z $ph_file -x $spp_file "

<<"$foo\n"

words = Split(foo)

<<"%(1,,,\n)$words\n"

checkStr(words[0],"ceppt")
checkStr(words[25],"tran.ph")
checkStr(words[27],"tran.spp")
<<"$words[25]\n"
checkOut()

exit()