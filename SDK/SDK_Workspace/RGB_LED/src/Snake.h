#ifndef Snake_h
#define Snake_h

#include "API.h"
#include <stdlib.h>

typedef enum Direction {
	DIRECTION_LEFT,
	DIRECTION_RIGHT,
	DIRECTION_UP,
	DIRECTION_DOWN,
	DIRECTION_NONE
}
Direction;

typedef struct Snake {
	Pixel pixels[DISP_WIDTH * DISP_HEIGHT];
	unsigned char length;
} Snake;

typedef enum GameStage {
	STAGE_START,
	STAGE_PLAY,
	STAGE_END
} GameStage;

Snake snake;
Pixel food;
GameStage gameStage;

Direction direction;
void UpdateTerrain();
void GameEnd();
static void CreateFood();
void SetGameStage(GameStage stage);
void ChangeColorSnake();


#endif
