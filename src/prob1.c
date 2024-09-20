#include <stdlib.h>
#include <stdio.h>
#include <inttypes.h>

uint64_t euler(int finish) {
    uint64_t ans;
    for (uint64_t i = 1; i < finish; ++i) {
        if (i % 3 == 0 || i % 5 == 0) ans += i;
    }
    return ans;
}

int main() {
    printf("%s\n", euler(1000) == 233168 ? "True" : "False");
}