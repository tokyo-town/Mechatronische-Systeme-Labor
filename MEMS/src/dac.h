

#ifndef SRC_DAC_H_
#define SRC_DAC_H_

#include <stdio.h>
#include "platform.h"
#include "xadcps.h"
#include "xbasic_types.h"
#include "xparameters.h"
#include "xstatus.h"
#include "xspi.h"



int MEMSSpiInit();

int MEMSSpiInit_HV();

int MEMSDACiRefSetValue(u8 nValue);

int MEMSDACiRefSetValue12Bit(u16 nValue);

int MEMSDACiRefSetValue12Bit_HV(u16 nValue);

#endif /* SRC_DAC_H_ */
