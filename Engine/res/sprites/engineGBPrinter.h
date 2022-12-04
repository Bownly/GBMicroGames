//AUTOGENERATED FILE FROM png2asset
#ifndef METASPRITE_engineGBPrinter_H
#define METASPRITE_engineGBPrinter_H

#include <stdint.h>
#include <gbdk/platform.h>
#include <gbdk/metasprites.h>

#define engineGBPrinter_TILE_ORIGIN 64
#define engineGBPrinter_TILE_H 8
#define engineGBPrinter_WIDTH 8
#define engineGBPrinter_HEIGHT 8
#define engineGBPrinter_TILE_COUNT 16
#define engineGBPrinter_MAP_ATTRIBUTES 0
#define engineGBPrinter_TILE_PALS engineGBPrinter_tile_pals

BANKREF_EXTERN(engineGBPrinter)

extern const palette_color_t engineGBPrinter_palettes[4];
extern const uint8_t engineGBPrinter_tiles[256];

extern const unsigned char engineGBPrinter_map[80];
extern const unsigned char* engineGBPrinter_tile_pals[16];

#endif