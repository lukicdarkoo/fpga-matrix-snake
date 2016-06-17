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

void PrintLetter(char _letter, int x, int y) {
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
			SetPixel(i + y/2, j + x, getBit(letterMatrix[letterIndex][i], j) ? WHITE : BLACK);
		}
	}
}

void PrintLetters(char* letters,int x, int y) {
	while(GetJOY() != JOY_SELECT) {
		Clear();
		/* x/2 will give letter to letter*/
		PrintLetter(letters[0], x, y);
		PrintLetter(letters[1], x, y-12);
		PrintLetter(letters[2], x, y-20);
		PrintLetter(letters[3], x, y-30);
		PrintLetter(letters[4], x, y-42);
		y+=2;
		/* (6 + 4 + 5 + 6 + 4 + 7 + 7) * 2 */
		if(y >= 64) {
			y = -14;
		}

		Pause(1000);
	}
}

short getBit(short value, short position) {
	return ((1 << position) & value) >> position;
}
