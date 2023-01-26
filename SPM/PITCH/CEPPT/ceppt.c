static char     rcsid[] = "$Id: ceppt.c,v 1.1 2000/01/29 17:18:13 mark Exp $";
/*
 * cepstrum based pitch-tracker			Mark Terry
 */
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <math.h>
#include "defs.h"
#include "df.h"
#include "sp.h"
#include "trap.h"

#define FORWARD 1
#define BACKWARD -1
#define NO_SCALING 0
#define MAXDS 256000
#define MAXEN 4000

// upgrade? to ceppt.cpp ? 1/25/2023



float     P_AVE_SECS = 2.0;
int             debug = -1;

float           Max_Hz_delta_pc = 20.0;
float           pitch_stats[24];
int             H[1000];
short           Vox[2 * MAXDS];
float           Ener[MAXEN];
float           Zx[MAXEN];
float           F0[MAXEN];
float           Spec[1024];
float           Results[2048];
float           In_buf[16 * 2048];
float           Window[2048];
float           Real[2048], Imag[2048];
float           Hp[3000];
float           Fp1[MAXEN];
float           Fp2[MAXEN];
float           Spp[MAXEN];
float           Rpp[MAXEN];
float           C_ave[20];
float           the_pitch[8192];

float           Min_pitch_duration = 0.050;
float           Max_pitch_gap = 0.050;
float           start_value, max_rms, min_rms;
float           cep_thres = 0.0;
float           pow_thres = 60.0;
float           min_pow_thres = 50.0;
float           a_pow_thres = 48.0;
float           sf = 16000.0;
float           frame_length = 0.040;
float           frame_shift = 0.010;
float           scale_factor, scale_factor2;
float           wt_thres, inc_thres;
float           off_time;
float           ph_interval;

int             n_peaks = 5;
int             fft_size = 512;
int             win_shift = 128;
int             win_length = 256;
int             old_wl;
int             start_at = 0;
int             finish_at = 0;
int             smooth = 0;
int             adapt_wl = 0;
int             n_rejects = 0;
int             n_frames;

int             i_flag_set = 0;
int             o_flag_set = 0;
int             p_flag_set = 0;
int             ph_flag_set = 0;
int             n_lag;
int             do_pwr_thres = 1;
int             auto_pwr_thres = 1;


data_file       o_df, o_pt, o_ph, i_df, o_spt;
channel         o_chn, i_chn[8];

int q_pickpeaks(float pam[],float results[],float cep_thres,float inc_thres,
int n_peaks,int start_at,int finish_at);


float
hz_double(hz)
	float           hz;
{
	float           hz2;
	hz2 = 2.0 * hz;
	dbprintf(1, " double pitch? %4.2f %4.2f \n", hz, hz2);
	return hz2;
}


/*
 * chose closest of hz0,hz1 to last_pp and ave and rave pitches
 * accept_hz_delta will widen as non_pitch segement lengthens
 */

float
choose_one(hz0, hz1, ave_pp, rave_pp, last_pp, contin, accept_hz_delta)
	float           hz0, hz1, ave_pp, rave_pp, last_pp, accept_hz_delta;
{
	float           new_pp = 0.0;
	float           dp0, dp1, d2p0;
	float           lp0, lp1, l2p0, hz_2;
	float           delta_hz0, delta_hz1;
	float           delta0, delta1;

	delta_hz0 = fabs(hz0 - last_pp);
	delta_hz1 = fabs(hz1 - last_pp);

	dp0 = fabs(hz0 - ave_pp);
	dp1 = fabs(hz1 - ave_pp);

	lp0 = fabs(hz0 - rave_pp);
	lp1 = fabs(hz1 - rave_pp);

	/*
	 * hz_2 = 2 * hz0; d2p0 = fabs(hz_2 - ave_pp); l2p0 = fabs(hz_2 -
	 * rave_pp);
	 */

	if (contin) {
		delta0 = delta_hz0;
		delta1 = delta_hz1;
	} else {
		delta0 = lp0 + dp0;
		delta1 = lp1 + dp1;
	}


	if (delta0 < delta1) {
		/* hz0 is closest */
		if (delta_hz0 < accept_hz_delta) {
			new_pp = hz0;
			dbprintf(2, "ACCEPT  HZ0 %f REJECT %f\n", new_pp, hz1);
		}
	} else {
		if (delta_hz1 < accept_hz_delta) {
			new_pp = hz1;
			dbprintf(2, "ACCEPT  HZ1 %f REJECT hz0 %f\n", new_pp, hz0);
		}
	}


	if (new_pp == 0.0) {
		dbprintf(2, "REJECT both %f %f last_pp %f\n", hz0, hz1, last_pp);
		dbprintf(2, "lp0 %f lp1 %f ahz_delta %f \n", lp0, lp1, accept_hz_delta);
		dbprintf(2, "dp0 %f dp1 %f rave %f\n", dp0, dp1, rave_pp);
	}
	return new_pp;
}


float
track_hz(hz, ave_pp, rave_pp, last_pp, accept_hz_delta, contin)
	float           hz, ave_pp, rave_pp, last_pp, accept_hz_delta;
{
	float           new_pp = 0.0;
	float           dp0, d2p0;
	float           lp0, l2p0, hz_2;
	float           ppr, delta_hz;
	float           max_hz_delta;

	delta_hz = fabs(hz - last_pp);

	if (contin) {
		if (delta_hz > accept_hz_delta) {
        dbprintf(2, "REJECT track_Hz %f delta too large  %f  %f \n", hz, delta_hz, max_hz_delta);
			return 0.0;
		}
	}
	ppr = ave_pp / 2.2;
	hz_2 = 2 * hz;

	dp0 = fabs(hz - ave_pp);

	d2p0 = fabs(hz_2 - ave_pp);

	lp0 = fabs(hz - rave_pp);

	l2p0 = fabs(hz_2 - rave_pp);


	if (delta_hz < accept_hz_delta)
		new_pp = hz;
	else if ((lp0 < accept_hz_delta) || (dp0 < accept_hz_delta))
		new_pp = hz;
	else if (rave_pp == 0.0)
		new_pp = hz;	/* first guess */

	if (new_pp == 0.0) {
	dbprintf(2, "REJECT %f dh %f ahd %f contin %d\n", hz, delta_hz, accept_hz_delta, contin);
		dbprintf(2, "rave %f lp0 %f dp0 %f\n", rave_pp, lp0, dp0);
	}
	return new_pp;
}



