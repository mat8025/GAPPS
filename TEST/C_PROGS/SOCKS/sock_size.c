
#include <stdio.h>
#include<sys/socket.h>   
#include<arpa/inet.h> 

int main()
{
int n;
unsigned int m = sizeof(n);
int fdsocket;


 fdsocket = socket(AF_INET,SOCK_DGRAM,IPPROTO_UDP); // example
 getsockopt(fdsocket,SOL_SOCKET,SO_RCVBUF,(void *)&n, &m);

 printf("n %d m %d\n",n,m);

}
