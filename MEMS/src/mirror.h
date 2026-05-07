#ifndef SRC_MIRROR_H_
#define SRC_MIRROR_H_

#if defined (__arm__) || defined(__aarch64__)
#include "xil_printf.h"
#endif
#include "MEMSRegister.h"

// ---------------- GLOBAL CONSTANTS -----------------------------------
#define SLICES_W 12
#define FPGA_FCLK 100000000
#define SLICES (1<<SLICES_W)
#define PERIOD_FRAC_BITS 8

// ---------------- MACROS -----------------------------------
#define FREQ_TO_PERIOD(x) ((u32)(((uint64_t) FPGA_FCLK << PERIOD_FRAC_BITS) / (x)))
#define FREQ_TO_PERIOD_INT(x) ((u32)(((uint64_t) FPGA_FCLK ) / (x)))
#define PERIOD_TO_FREQ(x) (((double) FPGA_FCLK * (1<<PERIOD_FRAC_BITS)) / (x))

typedef enum
{
	NONE,
	OPEN_LOOP,
	CLOSED_LOOP
} MEMSMode;

typedef volatile struct
{
	MEMSMode mode;
	volatile struct MEMSRegister* reg; // FPGA Register file
	int32_t d; // simulated disturbance

	volatile int id_running; // flag to signalize that the identification is running
	volatile uint32_t id_cnt; // counts period during identification

	/*Todo: add variables here:
	 * linearization for f and delta t_phi
	 * p-gain and i-gain
	 * state for the controller
	 */
} MEMSMirror;


// ---------------- FUNCTIONS -----------------------------------
void MirrorSetDefaults();
void MirrorEnOpenLoop();
void MirrorEnClosedLoop();
void MirrorStop();
void MirrorId(int type);

void MirrorSetFrequency(double f);
double MirrorGetFrequency();
void MirrorChangeFrequency(double change);

void MirrorSetDuty(int f);
int MirrorGetDuty();
void MirrorChangeDuty(int change);

int MirrorGetPhase();


#endif
