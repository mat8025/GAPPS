#include <stdio.h>
#include <fcntl.h>
#include <math.h>
#include "sp.h"
#include "quasi.h"

extern float pitch_stats[];
extern float Results[];

q_cep(in_buf,real,imag,fft_size,scale_factor,win_length,window,power,sf)
float in_buf[];
float real[];
float imag[];
float window[];
float scale_factor;
float *power;
float sf;
{
	int i;
	int j;
	float scale_factor2;
        float dH;
        int forstart, forend, forn;

	scale_factor2 = 2.0 * scale_factor;
	/* CLEAR  FFT ARRAYS */

	/* PAD ZEROS */

	for (i = 0; i < fft_size; i++) {
		imag[i] = 0.0;
		real[i] = 0.0;
	}


	/* LOAD REAL INPUT */

dbprintf(2,"load input  pad %d\n",fft_size -win_length);

	for (i = 0; i < win_length; i++) {
		real[i] = in_buf[i];
/*        dbprintf(1,"%d %f\n",i,in_buf[i]);  */
        }


	/* APPLY SMOOTHING WINDOW TO INPUT */
	dbprintf(2,"window input  %d\n",win_length);

	for (j = 0; j < win_length; j++) {
		real[j] *= window[j];
/*	dbprintf(1,"%d %f %f\n",j,real[j],window[j]);  */
        }

	/* FFT */
	dbprintf(2,"fft  %d\n",fft_size);

	gs_fft(real, imag, fft_size, 1);


	/* POWER SPECTRUM */

	for (i = 0; i < fft_size ; i++) {
		real[i] = ( real[i] * real[i] + imag[i] * imag[i])
		    * scale_factor;

	}

	*power = 0.0;

/* power for band 80 - 2500 Hz */

        dH = sf/(float) fft_size;
        forstart = (int) 80.0/dH;
        forend =  (int) 2500.0/dH;
        if (forend >= (fft_size/2))
                    forend = fft_size/2 -1;
        forn = forend - forstart;

	for (i = forstart; i <= forend ; i++) {
		*power += real[i];
	}

	if (*power > 0.0)
	*power =   10 * log10( *power/ (float) (forn) );
		else
	*power = -120.0;


	/* LOG POWER SPECTRUM */

	for (i = 0; i < fft_size/2 ; i++) {
		if (real[i] > 0.0)
			real[i] = log10 ((double) real[i]);
		else 
			real[i] = -120.0;
	}

	/* NOW FFT */

	for (i = 0; i < fft_size; i++) {
		imag[i] = 0.0;
	}

	gs_fft(real, imag, fft_size/2, 1);

	for (i = 0; i < fft_size/4 ; i++) {

	real[i] = (real[i] * real[i] + imag[i] * imag[i]) * scale_factor2;

/*      dbprintf(1,"ceps %d %f\n",i,real[i]);  */

	}
/* normalize */
	
        return 1;
}


q_pksort(results,n_peaks)
float results[];
int n_peaks;
{
	int sort_it;
	int k;
	float tmp;

	sort_it = 1;

	while(sort_it) {

		sort_it = 0;

		for (k= 0; k < n_peaks-1 ; k++) {

			if (results[k+n_peaks] < results[k+1+n_peaks]) {

				tmp = results[k];
				results[k] = results[k+1];
				results[k+1] = tmp;

				tmp = results[k+n_peaks];
				results[k+n_peaks] = results[k+1+n_peaks];
				results[k+1+n_peaks] = tmp;
				sort_it = 1;
			}

		}
	}
dbprintf(2, "pk1 %f pk2 %f pk3 %f: amp1 %f amp2 %f amp3 %f\n", Results[0], Results[1], Results[2],
				 Results[n_peaks], Results[n_peaks + 1], Results[n_peaks + 2]);
}

