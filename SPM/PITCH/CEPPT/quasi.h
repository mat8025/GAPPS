
#define P_RISE 1
#define P_FALL -1
#define P_LEVEL 0
#define P_CURVE 2
#define P_ODD 3
#define P_RVCURVE 4
#define P_RACURVE 5
#define P_FVCURVE 6
#define P_FACURVE 7

typedef struct {
	float start_time;
	float stop_time;
	float ave;
	float sd;
	float max;
	float min;
	float p_begin;
	float p_mid;
	float p_end;	
	float slope;
	float pconst;
	float dur;
	float clevel;
	int nps;
	int type;
	char rule[32];
} P_con;

typedef struct {
	float sf; /* signal sample frequency e.g. 8000 hz */
	float frame_shift; /* frame_shift .010 secs */
	float min_pow_thres; /* disregard all pitch beneath this level */
	int fft_size; /* 512 radix 2 FFT */
	int smooth; /* running ave of [3] successive raw pitch estimates */
} PTP; /* pitch tracker parameters */


int q_cep(float in_buf[],float real[],float imag[],
	  int fft_size,float scale_factor,int win_length,float window[],float *power,float sf);

int q_pickpeaks(float pam[],float results[],float cep_thres,float inc_thres,
		int n_peaks,int start_at,int finish_at);

void q_pksort(float results[],int n_peaks);

void q_adapt_wl(float window[],float new_pp,int *win_length,float sf,int old_wl);

void q_pitch_track(float results[],float the_pitch[],float power,float pow_thres,float min_pow_thres,int n_peaks,float dt,float time);
