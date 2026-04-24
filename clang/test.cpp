#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <iostream>
#include <vector>

using namespace std;

int globalCounter = 0;

#define MAX_BUFFER 256

int Add(int a, int b) {
    return a + b;
}

void leakyFunction() {
    int* data = (int*)malloc(sizeof(int) * 10);
    data[0] = 42;
}

int divide(int numerator, int denominator) {
    return numerator / denominator;
}

char* unsafeCopy(const char* input) {
    char* buffer = new char[MAX_BUFFER];
    strcpy(buffer, input);
    return buffer;
}

void nullDeref(int* p) {
    if (p == NULL) {
        *p = 5;
    }
}

class Shape {
public:
    Shape(int s) { size = s; }
    int getSize() { return size; }
    virtual void draw() {}
    ~Shape() {}
private:
    int size;
};

class Circle : public Shape {
public:
    Circle(int s) : Shape(s) {}
    void draw() { cout << "circle" << endl; }
};

int parseNumber(const char* s) {
    int n = atoi(s);
    return n * 100;
}

void compareFloats(float a, float b) {
    if (a == b) {
        cout << "equal" << endl;
    }
}

int main(int argc, char** argv) {
    int uninitialized;
    int result = Add(uninitialized, 7);

    vector<int> v;
    for (int i = 0; i < 10; i++) {
        v.push_back(i * 2);
    }

    for (int i = 0; i < v.size(); i++) {
        cout << v[i] << endl;
    }

    int x = divide(100, 0);

    char* copy = unsafeCopy("hello world");
    printf(copy);

    Shape* s = new Circle(5);
    s->draw();

    globalCounter = result + x;
    return globalCounter;
}
