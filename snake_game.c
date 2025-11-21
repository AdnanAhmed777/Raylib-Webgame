#include "raylib.h"
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define SCREEN_WIDTH 1600
#define SCREEN_HEIGHT 900
#define GRID_SIZE 40
#define GRID_WIDTH (SCREEN_WIDTH / GRID_SIZE)
#define GRID_HEIGHT (SCREEN_HEIGHT / GRID_SIZE)
#define MAX_SNAKE_LENGTH 1000

typedef struct {
    int x;
    int y;
} Position;

typedef struct {
    Position body[MAX_SNAKE_LENGTH];
    int length;
    Position direction;
    Position nextDirection;
} Snake;

typedef struct {
    Position pos;
} Food;

typedef enum {
    MENU,
    PLAYING,
    GAME_OVER
} GameState;

// Function prototypes
void InitGame(Snake *snake, Food *food, int *score);
void MoveSnake(Snake *snake);
void GenerateFood(Food *food, Snake *snake);
bool CheckCollision(Snake *snake);
bool CheckFoodCollision(Snake *snake, Food *food);

int main(void) {
    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "Raylib Snake Game");
    SetTargetFPS(60);
    
    srand(time(NULL));
    
    Snake snake;
    Food food;
    int score = 0;
    int highScore = 0;
    GameState state = MENU;
    float moveTimer = 0.0f;
    float moveDelay = 0.15f;
    
    InitGame(&snake, &food, &score);
    
    while (!WindowShouldClose()) {
        // Update
        if (state == MENU) {
            if (IsKeyPressed(KEY_SPACE) || IsKeyPressed(KEY_ENTER)) {
                state = PLAYING;
                InitGame(&snake, &food, &score);
            }
        }
        else if (state == PLAYING) {
            // Input handling - prevent 180 degree turns
            if (IsKeyPressed(KEY_UP) && snake.direction.y == 0) {
                snake.nextDirection = (Position){0, -1};
            }
            else if (IsKeyPressed(KEY_DOWN) && snake.direction.y == 0) {
                snake.nextDirection = (Position){0, 1};
            }
            else if (IsKeyPressed(KEY_LEFT) && snake.direction.x == 0) {
                snake.nextDirection = (Position){-1, 0};
            }
            else if (IsKeyPressed(KEY_RIGHT) && snake.direction.x == 0) {
                snake.nextDirection = (Position){1, 0};
            }
            
            // Adjust speed based on score
            moveDelay = 0.06f - (score * 0.002f);
            if (moveDelay < 0.05f) moveDelay = 0.05f;
            
            moveTimer += GetFrameTime();
            
            if (moveTimer >= moveDelay) {
                snake.direction = snake.nextDirection;
                MoveSnake(&snake);
                
                // Check collisions
                if (CheckCollision(&snake)) {
                    state = GAME_OVER;
                    if (score > highScore) {
                        highScore = score;
                    }
                }
                
                // Check food collision
                if (CheckFoodCollision(&snake, &food)) {
                    score++;
                    snake.length++;
                    GenerateFood(&food, &snake);
                }
                
                moveTimer = 0.0f;
            }
        }
        else if (state == GAME_OVER) {
            if (IsKeyPressed(KEY_SPACE) || IsKeyPressed(KEY_ENTER)) {
                state = PLAYING;
                InitGame(&snake, &food, &score);
            }
            if (IsKeyPressed(KEY_ESCAPE)) {
                state = MENU;
            }
        }
        
        // Draw
        BeginDrawing();
        ClearBackground((Color){40, 44, 52, 255});
        
        if (state == MENU) {
            // Draw menu
            DrawText("SNAKE GAME", SCREEN_WIDTH / 2 - MeasureText("SNAKE GAME", 60) / 2, 150, 60, GREEN);
            DrawText("Press SPACE or ENTER to Start", SCREEN_WIDTH / 2 - MeasureText("Press SPACE or ENTER to Start", 20) / 2, 300, 20, WHITE);
            DrawText("Use ARROW KEYS to move", SCREEN_WIDTH / 2 - MeasureText("Use ARROW KEYS to move", 20) / 2, 350, 20, LIGHTGRAY);
            
            if (highScore > 0) {
                char highScoreText[50];
                sprintf(highScoreText, "High Score: %d", highScore);
                DrawText(highScoreText, SCREEN_WIDTH / 2 - MeasureText(highScoreText, 30) / 2, 450, 30, YELLOW);
            }
        }
        else if (state == PLAYING) {
            // Draw grid lines
            for (int i = 0; i <= GRID_WIDTH; i++) {
                DrawLine(i * GRID_SIZE, 0, i * GRID_SIZE, SCREEN_HEIGHT, (Color){60, 64, 72, 255});
            }
            for (int i = 0; i <= GRID_HEIGHT; i++) {
                DrawLine(0, i * GRID_SIZE, SCREEN_WIDTH, i * GRID_SIZE, (Color){60, 64, 72, 255});
            }
            
            // Draw snake
            for (int i = 0; i < snake.length; i++) {
                Color bodyColor = (i == 0) ? GREEN : LIME;
                DrawRectangle(
                    snake.body[i].x * GRID_SIZE + 2,
                    snake.body[i].y * GRID_SIZE + 2,
                    GRID_SIZE - 4,
                    GRID_SIZE - 4,
                    bodyColor
                );
                
                // Draw eyes on head
                if (i == 0) {
                    int eyeSize = 3;
                    if (snake.direction.x == 1) { // Right
                        DrawCircle(snake.body[i].x * GRID_SIZE + 30, snake.body[i].y * GRID_SIZE + 12, eyeSize, BLACK);
                        DrawCircle(snake.body[i].x * GRID_SIZE + 30, snake.body[i].y * GRID_SIZE + 28, eyeSize, BLACK);
                    }
                    else if (snake.direction.x == -1) { // Left
                        DrawCircle(snake.body[i].x * GRID_SIZE + 10, snake.body[i].y * GRID_SIZE + 12, eyeSize, BLACK);
                        DrawCircle(snake.body[i].x * GRID_SIZE + 10, snake.body[i].y * GRID_SIZE + 28, eyeSize, BLACK);
                    }
                    else if (snake.direction.y == -1) { // Up
                        DrawCircle(snake.body[i].x * GRID_SIZE + 12, snake.body[i].y * GRID_SIZE + 10, eyeSize, BLACK);
                        DrawCircle(snake.body[i].x * GRID_SIZE + 24, snake.body[i].y * GRID_SIZE + 10, eyeSize, BLACK);
                    }
                    else if (snake.direction.y == 1) { // Down
                        DrawCircle(snake.body[i].x * GRID_SIZE + 12, snake.body[i].y * GRID_SIZE + 30, eyeSize, BLACK);
                        DrawCircle(snake.body[i].x * GRID_SIZE + 24, snake.body[i].y * GRID_SIZE + 30, eyeSize, BLACK);
                    }
                }
            }
            
            // Draw food
            DrawCircle(
                food.pos.x * GRID_SIZE + GRID_SIZE / 2,
                food.pos.y * GRID_SIZE + GRID_SIZE / 2,
                GRID_SIZE / 2 - 2,
                RED
            );
            
            // Draw score
            char scoreText[30];
            sprintf(scoreText, "Score: %d", score);
            DrawText(scoreText, 10, 10, 30, WHITE);
            
            char speedText[30];
            sprintf(speedText, "Speed: %.2fx", 0.15f / moveDelay);
            DrawText(speedText, SCREEN_WIDTH - 150, 10, 20, LIGHTGRAY);
        }
        else if (state == GAME_OVER) {
            // Draw game over screen
            DrawText("GAME OVER!", SCREEN_WIDTH / 2 - MeasureText("GAME OVER!", 60) / 2, 150, 60, RED);
            
            char finalScore[50];
            sprintf(finalScore, "Your Score: %d", score);
            DrawText(finalScore, SCREEN_WIDTH / 2 - MeasureText(finalScore, 30) / 2, 250, 30, WHITE);
            
            if (score == highScore && score > 0) {
                DrawText("NEW HIGH SCORE!", SCREEN_WIDTH / 2 - MeasureText("NEW HIGH SCORE!", 25) / 2, 300, 25, YELLOW);
            }
            
            DrawText("Press SPACE or ENTER to Play Again", SCREEN_WIDTH / 2 - MeasureText("Press SPACE or ENTER to Play Again", 20) / 2, 400, 20, WHITE);
            DrawText("Press ESC to go to Menu", SCREEN_WIDTH / 2 - MeasureText("Press ESC to go to Menu", 20) / 2, 450, 20, LIGHTGRAY);
        }
        
        EndDrawing();
    }
    
    CloseWindow();
    return 0;
}

