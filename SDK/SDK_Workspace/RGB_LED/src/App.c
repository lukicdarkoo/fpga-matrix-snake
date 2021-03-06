/*
 * Copyright (c) 2009-2012 Xilinx, Inc.  All rights reserved.
 *
 * Xilinx, Inc.
 * XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS" AS A
 * COURTESY TO YOU.  BY PROVIDING THIS DESIGN, CODE, OR INFORMATION AS
 * ONE POSSIBLE   IMPLEMENTATION OF THIS FEATURE, APPLICATION OR
 * STANDARD, XILINX IS MAKING NO REPRESENTATION THAT THIS IMPLEMENTATION
 * IS FREE FROM ANY CLAIMS OF INFRINGEMENT, AND YOU ARE RESPONSIBLE
 * FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE FOR YOUR IMPLEMENTATION.
 * XILINX EXPRESSLY DISCLAIMS ANY WARRANTY WHATSOEVER WITH RESPECT TO
 * THE ADEQUACY OF THE IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO
 * ANY WARRANTIES OR REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE
 * FROM CLAIMS OF INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY
 * AND FITNESS FOR A PARTICULAR PURPOSE.
 *
 */

/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include <stdio.h>
#include "xparameters.h"
#include "xil_io.h"
#include "platform.h"
#include "API.h"
#include "Snake.h"

int main() {
    init_platform();
    GameStage gStage;
    JOY joy;
    SetGameStage(STAGE_START);

	unsigned int timer = 0;
	while (1) {
		if (timer == 10) {
			timer = 0;
			if(GetGameStage() != STAGE_START && GetGameStage() != STAGE_SETSPEED) {
				UpdateTerrain();
			}
		} else {
			timer++;
		}

		gStage = GetGameStage();

		switch (GetJOY()) {
		case JOY_NONE:
			isClicked = 0;
			break;
		case JOY_DOWN:
			if(isClicked == 0) {
				if (direction != DIRECTION_DOWN) {
					direction = DIRECTION_UP;
				}
			}
			isClicked = 1;
			break;
		case JOY_UP:
			if (isClicked == 0) {
				if (direction != DIRECTION_UP) {
					direction = DIRECTION_DOWN;
				}
			}
			isClicked = 1;
			break;
		case JOY_RIGHT:
			if (isClicked == 0) {
				if (direction != DIRECTION_RIGHT) {
					direction = DIRECTION_LEFT;
				}
			}
			isClicked = 1;
			break;
		case JOY_LEFT:
			if (isClicked == 0) {
				if (direction != DIRECTION_LEFT) {
					direction = DIRECTION_RIGHT;
				}
			}
			isClicked = 1;
			break;

		case JOY_SELECT:
			if (isClicked == 0) {
				if (gStage == STAGE_START) {
					SetGameStage(STAGE_SETSPEED);
				}
			}
			isClicked = 1;
			break;
		}
		Pause((newSpeed + 1) * 50);
	}

    return 0;
}
