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

int SetPixelP(Pixel pixel);
int SetPixel(unsigned char x, unsigned char y, unsigned char color);
JOY GetJOY();
void Clear();
void Pause(unsigned int time);

#endif /* API_H_ */
