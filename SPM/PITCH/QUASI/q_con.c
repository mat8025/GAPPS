#include <stdio.h>
#include <math.h>
#include "quasi.h"

/*
 * using pitch track count syllables and classify
 */
#define MAXPITCHBUF 8192
#if 0				/* This doesn't work */
extern float    Min_pitch_duration;
extern float    Max_pitch_gap;
extern float   *spsbuffer;
#else
/* This may not be the correct thing (these have no initialisers) but at
 * least it'll compile now.
 *	-- Aaron 1998-05-27
 */
float    Min_pitch_duration;
float    Max_pitch_gap;
float   *spsbuffer;
#endif

float Speech_gap = 0.040;
float Pre_Speech_gap = 0.100;

float
btg(buffer, k, span)
	float           buffer[];
{
	float           hz = 0.0;
	float           hz1, hz2;
	int             i, j;
	hz1 = hz2 = 0.0;
	j = 0;
	/* dbprintf(0,"btg ? k %d  span %d\n",k,span); */
	for (i = k + 1; i < k + span; i++) {
		j++;
		if (buffer[i] > 0) {
			hz1 = buffer[i];
			break;
		}
	}

	j = span - j;

	for (i = k - 1; i > k - j; i--) {
		if (buffer[i] > 0) {
			hz2 = buffer[i];
			break;
		}
	}

	if (hz1 > 0.0 && hz2 > 0.0) {
		hz = (hz1 + hz2) / 2.0;
		dbprintf(0, "btg k %d j %d \n", k, j);
	}
	return hz;
}

check_speech_gap(buffer,k,end,durn,fr_shift)
float buffer[];
float durn;
float fr_shift;
{
int i, dn;
/* how long */
      dn = (int) (durn/fr_shift + 0.5);
      if (k+dn > end)
          return 0;
      for (i= k; i< k+dn; i++) {
      if (buffer[i] > 0) return 0;
      }
      return 1;
}

check_speech_duration(buffer,k,end)
float buffer[];
{
int i, dn;
/* how long */
      for (i= k; i< end; i++) {
      if (buffer[i] <= 0.0) return (i-k);
      }
      return (i-k);
}

check_segment_durn(buffer,k,end,durn,fr_shift)
float buffer[];
float durn;
float fr_shift;
{
int i, dn;
/* how long */
      dn = (int) (durn/fr_shift + 0.5);
      if (k+dn > end)
          return 0;
      for (i= k; i< k+dn; i++) {
      if (buffer[i] <=0) return 0;
      }
      return 1;
}

check_presegment_durn(buffer,k,durn,fr_shift)
float buffer[];
float durn;
float fr_shift;
{
int i, dn;
/* how long */
      dn = (int) (durn/fr_shift + 0.5);
      if (k-dn <= 0)
          return 0;
      for (i= k; i> k-dn; i--) {
      if (buffer[i] <=0) return 0;
      }
      return 1;
}


