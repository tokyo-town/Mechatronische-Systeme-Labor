#include <stdio.h>
#include "xparameters.h"

#include "platform.h"
#include "platform_config.h"
#if defined (__arm__) || defined(__aarch64__)
#include "xil_printf.h"
#endif

#include "xil_cache.h"
#include "xscugic.h"

#include "mirror.h"
#include "menu.h"
#include "interrupt.h"
#include "dac.h"


MEMSMirror* mirror;

int main(){
	// Configure HV DAC (do nothing, set High voltage via external supply
	MEMSSpiInit_HV();
	MEMSDACiRefSetValue12Bit_HV(0xFFFF);

	MEMSMirror memsmirror;
	mirror = &memsmirror;

	// Initialize MEMS mirror
	mirror->reg = (volatile struct MEMSRegister*) XPAR_MEMSCONTROLLER_V1_0_0_BASEADDR;
	MirrorSetDefaults();
	MirrorInterruptInitialize();

	// init the menu
	MEMSMenuInitialize();
	while(1){
		MEMSMenuLoop();
	}
	return 0;
}
