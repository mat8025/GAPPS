#include <stdio.h>
#include <math.h>
#include "quasi.h"

char ans[128];

char *
quasi_rule(nsyll,pcon)
P_con pcon[];
{

char tans[64];
float dh;
int k;
int i;
int High_rise_syll = 0;
float pslope;
float pitch_ave;
int Lcon,Fcon;
float High_rise,High_rise_dur,Ldur,Fdur;
float Fave,Lave;
float Fslope;
int Q3_fire = 0;

/* find high_rise ave  etc */

	Lave = 0.0;
	Fave = 0.0;	
	Ldur = 0.0;
	Fdur = 0.0;		
	Lcon = P_RISE;
	Fcon = P_LEVEL;	
	High_rise = 0.0;

	for (i =0 ; i < nsyll; i++ ) {

	Lave = Fave ;
	Ldur = Fdur;
	
	Fave = pcon[i].ave;
	pslope = pcon[i].slope;
	Fdur = pcon[i].dur;

	if (pslope > High_rise) {
		High_rise = pslope;
		High_rise_dur = pcon[i].dur;
		High_rise_syll = i;
	}

	pitch_ave = pcon[nsyll].ave;
	Lcon = Fcon;
	Fcon = pcon[i].type;
	Fslope = pcon[i].slope;
dbprintf(1,"Ldur %f Fdur %f \n",Ldur,Fdur);
	}
	
	 strcpy(ans,"\0");

/* # rule 1 */

 if (nsyll == 1) {
	 if ( (Fcon == P_RISE) && (Fdur > 0.03) ) {
		 strcpy(ans,"Q1S");
 	 }

   }

 else {

	 if ( Fcon == P_RISE) {

dbprintf(1,"FCON RISE %f\n",Fdur);

	 	if (Fdur > 0.035) {
	 	      if (Fave > pitch_ave) {
			  strcpy(ans,"Q1_");
		       }
		      else if ( Fdur > 0.070 && Fslope > 40)
			  strcpy(ans,"Q1FR_");
		      else if ( Lcon == P_RISE && Ldur > 0.07)
			  strcpy(ans,"Q1RR_");
	        }

		else {

		if (Lcon == P_RISE) {

dbprintf(1,"LCON RISE dur %f\n",Ldur);

			if (Ldur > 0.10)  {
			  strcpy(ans,"Q1LR_");
		        }
			else if ( (Ldur+Fdur > 0.100) ) {
			  strcpy(ans,"Q1FLR_");
	        	}
	       }
	     }
        }


/* # rule 2 */

 if ( (Fcon == P_LEVEL || Fcon == P_CURVE 
 		|| Fcon == P_RACURVE || Fcon == P_RVCURVE 
 		|| Fcon == P_ODD || Fcon == P_FACURVE)
       && Lcon != P_FALL && (Ldur+Fdur > 0.06) && Fslope > 0) {

 dh = Fave - Lave;
 if (dh > 2) {
 strcat(ans,"Q2_");
 }
 }


/* # rule 3 */

 if ( (High_rise >= 100) && (High_rise_dur >= 0.150 ) 
       && (Fcon != P_FALL && (Fcon != P_ODD && Fcon != P_FVCURVE) ) 
       && Fdur >= 0.04) {
	 strcat(ans,"Q3");
	Q3_fire = 1;
 }
/* # rule 4 */


 if ( (Fcon == P_LEVEL || Fcon == P_RACURVE)
 	&& Fdur > .060 && Fave > pitch_ave) {
 dh = Fave - Lave;
 if (dh >= 6) {
 strcat(ans,"Q4");
 }
 }
}

       if ( Fcon == P_RACURVE) {
	 	if (Fdur > 0.070 && Fslope > 10) {
			  strcat(ans,"Q5FCU_");
	        }
        }


      if ( (Fcon == P_ODD || Fcon == P_RACURVE ) 
          && (Lcon == P_RISE || Lcon == P_RACURVE)) {
 	if ( Fave > pitch_ave && Fave > Lave ) {
			  strcat(ans,"Q6_");
	        }
        }
        
      if ( Fcon == P_RACURVE && Lcon == P_RACURVE) {
 	if ( Fave > pitch_ave && Fave > Lave ) {
			  strcat(ans,"Q7FLCU_");
	        }
        }       



 if (nsyll >= 3) {
	if ( (pcon[nsyll-1].ave > pcon[nsyll-2].ave ) 
	   && (pcon[nsyll-2].ave > pcon[nsyll-3].ave) )  {
	   	
	   if ( (Fcon == P_FALL || Fcon == P_FVCURVE) && Fdur > 0.070) 
		strcpy(ans,"SLF");
	   else if (Fdur > 0.030) /* more than three pitch samples */
		strcat(ans,"Q8AR_");
	}
     }


 if (nsyll > 3) {
	if ( (pcon[nsyll-1].ave < pcon[nsyll-2].ave ) 
	   && (pcon[nsyll-2].ave < pcon[nsyll-3].ave) )  {
	   	
	   if ( (Fcon != P_RISE && Fcon != P_RACURVE) 
	         && Fdur > 0.100 ) {
	         	if (Q3_fire) {
	         	   if (High_rise_syll < nsyll-2 ) 
			  strcpy(ans,"SAF");
			  else
			  strcat(ans,"SAF");
			}
			else
			  strcat(ans,"SAF");
			}
	}
     }


 if (nsyll <= 4) {
 	   if ( Fcon == P_RVCURVE ) {
		  strcpy(tans,ans);
 		  strcpy(ans,"SRP");
 		  strcat(ans,tans);		
	}
   }


  k = strlen(ans);
  if (k == 0)
  	strcpy(ans,"S1");
  else {
  	if (Fave > pitch_ave)
  		strcat(ans,"_PH");
  }


	strcpy(pcon[nsyll].rule,ans);
	if ( Q3_fire ) {
	pcon[nsyll].start_time = pcon[High_rise_syll].start_time;	
	pcon[nsyll].stop_time = pcon[High_rise_syll].stop_time;		
        }
	else {
	pcon[nsyll].start_time = pcon[nsyll-1].start_time;	
	pcon[nsyll].stop_time = pcon[nsyll-1].stop_time;				
        }

 	return (ans);
}