adjust_hz_delta(accept_hz_delta, ave_pp, contin)
	float          *accept_hz_delta;
	float           ave_pp;
{
	float           max_pitch_jump;
	float           min_pitch_jump;
	max_pitch_jump = ave_pp * Max_Hz_delta_pc / 100.0;
	min_pitch_jump = max_pitch_jump / 2.0;

	if (contin) {
		if (*accept_hz_delta > max_pitch_jump)
			*accept_hz_delta = max_pitch_jump;
		*accept_hz_delta *= 0.95;
		if (*accept_hz_delta < min_pitch_jump) {
			*accept_hz_delta = min_pitch_jump;
		}
	} else {
		*accept_hz_delta *= 1.2;
		if (*accept_hz_delta > ave_pp ) {
			*accept_hz_delta = ave_pp ;
		}
	}

}


/* check pcon.c for better routine */
fill_hole(pa, spi, loop)
	float           pa[];
{
	float           hz;
	hz = pa[spi];
	if (hz == 0.0 && spi > 1 && spi < loop - 3) {
		/* fill hole ? */
		if (pa[spi - 1] > 0.0
		    && pa[spi + 1] > 0.0
		    && pa[spi + 2] > 0.0) {
			hz = (pa[spi - 1] + pa[spi + 1]) / 2.0;
			pa[spi] = hz;
		} else if (pa[spi + 2] > 0.0
			   && pa[spi - 1] > 0.0
			   && pa[spi + 3] > 0.0
			   && pa[spi + 4] > 0.0) {
			hz = (pa[spi - 1] + pa[spi + 2]) / 2.0;
			pa[spi] = hz;
		}
	}
}

btg(buffer, k, span)
	float           buffer[];
{
	float           hz;
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
		/* dbprintf(0, "btg k %d j %d \n", k, j); */
		buffer[k] = hz;
	}
}


compute_ener_zx(nfpc, frame_shift, sf, ener_win)
	int             nfpc;
	float           frame_shift;
	float           sf;
	int             ener_win;
{
	int             loop = 0;
	int             nf;
	int             vp;
	int             i;
	float           R0;
	float           rms;
	int             j;

	for (nf = 0; nf < nfpc; nf++) {

		vp = (int) (loop * frame_shift * sf + 0.5);

		for (j = 0; j < ener_win; j++)
			In_buf[j] = (float) Vox[vp++];

		R0 = 0.0;

		for (i = 0; i < ener_win; i++) {
			rms = In_buf[i];
			R0 += rms * rms;
		}

		/*
		 * dbprintf(0,"loop %d ener %f %f %d
		 * \n",loop,R0,In_buf[0],ener_win);
		 */

		if (R0 <= 0.0) {
			rms = 0.0;
		} 
                else {
			R0 = sqrt((double) (R0 / (ener_win * 1.0)));
			rms = 20 * log10(R0);
		}
		/* ZC */

		Zx[loop] = (float) zx_detect(In_buf, ener_win, 200) / ener_win;

		/* TDF0 est dummy */
		/* 0.00125 fraction of typical pitch period */

	F0[loop] = fo_detect(In_buf, ener_win / 4, 1000.0, 1.0 / sf, 0.00125);
  if (F0[loop] < 0)
		dbprintf(0,"ERROR loop %d F0 %f\n",loop,F0[loop]);
		Ener[loop] = rms;

		if (rms > max_rms)
			max_rms = rms;

		if (rms < min_rms)
			min_rms = rms;

		/* dbprintf(0,"loop %d ener %f\n",loop,rms); */
		loop++;
	}
	return loop;
}

write_tracks(loop, the_pp, min_pow_thres, o_spt)
	int             loop;
	float          *the_pp;
	float           min_pow_thres;
	data_file      *o_spt;
{
	int             spi;
	float           new_pp;
	int             npm = 0;

	*the_pp = 0.0;

	for (spi = 0; spi < loop; spi++) {
		new_pp = Spp[spi];
		if (new_pp > 0) {
			npm++;
			*the_pp += new_pp;
			dbprintf(2, "smooth loop %d pp %4.2f \n", spi, new_pp);
		}
		fwrite(&Rpp[spi], sizeof(float), 1, o_spt->fp);
		fwrite(&Spp[spi], sizeof(float), 1, o_spt->fp);

		if (Ener[spi] > min_pow_thres)
			Ener[spi] = 1.0;
		else
			Ener[spi] = 0.0;

		fwrite(&Ener[spi], sizeof(float), 1, o_spt->fp);
		fwrite(&F0[spi], sizeof(float), 1, o_spt->fp);
		fwrite(&Zx[spi], sizeof(float), 1, o_spt->fp);
	}

	if (npm > 0) {
		*the_pp = *the_pp / (float) npm;
	}
	return npm;
}




smooth_and_fill(loop, max_pitch_gap, frame_shift)
	int             loop;
	float           max_pitch_gap;
	float           frame_shift;
{
	int             span;
	int             spi;

	span = (int) (max_pitch_gap / frame_shift);

	for (spi = 1; spi < loop - span; spi++) {
		btg(Spp, spi, span);
	}

	/* drop one's two's and three's */
	for (spi = 1; spi < loop - 1; spi++) {
		if ((Spp[spi] > 0.0 && Spp[spi - 1] == 0.0)) {
			if (Spp[spi + 1] == 0.0 || Spp[spi + 2] == 0.0
			    || Spp[spi + 3] == 0.0)
				Spp[spi] = 0.0;
		}
	}

	/* SMOOTH and prune */

	for (spi = 1; spi < loop - 1; spi++) {
		if ((Spp[spi] > 0.0) && (Spp[spi + 1] > 0.0)) {
			Spp[spi] = (Spp[spi] + Spp[spi + 1]) / 2.0;
		}
	}

}


