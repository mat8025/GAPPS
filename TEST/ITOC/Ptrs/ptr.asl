
CheckIn()

proc add( a,b )
{
 c= a +b
<<"%V$c $a $b\n"
 a++
 b--
c= a +b
<<"%V$c $a $b\n"
}

int N = 30

<<" $(typeof(N)) $(sizeof(N)) \n"

intsz = sizeof(N)


int n = 79
a=3.14159

<<"%I $n\n"
<<"%V $n\n"

// copy of first arg -- siv ptr to second
dv=testargs(n,&n)

<<"%(1,,,\n)$dv \n"

dv=testargs(1,2,3,n,&n,&a)

<<"%(1,,,\n)$dv \n"

 add (5,6)

 x = 2
 y = 3
<<"%V $x $y \n"
 add (x,y)

ans=iread()

<<"%V $x $y \n"

add (&x,&y)

<<"%V $x $y \n"



int a_3 = 66

vn = "a_3"

k = $vn

$vn = 77

<<"%V$vn $k $a_3 \n"
// output is :-

//vn a_3 k 66 a_3 77 


exit()



ptr z = &x;

   z = 6;
<<"%V $(typeof(z)) $z $x\n"




int I[N]


 for(i = 0; i< N; i++) {
   I[i] = i
 } 

 I[0] = 0xcafebabe
 I[1] = 0xbabeface
 I[2] = 0xdeadbeef

 testargs(I, &I)

 testargs(I[3], &I[3])

 // get the mem address for the memory of a siv variable (number type )
 ma = memaddr(&n)

<<"ma %u $ma \n"

 memfill(ma,INT,80)

<<"%V $n  $(periodicName(n))\n"

 memfill(ma,INT,50)

<<"%V $n  $(periodicName(n))\n"


 memfill(ma,INT,80)

<<"%V $n  $(periodicName(n))\n"


 memfill(ma,INT,79)

<<"%V $n  $(periodicName(n))\n"



 memfill(ma,INT,47)

<<"%V $n  $(periodicName(n))\n"


 memfill(ma,INT,28)

<<"%V $n  $(periodicName(n))\n"

 ima = memaddr(&I[0])
<<"ima %u $ima \n"

 ma = memaddr(&I[1])
<<"ma %u $ma \n"
 ma = memaddr(&I[2])
<<"ma %u $ma \n"
 ma = memaddr(&I[3])
<<"ma %u $ma \n"
 memfill(ma,INT,0xa600ddeed)
 ma = memaddr(&I[4])
<<"ma %u $ma \n"


 memfill(ma,INT,0xace2face)

<<"%X $I[0] $I[1] $I[2] $I[3] $I[4] \n"
<<"\n OCTDUMP \n"
<<"%(4,, ,\n)%o$I[0:N-1] \n"


uchar C[4096]

 mad = memaddr(&C)
 mas = memaddr(&I[0])

 memcopy(mad,mas, (N * 4))

 ec = N * intsz -1
 <<"\n HEXDUMP \n"
 <<"%(8,, ,\n)%hx$C[0:ec] \n"

// <<"\n OCTDUMP \n"
// <<"%(4,, ,\n)%o$C[0:ec] \n"


stop!






int a[]
int b[]

//ptr d

// a[0:20:2] = 3


 a[0:20:2]->Set(3)

<<" $a \n"

 b[0:20:2]->Set(2,4)

<<"%v $b \n"

<<"%v $a \n"

<<" $(typeof(a)) \n"

   d = &a

<<" $(typeof(d)) \n"

<<" ptr %v $d \n"

 a[0:20:2]->Set(4,3)

<<" reset %v $a \n"

<<" ptr update %v $d \n"

 c = d 

<<" $c \n"

<<"%I $c \n $d \n"
<<"%v $c \n"

  d[0:20:2]->Set(5,3)


<<"%v $a \n"

<<"%v $d \n"

stop!



<<"%v $a \n"

<<"%v $d \n"

    d = &b

<<"%v $d \n"

;



