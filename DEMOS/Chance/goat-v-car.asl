//
//  MontyHall simulation
//
//  3 doors 2 goats one car

// step 1 make a choice
// step 2 they show you what is behind another door that has a goat
// step 3 do you change your first choice ?


// so the possibles at start
//  Door1  Door2 Door3
//  3 * 2 * 1

//   C     G1     G2
//   C     G2     G1
//   G1     C     G2
//   G2     C     G1
//   G1     G2     C
//   G2     G1     C

//   but G2 G1 same result


//  first choice -- you 1/3 or .333333 chance of getting car

//  strategy change 
//  lets say you choose a goat  .6666
//  if they then show you the other goat
//  then you swap choices you will pick the car


//  lets say you pick the car
//  then swap choice you will pick a goat
//  will happen 0.3333
/////////////////////////////////

//  strategy don't change --- thinking 50/50
//  ignore information
//  chose goat - keep goat   - happens 0.66667 of the time

//  choose car -- keep car - but that would only  happen 0.3333


 int Door[3];

 int success = 0;
 int success_keep = 0;
 int n_success = 0;
 int n_success_keep = 0; 
 // line up behind doors the two goats and the car randomly

 int p;
 
for (trys = 0; trys < 10000 ; trys++) {
// 1 is a goat and 2 is a car

   Door[0] =1;
   Door[1] =1;
   Door[2] =2;

// shuffle this array

//<<"$Door\n"

   //Shuffle(Door,1000,3)
   Shuffle(Door,100);
   
   //Door->Shuffle(1000)
//<<"$Door\n"



//  you choose Door
 pr = Urand(0);
 p = Round (pr * 3 +0.5);
// <<"$pr pick Door $p\n"

/{
 for (i = 0; i < 20; i++) {
 pr = Urand();
 p = Round (pr * 3 +0.5);
 <<"[${i}] $pr pick Door $p\n"
}
/}

 di = p-1;
// so strategy change

  if (Door[di] == 2) {
     success = 0;
  }
  else {
     success = 1;
     n_success++;
  }
// so strategy keep door

  if (Door[di] == 2) {
     success_keep = 1;
     n_success_keep++;     
  }
  else {
     success_keep = 0;
  }


<<"\r[${trys}] $Door[0] $Door[1] $Door[2] door $p %V $success $n_success $success_keep $n_success_keep"

}

 prb_s = n_success/ (1.0*trys);

 prb_sk = n_success_keep/ (1.0*trys);


<<"\n change_door ${prb_s}\%  keep_door ${prb_sk}\% \n"

setdebug(1)





