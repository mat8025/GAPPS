///
///
///



//////////////////////////////// compile following script /////////////////////



int N = 47;
int Vec[50];


int a =1;
int b= 0;
int t;
int i;

 for (j=0; j < 47; j++) {
    a= 1;
    b= 0;
    for (i=0; i<N;i++) {

       Vec[i] = b;
       t = a;
       a = t + b;
       b = t;
       //printf('%d %d\n',i,b);
    }

//<<"$Vec \n"

  printf('%d\n',Vec[j]);

  }


//////////////////////////////////////////////////