int
q_pickpeaks(float pam[],float results[],float cep_thres,float inc_thres,
int n_peaks,int start_at,int finish_at)
{
	float wt_thres;
	int pks_found = 0;
	int step_isp = -1;
	int isp;
	float pk_pos,pk_amp,pk_bw;
	int pk = 0;
	int k;
	float delta;
	int mode = 1;

	delta = 1.0;

	wt_thres = 0;

dbprintf(1,"pick n_peaks %d start_at %d finish_at %d\n",n_peaks,start_at,finish_at);
dbprintf(1,"cep_thres %f inc_thres %f\n",cep_thres,inc_thres);

	/* CLEAR RESULTS ARRAY */

	for (k= 0; k < (3* n_peaks) ; k++) {
		results[k] = 0.0;
	}

	for (isp = start_at ; isp != finish_at ; isp = isp + step_isp ) {

         wt_thres = (start_at - isp) * inc_thres; /* wt thres according to freq */

		if ((pam[isp-1] < pam[isp])
		    && (pam[isp] > pam[isp+1])  && pam[isp] > (cep_thres + wt_thres)) {

  dbprintf(1,"\n peak @ isp %d  %f  thres %f\n",isp,pam[isp],(cep_thres + wt_thres));

			/* PARABOLIC interpolation */

   parabolic_ip (pam[isp-1],pam[isp],pam[isp+1],
			    isp,delta,mode, &pk_pos,&pk_amp,&pk_bw);

			if (pk < n_peaks) {

			results[pk] = pk_pos;
			results[pk+n_peaks] = (pam[isp] - (cep_thres + wt_thres )) ;
			results[pk+2*n_peaks] = pk_bw;
				pk++;
 dbprintf(1,"ipk_pos found @ %f amp %f  %f %f \n",pk_pos,pam[isp],results[pk],results[pk+n_peaks]);

			}

			pks_found++;
			/* store num of peaks */
		}
	}

 if (pks_found > 1)
     dbprintf(1,"peaks found %d, amp %f %f %f\n",pks_found,results[n_peaks],results[n_peaks+1],results[n_peaks+2]);	

	return pks_found;
}



q_stats(the_pitch,old_pp,rave_pp,npm)
float the_pitch[];
float *old_pp,*rave_pp;
{

	int rppi;

	sp_stats(the_pitch,pitch_stats,npm);

	*old_pp = pitch_stats[1];

	if (npm >= 5) {
		rppi = npm - 5;
		sp_stats(&the_pitch[rppi],pitch_stats,5);
	}

	*rave_pp =pitch_stats[1];
dbprintf(2,"doing stats npm %d ave %f rave %f\n",npm,*old_pp,*rave_pp);
}



q_check_double(results,pitch0,pitch1,dp0,dp1,rave_pp,npm,dt)
float results[];
float *pitch0,*pitch1,*dp0,*dp1;
float rave_pp;
float dt;
{
	int doubling = 0;
	float p0,p1;

	p0 =  (float) ( (int) (1.0/ (results[0] * dt) +0.5)) ;
	p1 =  (float) ( (int) (1.0/ (results[1] * dt) +0.5)) ;

	*dp0 = fabs( p0 - rave_pp);
	*dp1 = fabs( p1 - rave_pp);

	if ( p0 > p1) {
		if (  fabs ( ( p0/ p1) -2.0) < 0.2 && npm >= 3)
			doubling = 1;
	}
	else {
		if ( fabs ( ( p1/ p0) -2.0) < 0.2 && npm >= 3)
			doubling = 1;
	}

	*pitch0 = p0;

	*pitch1 = p1;

	return doubling;
}


q_set_pitch(results,k,n_peaks,dt,new_pp,the_lag,the_amp)
float results[];
float dt;
float *new_pp,*the_lag,*the_amp;
{
	*new_pp = (float) ( (int) (1.0/ (results[k] * dt) +0.5)) ;
	*the_lag = results[k];
	*the_amp = results[n_peaks+k];
}


q_reject(new_pp,ave_pp,rave_pp,the_amp,npm)
float new_pp,ave_pp,rave_pp,the_amp;
{
	int a_reject =0;
	static int n_reject = 0;

	if ( ( ( new_pp > (1.3 * rave_pp) && new_pp > (1.3 * ave_pp) )
	    || (new_pp < (rave_pp * 0.6) && new_pp < (ave_pp * 0.6) ) ) 
	    && (npm > 15 ) && the_amp < 4) {
	
		n_reject++;

dbprintf(2,"POSSIBLE reject %d  %d rejects allowed\n",n_reject,a_reject);
	
	        if (the_amp < 2.0) {
dbprintf(2,"REJECT by AMP new_pp %f rave_pp %f the_amp %f \n",new_pp,rave_pp,the_amp);	        	
		   return 1;
	        }

		if ( n_reject > a_reject ) { /* reject  ? */
dbprintf(2,"REJECT new_pp %f rave_pp %f the_amp %f \n",new_pp,rave_pp,the_amp);
			return 1;
		}
	}
	return 0;
}



q_adapt_wl(window,new_pp,win_length,sf,old_wl)
float window[];
float new_pp;
float sf;
int *win_length;
int old_wl;
{
	static int s_to_hf = 0;
	float frame_length = 0.044;

	
	if (new_pp < 50.0)
		return;

	if (new_pp > 400.0 ) {
		s_to_hf++;
		if (s_to_hf > 2)
			frame_length = .018;
	      }
	else if (new_pp > 300.0 && new_pp < 400) {
		s_to_hf++;
		if (s_to_hf > 2)
			frame_length = .024;
	}
	else if (new_pp > 200.0 && new_pp < 300.0 ) {
		s_to_hf++;

		if (s_to_hf > 2)
			frame_length = .032;

	}
	else if (new_pp > 100.0 && new_pp < 200.0 ) {
		frame_length = .044;
		s_to_hf = 0;
	}
	else {
		frame_length = .050;
		s_to_hf = 0;
	}

	*win_length = (int) (sf * frame_length +0.5) ;

	if (*win_length != old_wl) {
dbprintf(1,"switch to frame length %f wl %d\n",frame_length,*win_length);
		gs_window("Hanning",*win_length,window);
	}

}