float
track_2stage(loop, ave_pp, last_pp)
	int             loop;
	float           ave_pp;
	float          *last_pp;
{
        static long int tc = 0;
	int             spi;
	float           new_pp;
        float           cep_pp;
        float           td_pp;
	float           hz0;
	float           hz1;
        float           hz2;
	float           guess_pp;
	float           ppr;
	int             npm = 0;
	int             contin = 0;
	float           accept_hz_delta = 20;
	float           tot_pp = 0;
	float           rave_pp = 0;
        float           rave_a[10];
        float           rave_s;
        int rave_i;
        int kk;
        float the_time;
        int trk_code = 0;

dbprintf(0,"track - second stage %d\n",loop);

	for (spi = 0; spi < loop; spi++) {
                trk_code = 0;
		guess_pp = 0.0;
		new_pp = 0.0;
		cep_pp = 0.0;
		td_pp = 0.0;
		ppr = ave_pp / 2.2;

		hz0 = Fp1[spi];
		hz1 = Fp2[spi];
		hz2 = F0[spi];

		if (hz0 > 0.0) {
			guess_pp = hz0;
		}

		/* this should be the strongest pitch estimate */

		Rpp[spi] = guess_pp;

		if (hz1 > 0.0 && hz0 > 0.0) {
cep_pp = choose_one(hz0, hz1, ave_pp, rave_pp, *last_pp, contin, accept_hz_delta);
                trk_code = 1;
		} 
                else if (hz0 > 0.0) {
cep_pp = track_hz(hz0, ave_pp, rave_pp, *last_pp, accept_hz_delta, contin);
                trk_code = 2;
		}

		/* try tdf0 */

		if ( hz0 >= 0.0 && F0[spi] > 0.0) {
/* has to be sufficient power */
td_pp = track_hz(F0[spi], ave_pp, rave_pp, *last_pp, accept_hz_delta, contin);
		}

                    if (cep_pp == 0.0) {
			if (td_pp > 0.0) {
                                trk_code = 3;
                                new_pp = td_pp;
				dbprintf(2, "used TDF0 ! %f \n", new_pp);
			      }
		      }
                  else 
                       new_pp = cep_pp;

		Spp[spi] = new_pp;

		contin = 0;

               the_time = tc * frame_shift;

		if (new_pp > 0.0) {
			contin = 1;
			*last_pp = new_pp;
			npm++;
                        rave_i = (npm % 5);
                        rave_a[rave_i] = new_pp;
			tot_pp += new_pp;
             		if (npm > 5) {
                        rave_s = 0.0;
                   for (kk = 0 ; kk < 5; kk++)
                     rave_s += rave_a[kk];
		rave_pp = rave_s / 5.0;
			      }

		}

  dbprintf(0, "Track %d %4.0f %4.0f %4.0f %4.0f %4.0f  %4.0f %4.2f %d\n",tc,Spp[spi],hz0,hz1,hz2,accept_hz_delta,rave_pp,the_time,trk_code);

		adjust_hz_delta(&accept_hz_delta, ave_pp, contin);
                tc ++;
	}
}



setup_pitch_df(spp_file)
	char           *spp_file;
{
	int             posn,i;
        channel n_chn;

	gs_init_df(&o_spt);

	strcpy(o_spt.name, "PITCH");
	strcpy(o_spt.type, "CHANNEL");
	strcpy(o_spt.x_d, "Time");

	o_spt.f[SF] = sf;
	o_spt.f[STR] = i_df.f[STR];
	o_spt.f[STP] = i_df.f[STP];
	o_spt.f[N] = 5;

	gs_o_df_head(spp_file, &o_spt);

	strcpy(o_spt.name, "R_PITCH");
	o_spt.f[N] = n_frames;
	o_spt.f[CN] = 0;
	o_spt.f[BRK_VAL] = 0.0;
	o_spt.f[FS] = frame_shift;
	o_spt.f[LL] = 0.0;
	o_spt.f[UL] = 600.0;
	strcpy(o_spt.dfile, "@");
	gs_w_chn_head(&o_spt);

	/* make copy of channel 0 */
        for ( i = 0 ; i < DOF; i++) {
        n_chn.f[i] = o_spt.f[i];
	}
	n_chn.fp = o_spt.fp;
	strcpy(n_chn.dfile, o_spt.dfile);
	strcpy(n_chn.dtype, o_spt.dtype);

	strcpy(n_chn.name, "S_PITCH");

	n_chn.f[CN] = 1;
	n_chn.f[UL] = 600.0;

	gs_next_chn_head(&n_chn,&o_spt);

	strcpy(n_chn.name, "SP/SIL");
	n_chn.f[CN] = 2;
	n_chn.f[BRK_VAL] = -1.0;
	n_chn.f[UL] = 1.0;
	gs_next_chn_head(&n_chn,&o_spt);

	strcpy(n_chn.name, "TDF0");
	n_chn.f[CN] = 3;
	n_chn.f[UL] = 600.0;
	n_chn.f[BRK_VAL] = 0.0;
	gs_next_chn_head(&n_chn,&o_spt);

	strcpy(n_chn.name, "ZX");
	n_chn.f[CN] = 4;
	n_chn.f[UL] = 1.0;
	gs_next_chn_head(&n_chn,&o_spt);
	posn = gs_pad_header(n_chn.fp);

}


