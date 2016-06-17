/*
 * API.c
 *
 *  Created on: 23.05.2016.
 *      Author: student
 */

#include "API.h"

int SetPixel(unsigned char x, unsigned char y, unsigned char color) {
	// Return error if location doesn't exist
	if (DISP_WIDTH * y + x >= DISP_WIDTH * DISP_HEIGHT) {
		return ERROR;
	}
	if (x >= DISP_WIDTH) {
		return ERROR;
	}
	if (y >= DISP_HEIGHT) {
		return ERROR;
	}

	unsigned char location = DISP_WIDTH * y + x;

	Xil_Out32(XPAR_LED_MAP_PERIPHERAL_0_BASEADDR + location * 4, color);

	return SUCCESS;
}

JOY GetJOY() {
	unsigned char value = Xil_In32(XPAR_PUSH_BUTTONS_BASEADDR);

	switch (value) {
	case 0xfc:
		return JOY_NONE;
	case 0x7c:
		return JOY_UP;
	case 0xbc:
		return JOY_LEFT;
	case 0xec:
		return JOY_RIGHT;
	case 0xf4:
		return JOY_DOWN;
	case 0xdc:
		return JOY_SELECT;
	}

	return JOY_UNKNOWN;
}

void Clear() {
	unsigned char i;
	for (i = 0; i < DISP_HEIGHT * DISP_WIDTH; i++) {
		Xil_Out32(XPAR_LED_MAP_PERIPHERAL_0_BASEADDR + i * 4, BLACK);
	}
}

int SetPixelP(Pixel pixel) {
	return SetPixel(pixel.x, pixel.y, pixel.color);
}

void Pause(unsigned int time) {
	unsigned long cycles = time * 1000;
	while (cycles > 0) {
		cycles--;
	}
}

void PrintStartLetter(char _letter, int x, int y) {
	int i, j, letterIndex;

	switch(_letter) {
	case 'S':
		letterIndex = 0;
		break;
	case 't':
		letterIndex = 1;
		break;
	case 'a':
		letterIndex = 2;
		break;
	case 'r':
		letterIndex = 3;
		break;
	}
	for (i = 0; i < LETTER_WIDTH; i++) {
		for (j = 0; j < LETTER_WIDTH; j++) {
			SetPixel(i + y/2, j + x, getBit(startMatrix[letterIndex][i], j) ? WHITE : BLACK);
		}
	}
}

void PrintStartLetters(char* letters,int x, int y) {
	JOY joy = JOY_UNKNOWN;

	Clear();

	while(joy != JOY_SELECT) {
		joy = GetJOY();
		if(joy == JOY_SELECT) {
			if(isClicked == 0) {
				isClicked = 1;
				break;
			}
		}
		if (joy == JOY_NONE) {
			isClicked = 0;
		}

		/* x/2 will give letter to letter*/
		PrintStartLetter(letters[0], x, y);
		PrintStartLetter(letters[1], x, y-12);
		PrintStartLetter(letters[2], x, y-20);
		PrintStartLetter(letters[3], x, y-30);
		PrintStartLetter(letters[4], x, y-42);
		y+=2;
		/* (6 + 4 + 5 + 6 + 4 + 7 + 7) * 2 */
		if(y >= 64) {
			y = -14;
		}

		Pause(700);
	}
}

void PrintSpeedLetter(char _letter, int x, int y) {
	int i, j, letterIndex;

	switch(_letter) {
	case 'S':
		letterIndex = 0;
		break;
	case 'p':
		letterIndex = 1;
		break;
	case 'e':
		letterIndex = 2;
		break;
	case 'd':
		letterIndex = 3;
		break;
	}
	for (i = 0; i < LETTER_WIDTH; i++) {
		for (j = 0; j < LETTER_WIDTH; j++) {
			SetPixel(i + y/2, j + x, getBit(speedMatrix[letterIndex][i], j) ? WHITE : BLACK);
		}
	}
}

void PrintSpeedLetters(char* letters,int x, int y) {
	Clear();

	JOY joy = JOY_UNKNOWN;
	while(1) {
		joy = GetJOY();
		if(joy == JOY_SELECT) {
			if(isClicked == 0) {
				isClicked = 1;
				break;
			}
		}
		if (joy == JOY_NONE) {
			isClicked = 0;
		}
		PrintSpeedLetter(letters[0], x, y);
		PrintSpeedLetter(letters[1], x, y-12);
		PrintSpeedLetter(letters[2], x, y-24);
		PrintSpeedLetter(letters[3], x, y-34);
		PrintSpeedLetter(letters[4], x, y-44);
		y+=2;
		/* (6 + 6 + 5 + 5 + 6 + 7 + 7) * 2 */
		if(y >= 70) {
			y = -14;
		}

		Pause(700);
	}
}

void PrintSpeed(int speed) {
	int i;
	Clear();
	for(i = 0; i < speed + 1; i++) {
		SetPixel(7 - (i + 1), 3, RED);
	}
}

int SetSpeed(int speed) {
	JOY joy = JOY_UNKNOWN;
	int ns = speed;

	PrintSpeedLetters(speedLetters, 0, -14);

	while(1) {

		joy = GetJOY();
		PrintSpeed(ns);

		if(joy == JOY_SELECT) {
			if(isClicked == 0) {
				isClicked = 1;
				break;
			}
		}
		if (joy == JOY_RIGHT) {
			if(isClicked == 0) {
				if (ns != 5) {
					ns++;
				}
				isClicked = 1;
			}
		}
		if (joy == JOY_LEFT) {
			if(isClicked == 0) {
				if (ns != 0) {
					ns--;
				}
				isClicked = 1;
			}
		}
		if (joy == JOY_NONE) {
			isClicked = 0;
		}
		Pause(100);
	}

	return 6 - ns;
}

short getBit(short value, short position) {
	return ((1 << position) & value) >> position;
}
