#include "raylib.h"

// Check if we are compiling for Web
#if defined(PLATFORM_WEB)
    #include <emscripten/emscripten.h>
#endif

// Global variables (Required for Web loop)
const int screenWidth = 800;
const int screenHeight = 450;
Vector2 ballPosition = { 400.0f, 225.0f };
Vector2 ballSpeed = { 5.0f, 4.0f };
int ballRadius = 20;

// The logic that runs every frame
void UpdateDrawFrame(void)
{
    // --- Update ---
    ballPosition.x += ballSpeed.x;
    ballPosition.y += ballSpeed.y;

    if ((ballPosition.x >= (screenWidth - ballRadius)) || (ballPosition.x <= ballRadius)) ballSpeed.x *= -1.0f;
    if ((ballPosition.y >= (screenHeight - ballRadius)) || (ballPosition.y <= ballRadius)) ballSpeed.y *= -1.0f;

    // --- Draw ---
    BeginDrawing();
        ClearBackground(RAYWHITE);
        DrawText("My Raylib Web Game", 10, 10, 20, LIGHTGRAY);
        DrawCircleV(ballPosition, ballRadius, MAROON);
        DrawFPS(10, 40);
    EndDrawing();
}

int main(void)
{
    InitWindow(screenWidth, screenHeight, "Raylib Web Example");

#if defined(PLATFORM_WEB)
    // For web, we let the browser manage the loop
    // 0 means use browser's requestAnimationFrame mechanism (usually 60fps)
    // 1 means simulate infinite loop
    emscripten_set_main_loop(UpdateDrawFrame, 0, 1);
#else
    SetTargetFPS(60);
    // Standard desktop loop
    while (!WindowShouldClose())
    {
        UpdateDrawFrame();
    }
#endif

    CloseWindow();
    return 0;
}
