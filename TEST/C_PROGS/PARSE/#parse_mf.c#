#include <stdio.h>
#include <stdlib.h>

#define NACTS 10

enum actvities {

  SLEEP,
  WALK,
  HIKE,
  RUN,
  BIKE,
  SWIM,
  WTLIFT,

};

class Act {

 public:
  int type;
  float duration;

  int Get() { return type; };
  Act() {
    type = WALK;
    duration = 0.0;
    printf("act cons type %d\n",type);
  };

};

class Dil {

 public:
  int date;
  Act act[NACTS];

  void setAct(int i, int wt)
  {
    act[i].type = wt;
  };

  Dil() {
    printf("Dil Cons \n\n");
  };

};


int main (int argc, char **argv)
{
  int wt;

  Dil D[10];

  D[0].setAct(0,0);
 
  wt = D[0].act[0].Get();

  printf("Dil 0 act 0 is %d\n",wt);

  D[1].setAct(1,BIKE);

  wt = D[1].act[1].Get();

  printf("Dil 1 act 1 is %d\n",wt);


  D[2].setAct(2,SWIM);
  D[3].setAct(3,RUN);
  D[4].setAct(4,HIKE);
  D[5].setAct(100,HIKE);

  Dil *day;
  Act *actp;

  day = &D[2];

  wt = day++ -> act[2] . Get();

     printf("Dil 2 act 2 is %d\n",wt);
     // when does ++ happen ?
     wt = (day++)->act[3].Get();

     printf("Dil 3 act 3 is %d\n",wt);

  actp = &day->act[0];

  printf("\n");
  for (int i = 0; i <= NACTS+2; i++) {
    wt = (actp++)->Get();
    printf("Dil 4 act [%d] is %d\n",i,wt);
  }


}
