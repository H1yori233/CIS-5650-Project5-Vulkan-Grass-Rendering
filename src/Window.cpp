#include <stdio.h>
#include "Window.h"

namespace {
    GLFWwindow* window = nullptr;
    const char* windowName = nullptr;
}

GLFWwindow* GetGLFWWindow() {
    return window;
}

void InitializeWindow(int width, int height, const char* name) {
    if (!glfwInit()) {
        fprintf(stderr, "Failed to initialize GLFW\n");
        exit(EXIT_FAILURE);
    }

    if (!glfwVulkanSupported()){
        fprintf(stderr, "Vulkan not supported\n");
        exit(EXIT_FAILURE);
    }

    glfwWindowHint(GLFW_CLIENT_API, GLFW_NO_API);
    windowName = name;
    window = glfwCreateWindow(width, height, name, nullptr, nullptr);

    if (!window) {
        fprintf(stderr, "Failed to initialize GLFW window\n");
        glfwTerminate();
        exit(EXIT_FAILURE);
    }
}

bool ShouldQuit() {
    return !!glfwWindowShouldClose(window);
}

void DestroyWindow() {
    glfwDestroyWindow(window);
    glfwTerminate();
}

void UpdateWindowTitle(double frameRate) {
    char title[256];
    sprintf(title, "%s - FPS: %.1f", windowName, frameRate);
    glfwSetWindowTitle(window, title);
}
