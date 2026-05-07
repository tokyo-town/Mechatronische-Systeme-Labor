#include "mirror.h"

#include <stdio.h>
#include "platform.h"
#include "xbasic_types.h"
#include "xparameters.h"
#include "sleep.h"

extern MEMSMirror* mirror;
volatile int32_t data[512];// data buffer for identification

// Interrupt function, called
void MirrorInterrupt(void *baseaddr_p)
{
	// Identification
	if(mirror->id_running == 1){
		data[mirror->id_cnt] = MirrorGetPhase();
		mirror->id_cnt ++;
		if(mirror->id_cnt == 512)
			mirror->id_running = 0;
	}
	

	// PLL
	if(mirror->mode == CLOSED_LOOP){
		// Todo: In closed loop mode, run the PLL controller and set a new period. Don't forget to consider the operation point

		// read the current phase error
		int32_t dt_phi = MirrorGetPhase();
		// calculate the control output
		float u = mirror->Kp * dt_phi + mirror->Ki * mirror->int_state;
		// update the integrating state
		mirror->int_state += dt_phi;
		// set the new period
		double f = PERIOD_TO_FREQ((int32_t) mirror->reg->period);
		MirrorSetFrequency(f + u);
	}
}

// Initialize Mirror default parameters
void MirrorSetDefaults(){
	mirror->mode = NONE;
	mirror->reg->control.enable = 0;
	mirror->reg->period = FREQ_TO_PERIOD(4400);
	mirror->reg->soff = 350;
	mirror->reg->son = mirror->reg->soff+(int) (SLICES * 0.5); // 60% duty cycle

	mirror->d = 0;
	mirror->reg->phase_det_window=350;
	mirror->reg->control.reset_fpga = 1;
	mirror->reg->control.reset_fpga = 0;



}

// transition to the IDLE mode
void MirrorStop(){
	mirror->reg->control.enable = 0;
	mirror->mode = NONE;
}

// enable open loop mode
void MirrorEnOpenLoop(){
	mirror->reg->control.enable = 1;
	mirror->mode = OPEN_LOOP;
}

// enable closed loop mode
void MirrorEnClosedLoop(){
	mirror->reg->control.enable = 1;
	mirror->mode = CLOSED_LOOP;
	// ToDo: Configure the linearization point here
	mirror->f_lin = PERIOD_TO_FREQ((int32_t) mirror->reg->period);
	mirror->dt_phi_lin = MirrorGetPhase();

	// ToDo: Configure Kp and Ki
	mirror->Kp = 0.01;
	mirror->Ki = 0.001;

	// ToDo: reset the integrating state of the controller
	mirror->int_state = 0;
}


// Identification function
void MirrorId(int input_sel){
	int i, step;
	mirror->id_cnt = 0;
	mirror->id_running = 1;
	for(i = 0; i< 512;i++)
		data[i] = 0;
	step = 1;
	if(input_sel == 0) MirrorChangeFrequency(-10); // frequency identification
	if(input_sel == 1) mirror->d -= 10; // closed loop complementary sensitivity identification
	if(input_sel == 2) step = 2; // noise measurement, omit every second value
	while(mirror->id_running == 1){
		// wait for ID to finish
		usleep(1);
	}
	xil_printf("[");
	for(i = 0; i < (512-step); i+=step){
		xil_printf("%d, ", data[i]);
	}
	xil_printf("%d];\r\n", data[i]);

	if(input_sel == 0)	MirrorChangeFrequency(10);
	if(input_sel == 1)  mirror->d += 10;
}



// returns the phase error \Delta t_phi in nanoseconds
int MirrorGetPhase(){
	return 10*(mirror->reg->period>>PERIOD_FRAC_BITS)*mirror->reg->soff/SLICES + ((int32_t) mirror->reg->debugRegister1 * -10);
}


// function to read and write the frequency
void MirrorSetFrequency(double f){
	mirror->reg->period = (uint32_t)(FREQ_TO_PERIOD(f + mirror->d));
}

double MirrorGetFrequency(){
	return PERIOD_TO_FREQ((int32_t) mirror->reg->period);
}

void MirrorChangeFrequency(double change){
	double act = PERIOD_TO_FREQ((int32_t) mirror->reg->period);
	mirror->reg->period = (uint32_t)((FREQ_TO_PERIOD(act + change)));
}


// functions to write and read the duty cycle
void MirrorSetDuty(int f){
	mirror->reg->son = mirror->reg->soff+(int) ((SLICES * (100-f))/100);
}
int MirrorGetDuty(){
	return (100- (mirror->reg->son-mirror->reg->soff) * 100/(SLICES));
}
void MirrorChangeDuty(int change){
	float d = (100.0- mirror->reg->son * 100.0/(SLICES));
	int hreg_new = mirror->reg->son;
	mirror->reg->son = (int) ((SLICES * (100.0-d-change))/100);
	xil_printf("debug: %d %f %d\r\n", mirror->reg->son, d, hreg_new);
}
