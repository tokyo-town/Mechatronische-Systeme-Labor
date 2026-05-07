#ifndef SRC_MEMSREGISTER_H_
#define SRC_MEMSREGISTER_H_

struct MEMSRegister
{
	union
	{
		u32 reg;
		volatile struct
		{
			/*0*/u32 enable: 1; // enable open loop
			/*1-30*/ u32 res: 30;
			/*31*/u32 reset_fpga: 1; // resets entire programmable logic
		};
	/*reg0*/}control;
	/*reg1*/u32 period;
	/*reg2*/u32 soff;
	/*reg3*/u32 son;
	/*reg4*/u32 phase_det_window;
	/*reg5*/u32 ampl_det_window;
	/*reg6*/u32 ampl_det_target;
	/*reg7*/u32 dir_det_point;
	/*reg8*/u32 debugRegister1_i;
	/*reg9*/u32 debugRegister2_i;
	/*reg10*/u32 debugRegister3_i;
	/*reg11*/u32 reserved11;
	/*reg12*/u32 reserved12;
	/*reg13*/u32 reserved13;
	/*reg14*/u32 reserved14;
	/*reg15*/u32 reserved15;
	/*reg16*/u32 reserved16;
	/*reg17*/u32 reserved17;
	/*reg18*/u32 reserved18;
	/*reg19*/u32 reserved19;
	/*reg20*/u32 reserved20;
	/*reg21*/u32 reserved21;
	/*reg22*/u32 reserved22;
	/*reg23*/u32 reserved23;
	/*reg24*/u32 reserved24;
	/*reg25*/u32 reserved25;
	/*reg26*/u32 reserved26;
	/*reg27*/u32 reserved27;
	/*reg28*/u32 reserved28;
	/*reg29*/u32 reserved29;
	/*reg30*/u32 reserved30;
	/*reg31*/u32 reserved31;
	/*reg32*/u32 reserved32;
	/*reg33*/u32 reserved33;
	/*reg34*/u32 reserved34;
	/*reg35*/u32 reserved35;
	/*reg36*/u32 reserved36;
	/*reg37*/u32 reserved37;
	/*reg38*/u32 reserved38;
	/*reg39*/u32 reserved39;
	/*reg40*/u32 reserved40;
	/*reg41*/u32 reserved41;
	/*reg42*/u32 reserved42;
	/*reg43*/u32 reserved43;
	/*reg44*/u32 reserved44;
	/*reg45*/u32 reserved45;
	/*reg46*/u32 reserved46;
	/*reg47*/u32 reserved47;
	/*reg48*/u32 reserved48;
	/*reg49*/u32 reserved49;
	/*reg50*/u32 reserved50;
	/*reg51*/u32 reserved51;
	/*reg52*/u32 reserved52;
	/*reg53*/u32 reserved53;
	/*reg54*/u32 reserved54;
	/*reg55*/u32 reserved55;
	/*reg56*/u32 reserved56;
	/*reg57*/u32 reserved57;
	/*reg58*/u32 reserved58;
	/*reg59*/u32 reserved59;
	/*reg60*/u32 reserved60;
	/*reg61*/u32 reserved61;
	/*reg62*/u32 reserved62;
	/*reg63*/u32 reserved63;
	/*reg64*/u32 reserved64;
	/*reg65*/u32 reserved65;
	/*reg66*/u32 reserved66;
	/*reg67*/u32 reserved67;
	/*reg68*/u32 reserved68;
	/*reg69*/u32 reserved69;
	/*reg70*/u32 reserved70;
	/*reg71*/u32 reserved71;
	/*reg72*/u32 reserved72;
	/*reg73*/u32 reserved73;
	/*reg74*/u32 reserved74;
	/*reg75*/u32 reserved75;
	/*reg76*/u32 reserved76;
	/*reg77*/u32 reserved77;
	/*reg78*/u32 reserved78;
	/*reg79*/u32 reserved79;
	/*reg80*/u32 reserved80;
	/*reg81*/u32 reserved81;
	/*reg82*/u32 reserved82;
	/*reg83*/u32 reserved83;
	/*reg84*/u32 reserved84;
	/*reg85*/u32 reserved85;
	/*reg86*/u32 reserved86;
	/*reg87*/u32 reserved87;
	/*reg88*/u32 reserved88;
	/*reg89*/u32 reserved89;
	/*reg90*/u32 reserved90;
	/*reg91*/u32 reserved91;
	/*reg92*/u32 reserved92;
	/*reg93*/u32 reserved93;
	/*reg94*/u32 reserved94;
	/*reg95*/u32 reserved95;
	/*reg96*/u32 reserved96;
	/*reg97*/u32 reserved97;
	/*reg98*/u32 reserved98;
	/*reg99*/u32 reserved99;
	/*reg100*/u32 reserved100;
	/*reg101*/u32 reserved101;
	/*reg102*/u32 reserved102;
	/*reg103*/u32 reserved103;
	/*reg104*/u32 reserved104;
	/*reg105*/u32 reserved105;
	/*reg106*/u32 reserved106;
	/*reg107*/u32 reserved107;
	/*reg108*/u32 reserved108;
	/*reg109*/u32 reserved109;
	/*reg110*/u32 reserved110;
	/*reg111*/u32 reserved111;
	/*reg112*/u32 reserved112;
	/*reg113*/u32 reserved113;
	/*reg114*/u32 reserved114;
	/*reg115*/u32 reserved115;
	/*reg116*/const u32 debugRegister5;
	/*reg117*/const u32 reserved117;
	/*reg118*/const u32 reserved118;
	/*reg119*/const u32 reserved119;

	/*reg120*/const u32 reserved120;
	/*reg121*/const u32 reserved121;
	/*reg122*/const u32 reserved122;
	/*reg123*/const u32 debugRegister1;
	/*reg124*/const u32 debugRegister2;
	/*reg125*/const u32 debugRegister3;
	/*reg126*/const u32 debugRegister4;
	/*reg127*/const u32 identification_rd_data;
};




#endif /* SRC_MEMSREGISTER_H_ */
