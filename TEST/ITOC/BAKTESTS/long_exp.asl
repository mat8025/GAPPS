


rpmc = 1.0/60;
rpm = 0.0166667
<<"%V $rpm $rpmc\n"

w_rate = 397.0 * rpm
h_rate = 477.0 * rpm
c_rate = 636.0 * rpm
run_rate = 795.0 * rpm
wex_rate = 350.0 * rpm
swim_rate = 477.0 * rpm
yard_rate =  318.3 *rpm


walk = 10
hike = 0;
run = 0;
cycle = 0;

swim = 10;
yardwrk = 0
wex = 0;


checkIn()

  exer_burn =   (walk * w_rate + hike * h_rate + run * run_rate + cycle * c_rate)
<<"%V $exer_burn \n"

  exer_burn +=	 (swim * swim_rate + yardwrk * yard_rate + wex * wex_rate)


<<"%V $exer_burn \n"

cycle = 10
wex =10

  exer_burn =   (walk * w_rate + hike * h_rate + run * run_rate + cycle * c_rate)
<<"%V $exer_burn \n"

  exer_burn +=	 (swim * swim_rate + yardwrk * yard_rate + wex * wex_rate)


<<"%V $exer_burn \n"


run = 10
yardwrk  =10

  exer_burn =   (walk * w_rate + hike * h_rate + run * run_rate + cycle * c_rate)
<<"%V $exer_burn \n"

  exer_burn +=	 (swim * swim_rate + yardwrk * yard_rate + wex * wex_rate)


<<"%V $exer_burn \n"

hike = 20;

 ans= 654.551309 

 exer_burn =   (walk * w_rate + hike * h_rate + run * run_rate + cycle * c_rate)
<<"%V $exer_burn \n"

  exer_burn +=	 (swim * swim_rate + yardwrk * yard_rate + wex * wex_rate)

checkFnum(exer_burn,ans)
<<"%V $exer_burn \n"



 exer_burn =   (walk * w_rate + hike * h_rate + run * run_rate + cycle * c_rate + swim * swim_rate + yardwrk * yard_rate + wex * wex_rate)


<<"%V $exer_burn \n"
checkFnum(exer_burn,ans)

 exer_burn =   walk * w_rate + hike * h_rate + run * run_rate + cycle * c_rate + swim * swim_rate + yardwrk * yard_rate + wex * wex_rate;


<<"%V $exer_burn \n"
checkFnum(exer_burn,ans)

 exer_burn =   (walk * w_rate + hike * h_rate + run * run_rate + cycle * c_rate \
                        + swim * swim_rate + yardwrk * yard_rate + wex * wex_rate)


<<"%V $exer_burn \n"

checkFnum(exer_burn,ans)

 exer_burn =   walk * w_rate; 
   exer_burn += hike * h_rate
   exer_burn += run * run_rate
   exer_burn +=  cycle * c_rate
   exer_burn += swim * swim_rate
   exer_burn += yardwrk * yard_rate
   exer_burn += wex * wex_rate

<<"%V $exer_burn \n"

checkFnum(exer_burn,ans)



checkOut()