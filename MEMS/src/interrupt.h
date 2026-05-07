
#ifndef SRC_INTERRUPT_H_
#define SRC_INTERRUPT_H_

#include <stdio.h>
#include "platform.h"
#include "xbasic_types.h"
#include "xparameters.h"
#include "xstatus.h"
#include "xscugic.h"
#include "xadcps.h"
#include "xscutimer.h"


extern XScuGic 			g_XIntc;
extern XScuGic_Config 	*g_pGicConfig;
extern u32				g_nInterruptEventsZeroCrossing;

#define MEMS_ZERO_CROSSING_INTERRUPT_ID		61


int MirrorInterruptInitialize(void);

#endif /* SRC_INTERRUPT_H_ */