c_pcon(buffer, n, pcon, fr_shift, fp)
	float           buffer[];
	P_con           pcon[];
	float           fr_shift;
	FILE           *fp;
{

	int             k, j, jj;
	float           hz;
	int             on = 0;
	float           pitch[MAXPITCHBUF];
	float           xpitch[MAXPITCHBUF];
	float           stats[100];
	float           yconst, pslope, siga, sigb, chi2, Q;
	float           start_time, stop_time;
	int             nps, tot_ps;
	int             n_syll = 0;
	float           pitch_ave;
	float           pave;
	int             napi, nap;
	int             kk;
	int             shape;
	int             span;
	int             sil_break, pitch_break;

	span = (int) (Max_pitch_gap / fr_shift);

	pitch_ave = 0.0;
	on = 0;
	nps = 0;
	tot_ps = 0;

	for (k = 0; k < n; k++) {

		hz = buffer[k];
        if (k > n -3)
		dbprintf(1, "k %d hz %f\n", k, hz);

		/* fill hole */
		if (hz == 0.0 && k > span) {
			hz = btg(buffer, k, span);
		}
		if (hz > 0) {

			if (!on)
				start_time = k * fr_shift;
			on = 1;
			pitch[nps] = hz;
			xpitch[nps] = (float) nps *fr_shift;
			nps++;
		}

		if (hz == 0.0 || k == n - 1) {

			on = 0;

			if ((nps * fr_shift) < Min_pitch_duration) {
				if (nps > 0)
	dbprintf(1, "skipping pitch segment too small ? %f\n", nps * fr_shift);
			} else {
				/* call this significant pitch segment */

				for (j = 0; j < nps; j++)
					pitch_ave += pitch[j];

				tot_ps += nps;

				stop_time = k * fr_shift;
				pcon[n_syll].start_time = start_time;
				pcon[n_syll].stop_time = stop_time;

				/*
				 * determine by looking at sps_buffer
				 * non-voiced edges around pitch segment
				 */

				pcon[n_syll].sp_start_time = start_time;
				pcon[n_syll].sp_stop_time = stop_time;

dbprintf(0, "k %d nps %d Hz %f %f\n", k, nps, buffer[k], buffer[k - nps]);

		find_sp_start(buffer, n, &pcon[n_syll], k, nps, fr_shift);

		find_sp_stop(buffer, n, &pcon[n_syll], k, nps, fr_shift);

				dbprintf(1, "pitch item nps %d\n", nps);

				pcon[n_syll].nps = nps;
				pcon[n_syll].dur = nps * fr_shift;

				/* BEGIN MID & END PITCH */

				nap = nps / 3;

				if (nap < 3)
					nap = 3;

				if (nap > 4)
					nap = 4;

				pave = 0.0;

				for (kk = 0; kk < nap; kk++)
					pave += pitch[kk];

				pave = pave / (float) nap;
				dbprintf(0, "pave %f nap %d n_syll %d\n", pave, nap, n_syll);
				pcon[n_syll].p_begin = pave;

				pave = 0.0;
				napi = nps / 2 - nap / 2;

				for (kk = 1; kk <= nap; kk++)
					pave += pitch[napi + kk];

				pave = pave / (float) nap;
				dbprintf(0, "pave %f nap %d napi %d\n", pave, nap, napi);
				pcon[n_syll].p_mid = pave;

				pave = 0.0;

				for (kk = 1; kk <= nap; kk++)
					pave += pitch[nps - kk];

				pave = pave / (float) nap;

				pcon[n_syll].p_end = pave;

dbprintf(1, "end pitch %f %f %f %f \n", pitch[nps - 4], pitch[nps - 2], pitch[nps - 1], pcon[n_syll].p_end);

				/* GET STATS */
				sp_stats(pitch, stats, nps);


				pcon[n_syll].ave = stats[1];
				pcon[n_syll].sd = stats[4];
				pcon[n_syll].min = stats[5];
				pcon[n_syll].max = stats[6];

				dbprintf(1, "pitch item max %f\n", pcon[n_syll].max);
				dbprintf(1, "pitch item ave %f\n", pcon[n_syll].ave);
				/* GET SLOPE */

				yconst = 0.0;
				pslope = 0.0;
				chi2 = 0.0;

	sp_lfit(xpitch, pitch, nps, pitch, 0, &yconst, &pslope, &siga, &sigb, &chi2, &Q);


				pcon[n_syll].slope = pslope;
				pcon[n_syll].pconst = yconst;

				dbprintf(1, "pitch item pslope %f\n", pcon[n_syll].slope);

				if (chi2 > 0.0 && nps > 2)
					chi2 = sqrt(chi2 / (float) (nps - 2));

				if (fp != NULL) {
					pcon_info(fp, &pcon[n_syll], chi2);
				}
				r_shape(&pitch[0], &pcon[n_syll], fr_shift, pslope, chi2, fp);


				dbprintf(1, "pitch item %d type %d @psample %d %d\n",
					 n_syll, pcon[n_syll].type, k, n);

				n_syll++;

/* if add non-pitch then increment n_syll and add non-pitch segment here */


			}
			nps = 0;
		}
	}

	if (tot_ps > 0)
		pitch_ave = pitch_ave / (float) tot_ps;
	else
		pitch_ave = 0.0;

	pcon[n_syll].ave = pitch_ave;

	dbprintf(1, "pitch ave %f\n", pitch_ave);

	return n_syll;
}


/* concave or convex shape : fall or rise detector */

r_shape(pitch, pcon, dt, pslope, chi2, fp)
	float           pitch[];
	P_con          *pcon;
	float           dt;
	float           pslope;
	float           chi2;
	FILE           *fp;
{
	int             above, below;
	float           slope;
	float           b;
	int             i;
	dbprintf(1, "r_shape %f\n", dt);
	above = below = 0;
	/* are majority of points above line connecting beg & end */

	slope = (pcon->p_end - pcon->p_begin) / (pcon->nps * dt);
	if (chi2 > 4) {
		for (i = 0; i < pcon->nps; i++) {
			if (pitch[i] > (pcon->p_begin + (i * dt * slope))) {
				above++;
			} else {
				below++;
			}

		}

		if (above > below) {
			/* CONVEX */
			if (pcon->slope > 1.0)
				pcon->type = P_RVCURVE;
			else
				pcon->type = P_FVCURVE;

		} else {
			/* CONCAVE */
			if (pcon->slope > 1.0)
				pcon->type = P_RACURVE;
			else
				pcon->type = P_FACURVE;
		}


		if (fp != NULL) {
			switch (pcon->type) {

			case P_FVCURVE:
				fprintf(fp, "contour FV_CURVE\n");
				break;
			case P_FACURVE:
				fprintf(fp, "contour FA_CURVE\n");
				break;
			case P_RACURVE:
				fprintf(fp, "contour RA_CURVE\n");
				break;
			case P_RVCURVE:
				fprintf(fp, "contour RV_CURVE\n");
				break;
			}
		}
	} else if ((pslope > 150.0 || pslope < -150.0)
		   && pcon->nps < 10 && chi2 > 2.0) {	/* fit unreliable
							 * neutral ? */
		if (fp != NULL)
			fprintf(fp, "contour ODD\n");
		pcon->type = P_ODD;
	} else if (pslope > (4.0)
		   && (((pcon->p_mid + pcon->p_end) / 2.0
			- pcon->p_begin) > 0.0)) {

		if (fp != NULL)
			fprintf(fp, "contour RISE\n");

		pcon->type = P_RISE;
	} else if (pslope < -35.0 && (pcon->dur > 0.04)
		   && (((pcon->p_begin + pcon->p_mid) / 2.0
			- pcon->p_end) > 1.0)) {
		if (fp != NULL)
			fprintf(fp, "contour FALL\n");

		pcon->type = P_FALL;
	} else {

		if (fp != NULL)
			fprintf(fp, "contour LEVEL\n");

		pcon->type = P_LEVEL;
	}
}

