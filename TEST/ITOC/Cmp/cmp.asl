/* 
 *  @script cmp.asl                                                     
 * 
 *  @comment test SF Cmp                                                
 *  @release Carbon                                                     
 *  @vers 1.4 Be Beryllium [asl 6.28 : C Ni]                            
 *  @date 06/12/2024 18:02:49                                           
 *  @cdate 1/1/2018                                                     
 *  @author Mark Terry                                                  
 *  @Copyright © RootMeanSquare 2024 -->                               
 * 
 */ 


/{

Cmp
Cmp(A,B,condition,{1})
compares 2 arrays  using "<,>,==,,!=,>=,<=" operations
    delivers an integer array which contains indices - where the
    operation was TRUE - else first element is -1 for no valid comparison
optionally delivers integer array where elements are 0 or 1 depending on TRUE/FALSE of element comparison
e.g.
I=Cmp(A,B,"<=")
I=Cmp(A[::2],B[0::2],">")
I=Cmp(A,B,"!=",1)
scmp
scmp(w1,w2,{n},{case},{difference})
string compare of w1,w2 variables returns 1 if same 0 if different.
will compare up to n characters default all. 
If case set to zero a case independent match is made.
If difference set to 1 - return is as C routine strcmp.
If n is zero all the string is compared, else the first n characters.
if n less than zero the tails are compared for n elements.

/}


chkIn()



int I[5] = { 1,2,3,4,5 }

//int I[] = { 1,2,3,4,5}

<<"%V$I \n"

int J[5] = { 1,2,-3,8,9}

<<"%V$J \n"


       K = Cmp(I,J,"<")

<<"$K\n"

chkN(K[0],3)
chkN(K[1],4)

       K = Cmp(I,J,"<",1)

chkN(K[0],0)
chkN(K[3],1)

<<"$K\n"

       K = Cmp(I,J,"==",1)

<<"$K\n"
chkN(K[0],1)



V=vgen(INT_,60,0,1)

A3D= V

A3D.redimn(3,5,4)

<<"$A3D \n"

 iele = A3D[0][0][0];
 A3D.pinfo()
 <<"$iele \n"


chkN(A3D[0][0][0],0)

 iele = A3D[2][4][2];

 ChkN(iele,58)

 iele = A3D[2][3][2];

 ChkN(iele,54)


ans= ask("%V $A3D[2][3][2]  = $iele",0)

 chkN(A3D[2][4][3],59)  ; // TBF iele correct

B3D = A3D


ID=cmpArray(A3D,B3D,"==",1)

<<"$ID\n"

A3D[1][1][1] = 101;

A3D[2][2][2] = 202;

A3D[2][4][3] = 777;

ID=cmpArray(A3D,B3D,"==",1)

<<"$ID\n"

VID=cmpArray(A3D,B3D,"!=")

<<"$VID\n"



chkOut()