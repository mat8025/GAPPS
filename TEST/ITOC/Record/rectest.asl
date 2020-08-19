//%*********************************************** 
//*  @script rectest.asl 
//* 
//*  @comment  Record element assign equate 
//*  @release CARBON 
//*  @vers 1.2 He Helium [asl 6.2.53 C-He-I]                                 
//*  @date Sat May 30 14:14:28 2020 
//*  @cdate Sat May 30 14:14:28 2020 
//*  @author Mark Terry 
//*  @Copyright © RootMeanSquare  2010,2020 → 
//* 
//***********************************************%
myScript = getScript();
///
///

chkIn(_dblevel)

Record R[10]


R->info(1)


Rn = 5;

Record DF[10]

DF->info(1)



   DF[0] = Split("task?,4,30,0,0,3,?,0,,",',') ; // default for add additional task
   <<"$DF[0]\n"
   // use enum
   DF[1] = Split("Exercise,9,70,0,1,7,X,0,,",',')
   DF[2] = Split("Guitar,8,30,0,0,3,G,0,,",',')
   DF[3] = Split("Spanish,8,30,0,0,3,L,0,,",',')
   DF[4] = Split("PR/DSP,8,60,0,0,8,D,0,,",',')
   DF[5] = Split("task5,8,60,0,0,8,D,0,,",',')    


rstr = DF[0][0];
<<"%V$rstr \n"
<<"%V$DF[0][0] \n"
chkStr(rstr,"task?")




rstr = DF[1][1];
<<"%V$rstr \n"
<<"%V$DF[0][0] \n"
chkStr(rstr,"9")

er = 0;
wt = 0
R[er] = DF[wt];

rstr = R[er][0];
<<"%V$rstr \n"
<<"%V$R[0] \n"
<<"%V$R[0][0] \n"
<<"%V$R[er][0] \n"
chkStr(rstr,"task?")


er = 1;
wt = 1
R[1] = DF[wt];
<<"%V$R[0] \n"
<<"%V$R[1] \n"
R->info(1)





R[er] = DF[wt];
<<"%V$R[1] \n"
<<"%V$R[er] \n"
rstr = R[er][0];
<<"%V$rstr \n"
<<"%V$R[1][0] \n"
chkStr(rstr,"Exercise")

er = 2;
wt = 2

R[er] = DF[wt];

<<"%V$R[2] \n"
<<"%V$R[er] \n"
<<"%V$R[er][0] \n"

rstr = R[er][0];
<<"%V$rstr \n"
chkStr(rstr,"Guitar")



er = 0;
wt = 0
for (i= 0; i <6; i++) {
    er = i;
    R[er] = DF[wt];
    
<<"%V $wt $DF[wt]  \n"
<<"%V $er $R[er] \n"
    wt++;
}

er = 1;
<<"%V $er $R[er] \n"
<<"%V$R[0] \n"
<<"%V$R[0][0] \n"
rstr = R[0][0];
<<"%V$rstr \n"
chkStr(rstr,"task?")
chkStr(R[0][0],"task?")
<<"%V$R[1] \n"
<<"%V$R[1][0] \n"
chkStr(R[1][0],"Exercise")
<<"%V$R[2] \n"
<<"%V$R[2][0] \n"
chkStr(R[2][0],"Guitar")
<<"%V$R[3] \n"
<<"%V$R[3][0] \n"
chkStr(R[3][0],"Spanish")

er++
<<"%V $er $R[er] \n"
er++
<<"%V $er $R[er] \n"

wt= 0
er = 1;
    R[er] = DF[wt];
<<"%V $er $R[er] \n"
er++;
wt++;
    R[er] = DF[wt];
<<"%V $er $R[er] \n"
er++;
wt++;
    R[er] = DF[wt];
<<"%V $er $R[er] \n"

er++;
wt++;
    R[er] = DF[wt];
<<"%V $er $R[er] \n"



chkOut()
