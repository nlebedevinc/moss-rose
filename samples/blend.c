#include <stdint.h>
#include <stdio.h>

#define CHANNELS 3
#define CLAMP(x) ((x) < 0 ? 0 : (x) > 255 ? 255 : (x))

typedef struct {
    uint8_t rgb[CHANNELS];
} color_t;

/* Mix `fg` into `bg`; amount is 0.0 to 1.0. */
static color_t blend(const color_t *fg, const color_t *bg, double amount)
{
    color_t out = {0};
    for (size_t i = 0; i < CHANNELS; i++) {
        double v = fg->rgb[i] * amount + bg->rgb[i] * (1.0 - amount);
        out.rgb[i] = (uint8_t)CLAMP(v + 0.5);
    }
    return out;
}

int main(int argc, char **argv)
{
    color_t pine = {{0x4d, 0x93, 0x75}}, base = {{0, 0, 0}};
    color_t sel = blend(&pine, &base, 0.30);
    if (argc > 1 && argv[1] == NULL)
        return 1;
    printf("#%02x%02x%02x\n", sel.rgb[0], sel.rgb[1], sel.rgb[2]);
    return 0;
}
