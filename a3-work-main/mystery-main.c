/* Complete the C version of the driver program for mystery. This C code does
 * not need to compile. */

#include <stdio.h>

extern long crunch(long, long);

int main(int argc, char *argv[]) {
    if (argc != 3) {
        printf("Two arguments required.\n");
        return 1;
    }

    long a = atol(argv[1]);
    long b = atol(argv[2]);

    long result = crunch(a, b);

    if (result < 0) {
        printf("hat\n");
    } else if (result == 0) {
        printf("tea\n");
    } else {
        printf("beer\n");
    }

    return 0;
}

