
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
        float sp_start_time;
        float sp_stop_time;
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



