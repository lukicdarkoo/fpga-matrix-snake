#include "Snake.h"


void UpdateTerrain() {
	// Do nothing if game end
	if (gameStage == STAGE_END) {
		return;
	}

	unsigned char i;

	// Print food
	SetPixelP(food);



	// Define Snake's head position
	Pixel pixelHead = snake.pixels[snake.length - 1];
	switch (direction)
	{
	case DIRECTION_UP:
		if (pixelHead.y == 0) {
			GameEnd();
			return;
		}
		else {
			pixelHead.y--;
		}
		break;
	case DIRECTION_DOWN:
		if (pixelHead.y == DISP_HEIGHT - 1) {
			GameEnd();
			return;
		}
		else {
			pixelHead.y++;
		}
		break;
	case DIRECTION_LEFT:
		if (pixelHead.x == 0) {
			GameEnd();
			return;
		}
		else {
			pixelHead.x--;
		}
		break;
	case DIRECTION_RIGHT:
		if (pixelHead.y == DISP_WIDTH - 1) {
			GameEnd();
			return;
		}
		else {
			pixelHead.x++;
		}
		break;
	}

	// Game end if snake eats self
	for (i = 0; i < snake.length; i++) {
		if (pixelHead.x == snake.pixels[i].x &&
			pixelHead.y == snake.pixels[i].y) {

			GameEnd();
			return;
		}
	}

	// Move tale. If it ate a food make it bigger else move.
	if (pixelHead.x == food.x && pixelHead.y == food.y) {
		snake.length++;
		CreateFood();
	}
	else {
		SetPixel(snake.pixels[0].x, snake.pixels[0].y, BLACK);
		for (i = 0; i < snake.length - 1; i++) {
			snake.pixels[i] = snake.pixels[i + 1];
		}
	}
	snake.pixels[snake.length - 1] = pixelHead;


	// Print snake
	for (i = 0; i < snake.length; i++) {
		SetPixelP(snake.pixels[i]);
	}
}

void SetGameStage(GameStage _stage) {
	switch (_stage) {
	case STAGE_PLAY:
		Clear();
		gameStage = STAGE_PLAY;

		direction = DIRECTION_RIGHT;

		// Food
		food.color = rand() % 7 + 1;
		food.x = 5;
		food.y = 5;

		// Snake
		snake.pixels[0].x = 1;
		snake.pixels[0].y = 1;
		snake.pixels[0].color = RED;
		snake.pixels[1].x = 1;
		snake.pixels[1].y = 1;
		snake.pixels[1].color = RED;
		snake.length = 2;
		break;
	case STAGE_END:
		gameStage = STAGE_END;
		break;
	}
}

void CreateFood() {
	unsigned char i;

	unsigned char found = 0;

	unsigned char fx = rand() % 8;
	unsigned char fy = rand() % 8;

	while (!found) {
		fx = rand() % 8;
		fy = rand() % 8;
		found = 1;
		for (i = 0; i < snake.length; i++) {
			if(fx == snake.pixels[i].x && fy == snake.pixels[i].y) {
				found = 0;
				break;
			}
		}

	}

	food.color = rand() % 7 + 1;
	food.x = fx;
	food.y = fy;
}

void GameEnd() {
	SetGameStage(STAGE_END);

	// Print game end
	unsigned char i, j;
	for (i = 0; i < DISP_WIDTH; i++) {
		for (j = 0; j < DISP_HEIGHT; j++) {
			SetPixel(i, j, WHITE);
		}
	}
}

/*void ChangeColorSnake() {

	unsigned char i;

	for(i = 0; i < snake.length; i++) {
		snake.pixels[i].color = food.color;
	}
}*/