setup_lag_df(pt_file)
	char           *pt_file;
{
	int             posn;
	int             ch_num = 0;

	gs_init_df(&o_pt);

	strcpy(o_pt.name, "PK_VAL");
	strcpy(o_pt.type, "CHANNEL");
	strcpy(o_pt.x_d, "Time");

	o_pt.f[SF] = i_df.f[SF];
	o_pt.f[STR] = i_df.f[STR];
	o_pt.f[STP] = i_df.f[STP];
	o_pt.f[N] = 4;

	gs_o_df_head(pt_file, &o_pt);

	o_chn.fp = o_pt.fp;

	o_chn.f[SF] = sf;
	o_chn.f[FS] = o_df.f[FS];

	strcpy(o_chn.dtype, "float");

	strcpy(o_chn.name, "FREQ");
	o_chn.f[N] = o_df.f[N];
	o_chn.f[CN] = ch_num++;
	o_chn.f[LL] = 0.0;
	o_chn.f[UL] = sf / 2.0;
	strcpy(o_chn.dfile, "@");
	gs_w_chn_head(&o_chn);

	strcpy(o_chn.name, "LAG");
	o_chn.f[CN] = ch_num++;
	o_chn.f[LL] = 0.0;
	o_chn.f[UL] = sf / 2.0;
	strcpy(o_chn.dfile, "@");
	gs_w_chn_head(&o_chn);

	strcpy(o_chn.name, "DB");
	o_chn.f[CN] = ch_num++;
	o_chn.f[LL] = 0;
	o_chn.f[UL] = 120;
	gs_w_chn_head(&o_chn);

	strcpy(o_chn.name, "PK_AMP");
	o_chn.f[CN] = ch_num++;
	o_chn.f[LL] = 0;
	o_chn.f[UL] = 100;
	gs_w_chn_head(&o_chn);

	posn = gs_pad_header(o_pt.fp);
	o_chn.fp = o_pt.fp;
}



setup_cep_df(out_file,n_lag, frame_shift, frame_length)
	char           *out_file;
	float           frame_shift;
	float           frame_length;
{
	int             posn;

	strcpy(o_df.name, "CEPPT");
	strcpy(o_df.type, "FRAME");
	gs_o_df_head(out_file, &o_df);

	o_df.f[N] = (float) n_frames;
	o_df.f[VL] = n_lag;
	o_df.f[FS] = frame_shift;
	o_df.f[FL] = frame_length;
	o_df.f[SF] = sf;
	o_df.f[MX] = n_lag * 1.0;

	strcpy(o_df.x_d, "lag");
	strcpy(o_df.y_d, "correlation");
	o_df.f[LL] = 0.0;
	o_df.f[UL] = 20.0;
	gs_w_frm_head(&o_df);
	posn = gs_pad_header(o_df.fp);
}



setup_ph_df(ph_file, max_pitch, frame_shift, frame_length)
	char           *ph_file;
	float           max_pitch;
{
	int             spi;
	gs_init_frame(&o_ph);
	strcpy(o_ph.name, "CEP_PH");
	strcpy(o_ph.type, "FRAME");

	gs_o_df_head(ph_file, &o_ph);
	o_ph.f[N] = 1.0;
	o_ph.f[VL] = max_pitch / ph_interval;
	o_ph.f[FS] = frame_shift;
	o_ph.f[FL] = frame_length;
	o_ph.f[SF] = sf;
	o_ph.f[MX] = max_pitch;

	strcpy(o_ph.x_d, "Hz");
	strcpy(o_ph.y_d, "count");
	o_ph.f[LL] = 0.0;
	o_ph.f[UL] = (float) n_frames;

	gs_w_frm_head(&o_ph);
	spi = gs_pad_header(o_ph.fp);
}


read_chunk(the_chunk, n_chunks, chunk_sec, the_samples, nsamples, ener_win, off_time, vp)
	float          *off_time;
	int            *vp;
{
	static int      keep_s = 0;
	int             ii,jj;
	long int        fposn;
	int             nsr;
	int             nfpc;

	if (keep_s < 0) {	/* then adjust next read */
		keep_s = 0;
	}

	if (keep_s) {
		for (ii = 0; ii < keep_s; ii++)
			Vox[ii] = Vox[the_samples - keep_s + ii];
	}

	*off_time = (the_chunk - 1) * chunk_sec * 1.0 / sf;

	if (the_chunk == n_chunks) {
		the_samples = nsamples - ((n_chunks - 1) * chunk_sec);
	}

	fposn = ftell(i_chn[0].fp);

	dbprintf(0, "file posn %d keep_s %d \n", fposn, keep_s);

	nsr = fread(&Vox[keep_s], sizeof(short), the_samples - keep_s, i_chn[0].fp);

	dbprintf(0, "computing chunk %d the_samples %d kept %d nsr %d\n", the_chunk,
		 the_samples, keep_s, nsr);
        for ( jj = 0 ; jj < 16 ; jj++) {
	dbprintf(0, "%d\n", Vox[keep_s +jj]);
        }

	if (nsr != the_samples - keep_s) {
dbprintf(-1, "couldn't read it all nsr %d the_s %d keep_s %d\n", nsr, the_samples, keep_s);
	}
	nfpc = (int) ((the_samples / sf) / frame_shift);

	*vp = (int) ((nfpc - 1) * frame_shift * sf + 0.5);

	if ((*vp + ener_win) > the_samples) {
		nfpc--;
	}
	dbprintf(0, "nframes per chunk %d \n", nfpc);

	/* save any samples for next chunk ? */

	keep_s = (int) ((nfpc * frame_shift * sf) + 0.5);

	dbprintf(0, "the_samples %d keep_s %d \n", the_samples, keep_s);

	keep_s = the_samples - keep_s;

	if (keep_s > 0)
		dbprintf(0, "the_samples %d keep_s %d for next chunk \n", the_samples, keep_s);

	return nfpc;
}


clear_real(n)
{
	int             spi;
	for (spi = 0; spi < n; spi++)
		Real[spi] = 0.0;
}

