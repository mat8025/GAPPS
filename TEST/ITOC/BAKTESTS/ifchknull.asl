///
///
///

setDebug(1,@pline,@~step,@trace,@showresults,1)
filterFuncDebug(ALLOWALL_,"proc");
filterFileDebug(ALLOWALL_,"ic_op");



 

 fname = _clarg[1];


 sv = "";


<<"sv $(typeof(sv))  <|$sv|> \n"



//int ans = atoi(_clarg[1]);

checkIn();

<<"ca1 <|$fname|>\n"

 tf= (fname @= "");

<<"$(typeof(tf)) %V $tf \n"



 ntf= !(fname @= "");

<<"$(typeof(ntf)) %V $ntf \n"

 stf= scmp(fname,"");

<<"$(typeof(stf)) %V $stf \n"





int ans = 0;

if (ans) {

<<"ans != 0 %V $ans\n"

}
else {

<<" correct $ans == 0\n"
checkNum(ans,0)
}



if (!ans) {

<<"correct ans == 0 !ans %V $ans\n"
checkNum(ans,0)
}
else {

<<"incorrect  $ans != 0\n"

}


if (!(ans)) {

<<"correct ans == 0 !ans %V $ans\n"

}
else {

<<" $ans != 0\n"

}

if (!(ans == 1)) {

<<"correct !(ans == 1) %V $ans\n"
checkNum(ans,0)
}
else {

<<" $ans != 0\n"

}




if (fname @= "") {

<<"ca1 <|$fname|> is NULL\n"

}


if ((fname @= "") != 1) {

<<"ca1 <|$fname|> has value1\n"

}
else {

<<"ca1 <|$fname|> is NULL\n"
}

if (!(fname @= "")) {

<<"ca1 <|$fname|> has value2\n"

}
else {

<<"ca1 <|$fname|> is NULL\n"
}


checkOut();


exit()