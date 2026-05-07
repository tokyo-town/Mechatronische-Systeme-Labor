
#include "dac.h"



#define SPI_DAC_IREF_ID					XPAR_AXI_DAC_IREF_0_DEVICE_ID
#define SPI_HVDAC_IREF_ID				XPAR_AXI_DAC_IREF_1_DEVICE_ID


static XSpi g_SpiMasterDACiRef;
static XSpi g_SpiMasterHVDACiRef;



int SpiInitMaster(u32 uDeviceID, XSpi *pSpiMaster, u32 uSettings)
{
	XSpi_Config 	*pConfigPtrMaster;
	int 			nStatus;

	// find the device
	pConfigPtrMaster = XSpi_LookupConfig(uDeviceID);
	if (pConfigPtrMaster == NULL)
	{
		xil_printf("LidarSpiInitMaster(), Error finding SPI device ID: %d\n\r", uDeviceID);
		return XST_FAILURE;
	}

	// init the cfg structures
	nStatus = XSpi_CfgInitialize(pSpiMaster, pConfigPtrMaster, pConfigPtrMaster->BaseAddress);
	if (nStatus != XST_SUCCESS)
	{
		xil_printf("LidarSpiInitMaster(), Error initializing SPI master, ID: %d\n\r", uDeviceID);
		return nStatus;
	}

	// perform a self test
	nStatus = XSpi_SelfTest(pSpiMaster);
	if (nStatus != XST_SUCCESS)
	{
		xil_printf("LidarSpiInitMaster(), Error selftesting SPI master\n\r", uDeviceID);
		return nStatus;
	}

	// set the options (polarity, etc.)
	nStatus = XSpi_SetOptions(pSpiMaster, uSettings);
	if (nStatus != XST_SUCCESS)
	{
		xil_printf("LidarSpiInitMaster(), Error setting SPI master options\n\r", uDeviceID);
		return nStatus;
	}

	// start the polling mode
	nStatus = XSpi_Start(pSpiMaster);
	if (nStatus != XST_SUCCESS)
	{
		xil_printf("LidarSpiInitMaster(), Error starting SPI master\n\r", uDeviceID);
		return nStatus;
	}

	XSpi_IntrGlobalDisable(pSpiMaster);

	return XST_SUCCESS;
}

int SpiTransfer(XSpi *pSpiDevice, u8 *pWrite, u8 *pRead, u8 nBytes)
{
	int nStatus;

	// select the slave
	nStatus = XSpi_SetSlaveSelect(pSpiDevice, 0x01);
	if (nStatus != XST_SUCCESS)
	{
		xil_printf("LidarSpiTransfer(), Error selecting SPI slave\n\r");
		return nStatus;
	}

	// perform the data transfer
	nStatus = XSpi_Transfer(pSpiDevice, pWrite, pRead, nBytes);
	if (nStatus != XST_SUCCESS)
	{
		xil_printf("LidarSpiTransfer(), Error transferring data\n\r");
		return nStatus;
	}

	// deselect the slave
	nStatus = XSpi_SetSlaveSelect(pSpiDevice, 0x00);
	if (nStatus != XST_SUCCESS)
	{
		xil_printf("LidarSpiTransfer(), Error deselecting SPI slave\n\r");
		return nStatus;
	}

	return XST_SUCCESS;
}


int MEMSDACiRefSetValue8Bit(u8 nValue)
{
	int nStatus;
	u8  Command[2];

	Command[0] = nValue >> 2;
	Command[1] = (nValue & 0x3) << 6;

	nStatus = SpiTransfer(&g_SpiMasterDACiRef, Command, Command, 2);
	if (nStatus != XST_SUCCESS)
	{
		xil_printf("MEMSDACiRefSetValue8Bit(), Error setting value\n\r");
		return nStatus;
	}

	return XST_SUCCESS;
}


int MEMSDACiRefSetValue12Bit(u16 nValue)
{
	int nStatus;
	u8  Command[2];

	Command[0] = (nValue & 0x0FC0) >> 6;
	Command[1] = (nValue & 0x003F) << 2;

	nStatus = SpiTransfer(&g_SpiMasterDACiRef, Command, Command, 2);
	if (nStatus != XST_SUCCESS)
	{
		xil_printf("MEMSDACiRefSetValue12Bit(), Error setting value\n\r");
		return nStatus;
	}

	return XST_SUCCESS;
}

int MEMSDACiRefSetValue12Bit_HV(u16 nValue)
{
	int nStatus;
	u8  Command[2];

	Command[0] = (nValue & 0x0FC0) >> 6;
	Command[1] = (nValue & 0x003F) << 2;

	nStatus = SpiTransfer(&g_SpiMasterHVDACiRef, Command, Command, 2);
	if (nStatus != XST_SUCCESS)
	{
		xil_printf("MEMSDACiRefSetValue12Bit_HV(), Error setting value\n\r");
		return nStatus;
	}

	return XST_SUCCESS;
}


int MEMSSpiInit()
{
	int 			nStatus;

	nStatus = SpiInitMaster(XPAR_AXI_QUAD_SPI_0_BASEADDR, &g_SpiMasterDACiRef, XSP_MASTER_OPTION);
	if (nStatus != XST_SUCCESS)
	{
		xil_printf("MEMSSpiInit(), Error initializing DAC laser SPI master\n\r");
		return nStatus;
	}

	return XST_SUCCESS;
}

int MEMSSpiInit_HV()
{
	int 			nStatus;

	nStatus = SpiInitMaster(XPAR_AXI_QUAD_SPI_1_BASEADDR, &g_SpiMasterHVDACiRef, XSP_MASTER_OPTION);
	if (nStatus != XST_SUCCESS)
	{
		xil_printf("MEMSSpiInit_HV(), Error initializing DAC HV SPI master\n\r");
		return nStatus;
	}

	return XST_SUCCESS;
}