clear_ener()
{
	int             spi;
	for (spi = 0; spi < MAXEN; spi++)
		Ener[spi] = 0.0;
}


clear_hp(max_pitch)
{
	int             spi;
	for (spi = 0; spi < max_pitch; spi++)
		Hp[spi] = 0.0;

}


set_pow_thres(loop, the_chunk)
int             loop;
{
	float           start_value;

/* lets find out what min_pow_thres should be */
/* what should start_value be ? */

	start_value = (max_rms - min_rms) / 3.0 + min_rms;

dbprintf(0,"set pow thres \n");

dbprintf(0, "nloops %d min_rms %4.2f max_rms %4.2f bkg_level %4.2f\n", loop, min_rms,max_rms,start_value);

	sp_stats(Ener, pitch_stats, loop);

dbprintf(0," ener stats ave %f sd %f min %f max %f\n",pitch_stats[1],pitch_stats[4],pitch_stats[5],pitch_stats[6]);

	min_pow_thres = pitch_stats[5] + pitch_stats[4]/2;

	if (min_pow_thres > max_rms)
		min_pow_thres = (max_rms - min_rms) / 6.0 + min_rms;

	a_pow_thres = min_pow_thres;
}


compute_chunk(n_chunks, chunk_sec, nsamples)
	int            *n_chunks;
	int            *chunk_sec;
{
	int             the_samples;

	/* how much data */
	/* total = nsamples */
	/* chunk_sec sf * P_AVE_SECS */

	*chunk_sec = (int) (sf * P_AVE_SECS);

	if (*chunk_sec > MAXDS)
		*chunk_sec = MAXDS;

	dbprintf(1, "chunk_sec %d sf %f \n", *chunk_sec, sf);

	the_samples = *chunk_sec;

	*n_chunks = nsamples / *chunk_sec;

dbprintf(0,"file processed in %d chunks chunk_sec %d todo %d\n", *n_chunks, *chunk_sec, nsamples);

	if ((*n_chunks * *chunk_sec) < nsamples)
		*n_chunks += 1;

	/* read it all */

	if (nsamples <= *chunk_sec)
		the_samples = nsamples;

dbprintf(0,"file processed in %d chunks chunk_sec %d todo %d\n", *n_chunks, *chunk_sec, nsamples);

	return the_samples;
}


update_ph(loop, power, ph_interval)
	float           power;
	float           ph_interval;
{
	int             spi;

	Fp1[loop] = Results[4];
	Fp2[loop] = Results[5];

	/* pitch plus weight by amp */

	if (Results[4] > 0.0) {
		spi = (int) (Results[4] / ph_interval);
		Hp[spi] += (Results[3] + power / 10.0);
	}
	if (Results[5] > 0.0) {
		spi = (int) (Results[5] / ph_interval);
		Hp[spi] += (Results[6] + power / 10.0);
	}
}



compute_cep(loop)
	int             loop;
{
        static int  cfc = 0;
	int             cr = 0;
	int             pwr_skip = 0;
	int             get_n_peaks = 0;
	int             j;
	int             vp;

	float           rms;
	float           power = 0.0;
	float           new_pp;
	float           dt;
	float           the_time;
	static          init = 1;

	dt = 2.0 / sf;

	Results[0] = 0.0;

	if (a_pow_thres > 60)
		a_pow_thres = 60;

	rms = Ener[loop];

	if ( (rms > min_rms + 1.5) ) {
/* DO CEPSTRUM  */ 
                cr = 1;

		vp = (int) (loop * frame_shift * sf + 0.5);

		for (j = 0; j < win_length; j++)
			In_buf[j] = (float) Vox[vp++];
		q_cep(In_buf, Real, Imag, fft_size, scale_factor,
		      win_length, Window, &power, sf);
	}

        if ((power/rms  > 0.8) && (power > (min_pow_thres -5))) {
dbprintf(1, "%d power in 80-2500 band %f OK pow_thres %f rms %f \n",loop, power, min_pow_thres, rms); 
	 }
        else {
	if ((power < (min_pow_thres-3)) && do_pwr_thres) {
		/* CHECK POWER */
dbprintf(1, "%d power in 80-2500 band %f less then pow_thres %f rms %f SKIP CEP \n",loop, power, min_pow_thres, rms);
		pwr_skip = 1;
		cr = 0;
	Results[0] = -1.0;
	}
      }

	if (cr) {
		if (smooth)
			sp_rave(Real, n_lag, smooth, init);
		init = 0;
	} else
		clear_real(n_lag);

	if (o_flag_set) {
         dbprintf(1,"compute_cep write_frame \n");
		gs_write_frame(&o_df, Real);
        }

	if (cr) {
		/* PEAKPICK */
	get_n_peaks = q_pickpeaks(Real, Results, cep_thres, inc_thres, n_peaks,
					  start_at, finish_at);

		/* SORT in amp order why ? */
		if (get_n_peaks > 1)
			q_pksort(Results, n_peaks);

	}

	power = rms;

	/* 0 & 1 biggest peak Hz */

	Results[2] = power;

	dbprintf(1, "power %f pow_thres %f\n", power, pow_thres);

	Fp1[loop] = -1.0;
	Fp2[loop] = 0.0;

	/* PULL OUT PREDOMINANT PITCH */
	the_time = loop * frame_shift + off_time;

	if (Results[0] > 0.0) {
                q_pitch_track(Results,the_pitch,power,pow_thres,min_pow_thres,n_peaks,dt,the_time);
		update_ph(loop, power, ph_interval);

	} 
        else {
		Results[1] = -1;
		Results[3] = 0.0;
	}

	if (cr) {

		if (Results[0] <= 0.0) {	/* sufficient power but no
						 * pitch */
			if (Results[0] != -2.0)	/* not a rejected pitch */
				a_pow_thres += 1.0;
			else
				n_rejects++;
		} else {
			if ((power - a_pow_thres) < 3.0)
				a_pow_thres -= 3.0;
		}


	}



if ( ! pwr_skip)
dbprintf(2, "loop %d %4.2f dB %4.2f Hz %4.2f secs \n", cfc, Results[2], Results[0], the_time);

         cfc++;
	/* STORE RESULTS as parallel tracks in output file */

	if (Results[0] < 0.0)
		Results[0] = 0.0;

	if (p_flag_set)
		fwrite(Results, sizeof(float), 4, o_chn.fp);

	new_pp = Results[0];

	/* ADAPT WL */

	if (adapt_wl) {
		if ((power > min_pow_thres + 3.0) && cr) {
			q_adapt_wl(Window, new_pp, &win_length,sf,old_wl);
		}
	}

	old_wl = win_length;
}

