/*
 * API.h
 *
 *  Created on: 23.05.2016.
 *      Author: student
 */

#ifndef API_H_
#define API_H_

#include "xparameters.h"
#include "xil_io.h"
#include "platform.h"

#define DISP_WIDTH 8
#define DISP_HEIGHT 8

#define ERROR 0
#define SUCCESS 1

#define LETTER_WIDTH 6
#define LETTER_NUMBER 5
// RGB
#define RED 0b100
#define GREEN 0b010
#define BLUE 0b001
#define WHITE 0b111
#define BLACK 0b000

typedef enum JOY {
	JOY_UP,
	JOY_LEFT,
	JOY_RIGHT,
	JOY_DOWN,
	JOY_SELECT,
	JOY_NONE,
	JOY_UNKNOWN
} JOY;

typedef struct Pixel {
	unsigned char x;
	unsigned char y;
	unsigned char color;
} Pixel;


static unsigned char letterMatrix[4][LETTER_WIDTH] = {
		{											/* Letter S */
				0b000000,
				0b100110,
				0b101001,
				0b101001,
				0b101001,
				0b010001
		},
		{
				0b000000,							/* Letter T */
				0b100000,
				0b100000,
				0b111111,
				0b100000,
				0b100000
		},
		{											/* Letter A */
				0b000000,
				0b111111,
				0b101000,
				0b101000,
				0b101000,
				0b111111
		},
		{											/* Letter R */
				0b000000,
				0b111001,
				0b101010,
				0b101100,
				0b101000,
				0b111111
		}
};

int SetPixelP(Pixel pixel);
int SetPixel(unsigned char x, unsigned char y, unsigned char color);
JOY GetJOY();
void Clear();
void Pause(unsigned int time);
void PrintLetter(char letter, int x, int y);
void PrintLetters(char* letters, int x, int y);
short getBit(short value, short position);

#endif /* API_H_ */