find_sp_start(buffer, n, pcon, k, nps, fr_shift)
	P_con          *pcon;
	float           fr_shift;
	float           buffer[];
{
	int             sil_break = 0;
	int             pitch_break = 0;
	int             jj;

	for (jj = k - nps - 2; jj > 3; jj--) {

	if (check_speech_gap(spsbuffer,jj,n,Pre_Speech_gap,fr_shift)) {
			sil_break = jj;
                        break;
		}

	if (check_presegment_durn(buffer,jj,Min_pitch_duration,fr_shift)) {
dbprintf(0, "pbreak start jj %d sps %f Hz %f\n", jj, spsbuffer[jj], buffer[jj]);
		pitch_break = jj;
			break;
		}
	}

	if (pitch_break) {
/* 3/4 instead 1/2 */
		jj = (k - nps - 2) - ( 3*((k - nps - 2) - pitch_break) / 4.0);
		pcon->sp_start_time = jj * fr_shift;
	} 
        else
		pcon->sp_start_time =  fr_shift;

        if (sil_break) {
pcon->sp_start_time = (sil_break )  * fr_shift + Pre_Speech_gap -0.01;
dbprintf(0," sil_break sp_start %d % time %f\n",sil_break,pcon->sp_start_time);
	}
}


find_sp_stop(buffer, n, pcon, k, nps, fr_shift)
	P_con          *pcon;
	float           fr_shift;
	float           buffer[];
{
	int             sil_break = 0;
	int             pitch_break = 0;
	int             jj;
        int             first_sbreak = 0;
        int             first= 1;
        int             fsgap = 0;
        int             sd = 0;
/* first find next pitch segment */
dbprintf(0, "check for speech end after %d \n", k);
	for (jj = k + 1; jj < n; jj++) {

        if ( !fsgap )
	if (check_speech_gap(spsbuffer,jj,n,Speech_gap,fr_shift)) {
dbprintf(0, "speech gap stop jj %d sps %f Hz %f\n", jj, spsbuffer[jj], buffer[jj]);
		sil_break = jj + 1;
	if (check_speech_gap(spsbuffer,jj,n,0.250,fr_shift)) 
                break;
                fsgap = 1;
                if (first) {
		  first_sbreak = sil_break;
                  first = 0;
		}

        }

        if (spsbuffer[jj] > 0.0) {
                 if (fsgap) {
                   sd=check_speech_duration(spsbuffer,jj,n);
                 if ((sd * fr_shift) > 0.300) break;
		 }
	           fsgap = 0;
		 }

	if (check_segment_durn(buffer,jj,n,Min_pitch_duration,fr_shift)) {
dbprintf(0, "jj %d sps %f Hz %f\n", jj, spsbuffer[jj], buffer[jj]);
			pitch_break = jj + 1;
			break;
		}
	}

	if (pitch_break) {
		pcon->sp_stop_time = (3*(pitch_break -k)/ 4.0 + k) * fr_shift;
	} else 
		pcon->sp_stop_time = n * fr_shift;

        if (sil_break) {
		pcon->sp_stop_time = sil_break * fr_shift + 0.05;
	} /* that is immediate preceeding non-speech */

}

pcon_info(fp, pcon, chi2)
	FILE           *fp;
	P_con          *pcon;
	float           chi2;
{
	fprintf(fp, "nps %d\n", pcon->nps);
	fprintf(fp, "start %f\n", pcon->start_time);
	fprintf(fp, "stop %f\n", pcon->stop_time);
	fprintf(fp, "sp_start %f\n", pcon->sp_start_time);
	fprintf(fp, "sp_stop %f\n", pcon->sp_stop_time);
	fprintf(fp, "dur %f\n", pcon->dur);
	fprintf(fp, "begin %f\n", pcon->p_begin);
	fprintf(fp, "mid %f\n", pcon->p_mid);
	fprintf(fp, "end %f\n", pcon->p_end);
	fprintf(fp, "ave %f\n", pcon->ave);
	fprintf(fp, "sd %f\n", pcon->sd);
	fprintf(fp, "min %f\n", pcon->min);
	fprintf(fp, "max %f\n", pcon->max);
	fprintf(fp, "slope %f\n", pcon->slope);
	fprintf(fp, "yconst %f\n", pcon->pconst);
	fprintf(fp, "chi2 %f\n", chi2);
}
