
#include "interrupt.h"



#define TIMER_DEVICE_ID		XPAR_SCUTIMER_DEVICE_ID

u32				g_nDeltaInterruptTime = 0;
XScuTimer 		g_Timer;

XScuGic 		g_XIntc;
XScuGic_Config 	*g_pGicConfig;
u32			    g_nInterruptEventsZeroCrossing = 0;



extern void MirrorInterrupt(void *baseaddr_p);





int MirrorInterruptInitialize()
{
	u32 nStatus;
    //initialize the GIC
    g_pGicConfig = XScuGic_LookupConfig(XPAR_XSCUGIC_0_BASEADDR);
	xil_printf("1\n\r");

    nStatus = XScuGic_CfgInitialize(&g_XIntc, g_pGicConfig, g_pGicConfig->CpuBaseAddress);
    if(nStatus != XST_SUCCESS)
    {
    	xil_printf("Error initializing Interrupt Controller: 0x%x\n\r", nStatus);
    }

	XScuGic_SetPriorityTriggerType(&g_XIntc, MEMS_ZERO_CROSSING_INTERRUPT_ID, 0x00, 0x3);

	nStatus = XScuGic_Connect(&g_XIntc, MEMS_ZERO_CROSSING_INTERRUPT_ID, (Xil_ExceptionHandler)MirrorInterrupt, 0);
	if(nStatus != XST_SUCCESS)
	{
		xil_printf("Error connecting Interrupt Controller for ZC interrupt: 0x%x\n\r", nStatus);
	}
	XScuGic_Enable(&g_XIntc, MEMS_ZERO_CROSSING_INTERRUPT_ID);

	Xil_ExceptionInit();
	Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT, (Xil_ExceptionHandler) XScuGic_InterruptHandler, (void *) &g_XIntc);
	Xil_ExceptionEnable();

    return XST_SUCCESS;
}
