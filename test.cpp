#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <iostream>

class Shape {
public:
    Shape() {}
    virtual void draw() {}
    ~Shape() {}
private:
    int size;
    int color;
};

class Circle : public Shape {
public:
    Circle() {}
    void draw() { std::cout << "circle" << std::endl; }
};

void nullDeref(int* p) {
    if (p == NULL) {
        *p = 5;
    }
}

int divide(int numerator, int denominator) {
    return numerator / denominator;
}

int main() {
    int uninitialized;
    int result = uninitialized + 7;

    int x = divide(100, 0);

    int* p = NULL;
    nullDeref(p);

    Shape* s = new Circle();
    s->draw();

    const char* fmt = "%s";
    printf(fmt);

    return result + x;
}
