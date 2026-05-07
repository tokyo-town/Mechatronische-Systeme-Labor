
#include "menu.h"

#include <stdio.h>
#include "platform.h"
#include "xbasic_types.h"
#include "xparameters.h"
#include "xstatus.h"
#include "xadcps.h"

#include "dac.h"
#include "mirror.h"
#include "xuartps.h"

extern MEMSMirror* mirror;

void MEMSMenuDisplay()
{
	xil_printf("\r\n\r\n\r\n\r\n\r\n"); // some newlines to signalize that a new menu starts
	if( mirror->mode == NONE )
	{
		xil_printf("Current Mode: IDLE\r\n\n");
		xil_printf("Commands: [0] stop, [1] open-loop\r\n");
		xil_printf("\n\r");
	}
	else if( mirror->mode == OPEN_LOOP )
	{
		xil_printf("Current Mode: OPEN-LOOP\r\n\n");
		xil_printf("Commands: [0] stop, [1] open-loop, [2] closed-loop\r\n");

		xil_printf("Actuation Frequency: %d\r\n", (int32_t) MirrorGetFrequency());
		xil_printf("    [q] +50Hz, [w] +10Hz, [e] +1Hz, [r] -1Hz, , [t] -10Hz, , [z] -50Hz\r\n");
		xil_printf("Duty Cycle: %d\r\n", MirrorGetDuty());
		xil_printf("    [a] +10, [s] +1, [d] -1, [f] -10\r\n");

		xil_printf("Phase: %d ns\r\n", MirrorGetPhase());
	}
	else if( mirror->mode == CLOSED_LOOP )
	{
		xil_printf("Current Mode: CLOSED-LOOP\r\n\n");
		xil_printf("Commands: [0] stop, [1] open-loop\r\n");

		xil_printf("Actuation Frequency: %d\r\n", (int32_t) MirrorGetFrequency());

		xil_printf("Duty Cycle: %d\r\n",MirrorGetDuty());
		xil_printf("    [a] +10, [s] +1, [d] -1, [f] -10\r\n");

		xil_printf("Phase: %d ns\r\n", MirrorGetPhase());
	}
}


void MEMSMenuInitialize()
{
	MEMSMenuDisplay();
}

void MEMSMenuProcessCommand_a( u8 nUartRead )
{
	// Operating Modes
	switch( nUartRead )
	{
	case '0':
		MirrorStop(mirror);
		break;
	case '1':
		MirrorEnOpenLoop();

		break;
	case '2':
		MirrorEnClosedLoop(mirror);
		break;
	}

	if(mirror->mode != NONE){ // duty cycle settings
		switch(nUartRead)
		{
		case 'a': MirrorChangeDuty(10); break;
		case 's': MirrorChangeDuty(1); break;
		case 'd': MirrorChangeDuty(-1); break;
		case 'f': MirrorChangeDuty(-10); break;
		}
	}

	if(mirror->mode == OPEN_LOOP){ // period settings
		switch(nUartRead)
		{
			case 'q': MirrorChangeFrequency(50); break;
			case 'w': MirrorChangeFrequency(10); break;
			case 'e': MirrorChangeFrequency(1); break;
			case 'r': MirrorChangeFrequency(-1); break;
			case 't': MirrorChangeFrequency(-10); break;
			case 'z': MirrorChangeFrequency(-50); break;
		}
	}
}


void MEMSMenuProcessCommand_b( u8 nUartRead )
{
	// Identification
	switch( nUartRead )
	{
	case 'i':
		MirrorId(0);
		break;
	case 'I':
		MirrorId(1);
		break;
	case 'n':
		MirrorId(2);
		break;
	}
}


void MEMSMenuLoop()
{
	u8	nUartRead;
	if( XUartPs_IsReceiveData(STDIN_BASEADDRESS) )
	{
		nUartRead = (u8) XUartPs_ReadReg(STDIN_BASEADDRESS, XUARTPS_FIFO_OFFSET);
			MEMSMenuProcessCommand_a( nUartRead );
		if(nUartRead != '\r') MEMSMenuDisplay();
		MEMSMenuProcessCommand_b( nUartRead );
	}
}