main(argc, argv)
	int             argc;
	char           *argv[];
{
	char            out_file[120];
	char            in_file[120];
	char            pt_file[120];
	char            ph_file[120];
	char            spt_file[120];
	char            spp_file[120];
	int             m_order;

	int             es, find_sil;

	float           start_at_hz = 90.0;
	float           finish_at_hz = 600.0;
	float           hz, the_time;
	float           max_pitch;
	float           the_pp;
	float           guess_pp;
	float           max_pc;

	float           accept_hz_delta = 20.0;
	float           f0est;

	int             cr;
	int             spi, ii;
	int             s_to_hf = 0;
	int             in_region;
	char            data_type[20];
	int             no_header = 0;
	int             offset = 0;

	int             ch_num = 0;
	int             start_isp, step_isp, finish_isp;
	int             sort_it;


	int             contin;
	int             nsr, old_wl;
	int             doubling = 0;
	float           g_factor;
	float           length;
	float           rms;
	float           lp0, lp1, l2p0, hz1, hz0, hz_2, last_pp;
	float           last_chunk_pp;

	double          R0;
	float           tot_pp, ave_pp;
	float           old_pp, the_lag, new_pp;

	float           dp0, dp1, d2p0;
	float           expon = 0.6;
	float           pitch0, pitch1;
	int             rppi;
	int             gain = 0;


	int             n_spts;
	int             time_shift = 0;
	int             nloops;
	int             vp = 0;
	int             eof, nsamples, the_samples;
	int             the_chunk, n_chunks;

	int             n_eof = 0;
	int             chunk_sec;
	int             nf, nfpc;
	int             i, j, n, k;
	int             loop;
	int             norm = 0;
	int             warp = 0;
	int             eh = 0;

	int             pka, pkb;
	int             m_ave = 0;
	int             get_n_peaks;

	int             n_vals = 0;
	int             pk, isp;
	int             npm;
	float           delta, floor;
	float           tmp, clip_pc;
	int             add_floor = 0;

	int             job_nu = 0;
	int             reverse_search = 1;

	char            start_date[40];
	double          atof();

	int             nframes;
	char            buf[128];
	float           ex = 1.0 / 3.0;
	float           ppr;
	char            sd_file[80];

	int             fposn, posn, nc;
	int             fsize;
	int             chan;
	int             do_all_chns = 0;
	int             start_channel = 0;
	int             num_chans = 1;
	int             span;
	float           h_len;
	float           power;
	double          atof();

	/* DEFAULT SETTINGS */

	int             ebw_set = 0;
	int             fft_size_set = 1;
	int             frame_shift_set = 1;
	int             frame_length_set = 1;
	int             win_shift_set = 0;

	/* DEFAULT VALUES */

	int             ener_win = 128;
	float           pre = 0.0;
	float           small = 0.0000001;

	float           ebw;
	float           size;

	int             dBflag = 1;

	/* COPY COMMAND LINE TO OUTPUT HEADERS */

	strcpy(o_df.source, "\0");
	for (i = 0; i < argc; i++) {
		strcat(o_df.source, argv[i]);
		strcat(o_df.source, " ");
	}

	strcat(o_df.source, "\0");
	strcpy(ph_file, "cep_ph");

	strcpy(o_pt.source, "\0");
	for (i = 0; i < argc; i++) {
		strcat(o_pt.source, argv[i]);
		strcat(o_pt.source, " ");
	}
	strcat(o_pt.source, "\0");
	strcpy(o_spt.source, "\0");
	for (i = 0; i < argc; i++) {
		strcat(o_spt.source, argv[i]);
		strcat(o_spt.source, " ");
	}
	strcat(o_spt.source, "\0");

	/* PARSE COMMAND LINE  */

	for (i = 1; i < argc; i++) {

		if (debug == HELP)
			break;

		switch (*argv[i]) {

		case '-':

			switch (*++(argv[i])) {

			case 'k':
				n_peaks = atoi(argv[++i]);
				break;

			case 'n':
				fft_size_set = 1;
				fft_size = atoi(argv[++i]);
				break;

			case 'w':
				win_length = atoi(argv[++i]);
				break;

			case 'S':
				smooth = atoi(argv[++i]);
				break;

			case 'O':
				win_shift_set = 1;
				win_shift = atoi(argv[++i]);
				break;

			case 'f':
				sf = atof(argv[++i]);
				break;

			case 's':
				frame_shift_set = 1;
				frame_shift = atof(argv[++i]);
				time_shift = 1;
				frame_shift *= .001;
				break;

			case 'l':
				frame_length_set = 1;
				frame_length = atof(argv[++i]);
				frame_length *= .001;
				break;

			case 'A':
				adapt_wl = 1;
				break;

			case 'b':
				start_at_hz = atof(argv[++i]);
				break;

			case 'e':
				finish_at_hz = atof(argv[++i]);
				break;

			case 't':
				cep_thres = atof(argv[++i]);
				break;
			case 'g':
				Max_pitch_gap = atof(argv[++i]) * .001;
				break;
			case 'd':
				Min_pitch_duration = atof(argv[++i]) * .001;
				break;
			case 'P':
				pow_thres = atof(argv[++i]);
				min_pow_thres = pow_thres;
                                auto_pwr_thres = 0;
                                if (pow_thres <= 0) {
				do_pwr_thres =0;
/* always use cep estimate if no pwr_thres */                           
			        }
				break;

			case 'M':
				min_pow_thres = atof(argv[++i]);
				break;

			case 'C':
				P_AVE_SECS = atof(argv[++i]);
				break;
			case 'R':
				Max_Hz_delta_pc = atof(argv[++i]);
				break;

			case 'i':
				i_flag_set = 1;
				strcpy(in_file, argv[++i]);
				break;

			case 'o':
				o_flag_set = 1;
				strcpy(out_file, argv[++i]);
				break;

			case 'p':
				p_flag_set = 1;
				strcpy(pt_file, argv[++i]);
				break;

			case 'z':
				ph_flag_set = 1;
				strcpy(ph_file, argv[++i]);
				break;

			case 'x':

				strcpy(spp_file, argv[++i]);
				break;

			case 'J':
				job_nu = atoi(argv[++i]);
				gs_get_date(start_date, 1);
				break;

			case 'v':
				show_version();
				exit(-1);
				break;
			case 'Y':
				debug = atoi(argv[++i]);
				break;

			case 'H':
			case 'h':
				debug = HELP;
				break;

			default:
				printf("%s: option not valid\n", argv[i]);
				debug = HELP;
				break;
			}
		}
	}


	if (debug == HELP || argc == 1)
		sho_use();

	if (debug >= 0)
		debug_spm(argv[0], debug, job_nu);

	signal(SIGFPE, fpe_trap);

	if (!i_flag_set)
		strcpy(in_file, "stdin");

	dbprintf(0, "infile %s\n", in_file);

	if (read_sf_head(in_file, &i_df, &i_chn[0]) == -1) {
		dbprintf(1, "not  header file\n");
		exit(-1);
	}

	nc = 0;

	num_chans = (int) i_df.f[N];

	if ((int) i_df.f[N] > 1) {
		dbprintf(1, "There are %d channels;\n", (int) i_df.f[N]);
		i_chn[0].f[SKP] = i_df.f[N] - 1;
	}

	length = i_df.f[STP] - i_df.f[STR];

	gs_init_frame(&o_df);

	o_df.f[STR] = i_df.f[STR];
	o_df.f[STP] = i_df.f[STP];

	/* check poss that header points to a datafile */

	if (((int) i_chn[nc].f[SOD]) > 0)
		fposn = (int) i_chn[nc].f[SOD];

	nsamples = (int) i_chn[0].f[N];

	dbprintf(0, "n_samples %d \n", nsamples);

	h_len = nsamples / i_chn[0].f[SF];

	if (h_len < length) {
		o_df.f[STP] = h_len;
		o_df.f[STR] = 0.0;
	}
	if (length <= 0.0) {
		length = h_len;
		o_df.f[STP] = length;
	}
	/* else start reading where header ends */
	/* sampling frequency */

	sf = i_df.f[SF];

        if (sf == 0.0) 	sf = i_chn[0].f[SF];

	/* Get sample start and stop times */

	/*
	 * WORK OUT PARAMETER VALUES  according to precedence & Header
	 * information
	 */

	if (frame_length_set) {
		win_length = (int) (sf * frame_length + 0.5);
		dbprintf(0, "fl set %f wl %d sf %f\n", frame_length, win_length,sf);
	}
	if (fft_size < win_length)
		fft_size = compute_fft_size(win_length);

	if (fft_size < 2 || fft_size > 2048) {
		dbprintf(1, "%s: fft size out of range\n", argv[0]);
		exit(-1);
	}
	if (!win_shift_set)
		win_shift = win_length / 2;

	if (win_shift <= 0) {
		dbprintf(1, "window shift not valid %d must be > 0\n", win_shift);
		exit(-1);
	}
	if (!frame_shift_set) {
		frame_shift = (float) win_shift / sf;
		frame_length = win_length / (1.0 * sf);
	} else {
		win_shift = (int) (frame_shift * sf + 0.5);
		n_frames = (int) (length / frame_shift + 0.5);
	}

	n_frames = (nsamples) / win_shift;


	if (((n_frames) * win_shift) > nsamples)
		n_frames--;

	/* SHOW PARAMETER VALUES */

	n_lag = fft_size / 4;

	dbprintf(0, "fl %f fs %f wl %d ws %d ffts %d\n", frame_length, frame_shift, win_length, win_shift, fft_size);
	dbprintf(0, "num chans %d \n", num_chans);
	dbprintf(0, "num frames %d as limited by FFT size \n", n_frames);

	if (num_chans > 1.0 & start_channel == 0) {
		do_all_chns = 1;
		o_df.f[N] = num_chans;
	} else
		o_df.f[N] = 1.0;

	if (o_flag_set) {
		setup_cep_df(out_file,  n_lag, frame_shift, frame_length);
	}

	ph_interval = 40.0;
	max_pitch = 600.0;
	o_ph.f[VL] = max_pitch / ph_interval;

	if (ph_flag_set) {
		setup_ph_df(ph_file, max_pitch, frame_shift, frame_length);
	}
	/* PITCH TRACK FILE */

	n_spts = n_lag;

	/* copy across some data from input to output headers */

	delta = n_lag / (float) n_spts;

	dbprintf(0, "delta %f n_spts %d mx %f\n", delta, n_spts, o_df.f[MX]);

	if (p_flag_set) {
		setup_lag_df(pt_file);
	}

	setup_pitch_df(spp_file);

	/* COMPUTE SCALE FACTOR  & SMOOTHING WINDOW */

	scale_factor = 1.0 / (1.0 * fft_size);
	scale_factor2 = 1.0 / (1.0 * fft_size / 2);

	j = fft_size / 4;

	start_at = j - 3;
	finish_at = 10;

	start_at = sf / (2.0 * start_at_hz);
	finish_at = sf / (2.0 * finish_at_hz);

	inc_thres = (2.0 * cep_thres) / (float) (abs(start_at - finish_at));

	dbprintf(1, "shz %f fhz %f \n", start_at_hz, finish_at_hz);
	dbprintf(1, "cep_thres %f inc_thres %f  \n", cep_thres, inc_thres);

	start_isp = n_spts - 3;
	finish_isp = 2;
	step_isp = -1;

	dbprintf(1, "wl %d n_lag %d \n", win_length, n_lag);
	dbprintf(0, " Max_Hz_delta_pc %f\n", Max_Hz_delta_pc);


	/* MAIN LOOP */
	/* INITIALISE FOR FIRST READ */

	loop = 0;

	gs_window("Hanning", win_length, Window);

	nsr = win_length;

	old_wl = win_length;

	dbprintf(0, "CEPPT -- COMPUTING\n");

	ener_win = (int) (frame_shift * sf);

	the_samples = compute_chunk(&n_chunks, &chunk_sec, nsamples);

	for (the_chunk = 1; the_chunk <= n_chunks; the_chunk++) {

		/* first chunk */
		/* how many frames per chunk */

		nfpc = read_chunk(the_chunk, n_chunks, chunk_sec, the_samples, nsamples, ener_win, &off_time, &vp);

		clear_ener();

		clear_hp((int) max_pitch);

		min_rms = 1000.0;
		max_rms = 0.0;

		/*
		 * need to  process chunk_secs worth take care of frame-shift
		 * transition to next block
		 */

		loop = compute_ener_zx(nfpc, frame_shift, sf, ener_win);

dbprintf(0, "min_rms %4.2f max_rms %4.2f \n",min_rms, max_rms);

                if (auto_pwr_thres)
		set_pow_thres(loop, the_chunk);

dbprintf(0, "BACKGROUND level %4.2f for chunk %d nfpc %d\n", min_pow_thres, the_chunk,nfpc);

		for (nf = 0; nf < nfpc; nf++) {
			compute_cep(nf);
		}

/* WRITE OUT histogram of poss pitches */

		if (ph_flag_set) {
			fwrite(Hp, sizeof(float), (int) o_ph.f[VL], o_ph.fp);
		}
		max_pc = 0.0;
		the_pp = 0.0;

		for (spi = 0; spi < (int) o_ph.f[VL]; spi++) {
			if (Hp[spi] > max_pc) {
				max_pc = Hp[spi];
				the_pp = spi * ph_interval + ph_interval / 2.0;
			}
		}


		if (the_chunk == n_chunks && ph_flag_set)
			gs_close_df(&o_ph);

		/* SECOND PASS CLEAN UP INITIAL ERRORS ? */
		/* MOST TRACKING HAS BEEN DONE ABOVE */

		last_pp = the_pp;

		C_ave[the_chunk] = the_pp;

		ave_pp = 0;

		for (ii = 1; ii <= the_chunk; ii++) {
			ave_pp += C_ave[ii];
		}

		ave_pp /= (float) the_chunk;

dbprintf(0, "ceppt PASS 1 pp is %f  %f nloops %d whole_ave %4.2f\n", the_pp, max_pc, loop, ave_pp);

		tot_pp = 0.0;

		contin = 0;

		if (the_chunk == 1)
			last_pp = ave_pp;
		else
			last_pp = last_chunk_pp;

		track_2stage(loop, ave_pp, &last_pp);

		last_chunk_pp = last_pp;

		smooth_and_fill(loop, Max_pitch_gap, frame_shift);

		npm = write_tracks(loop, &the_pp, min_pow_thres, &o_spt);

dbprintf(0, "chunk %d out of %d chunks ave_pp %4.2f\n", the_chunk, n_chunks, the_pp);

		C_ave[the_chunk] = the_pp;

	}			/* nchunks */

	fflush(o_spt.fp);

	if (i_flag_set)
		gs_close_df(&i_df);

	if (o_flag_set)
		gs_close_df(&o_df);

	if (p_flag_set)
		gs_close_df(&o_chn);

	if (job_nu) {
		dbprintf(0, "job %d\n", job_nu);
		job_done(job_nu, start_date, o_df.source);
	}
	gs_close_df(&o_spt);

  dbprintf(0, "CEPPT finished %d frames nrejects %d \n", loop, n_rejects);

	exit(-1);

}