q_pitch_track(results,the_pitch,power,pow_thres,min_pow_thres,n_peaks,dt,time)
float results[];
float the_pitch[];
float power,pow_thres,min_pow_thres,dt,time;
int n_peaks;
{
	static int npm = 0;
	float old_pp,rave_pp;
	float new_pp,the_amp,the_lag;
	float pitch0,pitch1,dp0,dp1;
	float damp_f = 0.75;
	int doubling = 0;
	int reject_it = 0;
	float p_thres;
	float d_pow;
	float alt_pp = 0.0;
	float alt_pp_amp = 0.0;

	the_amp = 0.0;
	new_pp = 0.0;
	the_lag = -1.0;
	p_thres = 0.25;


dbprintf(2,"in pitch track power %f pow_thres %f pk_amp %f\n",power,p_thres,results[n_peaks]);

	if ( (results[n_peaks] > p_thres) ) {

/* GET PITCH STATS */

		if ( npm > 3) {
			q_stats(the_pitch,&old_pp,&rave_pp,npm);
		}
		else {
			old_pp = results[0];
		}


		if ( results[n_peaks+1] == 0.0) {
 q_set_pitch(results,0,n_peaks,dt,&new_pp,&the_lag,&the_amp);
			dbprintf(2,"chose SOLE peak %f\n",new_pp);
		}

		else {

doubling = q_check_double(results,&pitch0,&pitch1,&dp0,&dp1,rave_pp,npm,dt);

dbprintf(2,"Hz1 %f Hz2 %f ave_hz %f rave %f npm %d \n", pitch0, pitch1,old_pp, rave_pp, npm );

			if (  doubling ) {

dbprintf(2,"possible doubling or subharmonic chose closest to ave pitch\n");

		if ( (fabs(rave_pp - pitch1) < fabs(rave_pp - pitch0) ))  {
	q_set_pitch(results,1,n_peaks,dt,&new_pp,&the_lag,&the_amp);
					alt_pp = pitch0;
					/* closest in freq */
					alt_pp_amp = results[n_peaks];
			        }
				else {
		q_set_pitch(results,0,n_peaks,dt,&new_pp,&the_lag,&the_amp);
					alt_pp = pitch1;
					alt_pp_amp = results[n_peaks+1];
				}
			}

else if  (  (dp1 < dp0)  && (results[n_peaks] < (1.5 * results[n_peaks + 1]) )) { /* chose closest to rave if amps similar */
  q_set_pitch(results,1,n_peaks,dt,&new_pp,&the_lag,&the_amp);
  dbprintf(2,"chose %f closest to ave %f  npm %d\n",new_pp,rave_pp,npm);
					alt_pp = pitch0;
					alt_pp_amp = results[n_peaks];
			}

			else { /* chose highest (lowest freq ) & strongest */
	q_set_pitch(results,0,n_peaks,dt,&new_pp,&the_lag,&the_amp);
	dbprintf(2,"chose strongest %f  npm %d\n",new_pp, npm);
					alt_pp = pitch1;
					alt_pp_amp = results[n_peaks+1];
			}
		}


/* REJECT CANDIDATE PITCH ? */

	reject_it = q_reject(new_pp,old_pp,rave_pp,the_amp,npm);

		if (reject_it) {
dbprintf(1,"REJECT new_pp %f rave_pp %f the_amp %f @ %4.2f\n",new_pp,rave_pp,the_amp,time);
			results[0] = -2;
			results[1] = -1;
			alt_pp = new_pp;
			alt_pp_amp = the_amp;
		}
		else {
/* if persistant - new valid pitch? */
/* damp pitch change */
/*		
			if (npm > 15)
			new_pp = ((new_pp -rave_pp) * damp_f) + rave_pp;
*/

			results[0] = new_pp;
			results[1] = the_lag;
			the_pitch[ npm] = new_pp;
			npm++;
		}
	}
	else {
		results[0] = 0.0;
		results[1] = -1.0 ;
	}

	results[3] = the_amp;
	results[4] = results[0];
	results[5] = alt_pp;
	results[6] = alt_pp_amp;

dbprintf(2,"THE_HZ is %4.1f %3.2f %4.1f %3.2f\n",results[0],results[1],alt_pp,alt_pp_amp);
dbprintf(2, "res4 %f res5 %f amp0 %f amp1 %f\n", Results[4], Results[5], Results[3], Results[6]);
}

