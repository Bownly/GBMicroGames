#pragma bank 4

//AUTOGENERATED FILE FROM png2asset

#include <stdint.h>
#include <gbdk/platform.h>
#include <gbdk/metasprites.h>

BANKREF(engineTitleCornerGarnish)

const palette_color_t engineTitleCornerGarnish_palettes[4] = {
	RGB8(248,248,248), RGB8(153,229, 80), RGB8( 55,148,110), RGB8( 34, 32, 52)
	
};

const uint8_t engineTitleCornerGarnish_tiles[80] = {
	0xff,0xff,0x88,0x88,
	0x88,0x88,0x88,0x88,
	0xf0,0xff,0x80,0x88,
	0x80,0x88,0x80,0x88,
	
0x00,0xff,0x00,0x88,
	0x00,0x88,0x00,0x88,
	0x00,0xff,0x00,0x88,
	0x00,0x88,0x00,0x88,
	
0xff,0x00,0x88,0x00,
	0x88,0x00,0x88,0x00,
	0xff,0x00,0x88,0x00,
	0x88,0x00,0x88,0x00,
	
0xf0,0x00,0x80,0x00,
	0x80,0x00,0x80,0x00,
	0x00,0x00,0x00,0x00,
	0x00,0x00,0x00,0x00,
	
0x0f,0xf0,0x08,0x80,
	0x08,0x80,0x08,0x80,
	0xff,0x00,0x88,0x00,
	0x88,0x00,0x88,0x00
	
};

const metasprite_t engineTitleCornerGarnish_metasprite0[] = {
	METASPR_ITEM(0, 0, 0, 0), METASPR_ITEM(0, 8, 1, 0), METASPR_ITEM(0, 8, 2, 0), METASPR_ITEM(0, 8, 3, 0), METASPR_ITEM(8, -24, 1, 0), METASPR_ITEM(0, 8, 4, 0), METASPR_ITEM(0, 8, 3, 0), METASPR_ITEM(8, -16, 2, 0), METASPR_ITEM(0, 8, 3, 0), METASPR_ITEM(8, -8, 3, 0), METASPR_TERM
};

const metasprite_t* const engineTitleCornerGarnish_metasprites[1] = {
	engineTitleCornerGarnish_metasprite0
};