/* USAGE & HELP */

sho_use()
{

	fprintf(stderr, "Usage: ceppt  -i in_file -o ac_file -p pt_file\n");
	fprintf(stderr, "-n	fft_size [256]	max 2048  \n");
	fprintf(stderr, "-l	frame_length    msecs  \n");
	fprintf(stderr, "-s	frame_shift	msecs  \n");
	fprintf(stderr, "-w	win_length	sample_points  \n");
	fprintf(stderr, "-O	win_shift	sample_points  \n");
	fprintf(stderr, "-f	sampling frequency 	Hz  \n");
	printf("t peak threshold  float [4.0]\n");
	printf("k number of peaks to find \n");
	printf("b begin search for cepstral pitch peak at Hz [50]\n");
	printf("e end search for cepstral pitch peak at Hz [1000]\n");
        printf("P power thres (if energy > thres then use cep peak) [65] dB\n");
	printf("M min power thres (if energy < thres then don't use cep peak) [40] dB\n");
	printf("C center_clip \n");
	printf("F float add floor \n");
	printf("L lag-to-hz \n");
	printf("R max Hz rate [50 Hz/sec]\n");
	fprintf(stderr, "d min_pitch_duration [50] msec  \n");
	fprintf(stderr, "g max_pitch_gap [50] msec (smoothing will fill this in  )\n");
	fprintf(stderr, "N.B. Header information (if present) will overide flag settings\n");
	show_version();
	exit(-1);
}

show_version()
{
	char           *rcs;
	rcs = &rcsid[0];
	printf(" %s \n", rcs);
}
