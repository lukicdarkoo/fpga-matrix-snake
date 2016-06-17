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

static char startLetters[LETTER_NUMBER] = {'S', 't', 'a', 'r', 't'};
static char speedLetters[LETTER_NUMBER] = {'S', 'p', 'e', 'e', 'd'};

static unsigned char startMatrix[4][LETTER_WIDTH] = {
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

static unsigned char speedMatrix[4][LETTER_WIDTH] = {
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
				0b00011000,							/* Letter P */
				0b00100100,
				0b00100100,
				0b00011000,
				0b00111111,
				0b00000000
		},
		{
				0b00000000,							/* Letter E */
				0b00000000,
				0b00000000,
				0b00010010,
				0b00101010,
				0b00101010,
				0b00011100,
				0b00000000,
		},
		{											/* Letter D */
				0b00000000,
				0b00000000,
				0b11111110,
				0b00010100,
				0b00100010,
				0b00100010,
				0b00011100,
				0b00000000
		}
};

int newSpeed;
static int defaultSpeed = 3;
static unsigned char isClicked = 0;

int SetPixelP(Pixel pixel);
int SetPixel(unsigned char x, unsigned char y, unsigned char color);
JOY GetJOY();
void Clear();
void Pause(unsigned int time);
void PrintStartLetter(char _letter, int x, int y);
void PrintSpeedLetter(char _letter, int x, int y);
void PrintStartLetters(char* letters, int x, int y);
void PrintSpeedLetters(char* letters, int x, int y);
int SetSpeed(int speed);
void PrintSpeed(int speed);
short getBit(short value, short position);

#endif /* API_H_ */
