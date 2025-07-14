#include <iostream>
using namespace std;

void unusedFunction() {
    int x = 42;
}

int main() {
    int a;
    int b = a + 5;
    int* ptr = NULL;
    if (ptr) {
        cout << *ptr << endl;
    }
    return 0;
}