void InitGame(Snake *snake, Food *food, int *score) {
    *score = 0;
    snake->length = 3;
    snake->direction = (Position){1, 0};
    snake->nextDirection = (Position){1, 0};
    
    // Initialize snake in the middle
    for (int i = 0; i < snake->length; i++) {
        snake->body[i] = (Position){GRID_WIDTH / 2 - i, GRID_HEIGHT / 2};
    }
    
    GenerateFood(food, snake);
}

void MoveSnake(Snake *snake) {
    // Move body segments
    for (int i = snake->length - 1; i > 0; i--) {
        snake->body[i] = snake->body[i - 1];
    }
    
    // Move head in current direction
    snake->body[0].x += snake->direction.x;
    snake->body[0].y += snake->direction.y;
}

void GenerateFood(Food *food, Snake *snake) {
    bool validPosition = false;
    
    while (!validPosition) {
        food->pos.x = rand() % GRID_WIDTH;
        food->pos.y = rand() % GRID_HEIGHT;
        
        validPosition = true;
        // Check if food spawns on snake body
        for (int i = 0; i < snake->length; i++) {
            if (food->pos.x == snake->body[i].x && food->pos.y == snake->body[i].y) {
                validPosition = false;
                break;
            }
        }
    }
}

bool CheckCollision(Snake *snake) {
    Position head = snake->body[0];
    
    // Check wall collision
    if (head.x < 0 || head.x >= GRID_WIDTH || head.y < 0 || head.y >= GRID_HEIGHT) {
        return true;
    }
    
    // Check self collision
    for (int i = 1; i < snake->length; i++) {
        if (head.x == snake->body[i].x && head.y == snake->body[i].y) {
            return true;
        }
    }
    
    return false;
}

bool CheckFoodCollision(Snake *snake, Food *food) {
    return (snake->body[0].x == food->pos.x && snake->body[0].y == food->pos.y);
}
