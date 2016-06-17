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

#define LETTER_WIDTH 8
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
		{
				0b00000000,							/* Letter S */
				0b00000000,
				0b01001100,
				0b10010010,
				0b10010010,
				0b10010010,
				0b01100010,
				0b00000000
		},
		{
				0b00000000,
				0b00000000,
				0b00000000,							/* Letter T */
				0b00000000,
				0b00100010,
				0b01111100,
				0b00100000,
				0b00000000
		},
		{
				0b00000000,							/* Letter A */
				0b00000000,
				0b00000000,
				0b00011110,
				0b00101010,
				0b00101010,
				0b00000100,
				0b00000000,
		},
		{											/* Letter R */
				0b00000000,
				0b00000000,
				0b00010000,
				0b00100000,
				0b00100000,
				0b00010000,
				0b00111110,
				0b00000000
		}
};

static int defaultSpeed = 3; /* Speed can go from 0 to 6 */
static int newSpeed;

int SetPixelP(Pixel pixel);
int SetPixel(unsigned char x, unsigned char y, unsigned char color);
JOY GetJOY();
void Clear();
void Pause(unsigned int time);
void PrintLetter(char letter, int x, int y);
void PrintLetters(char* letters, int x, int y);
short getBit(short value, short position);

#endif /* API_H_ */
