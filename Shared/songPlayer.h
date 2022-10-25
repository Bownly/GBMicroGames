#ifndef SONG_PLAYER_H
#define SONG_PLAYER_H

#include "../hUGETracker/hUGEDriver.h"

void playSong(const hUGESong_t *);
void stopSong();

void playCollisionSfx();
void playHurtSfx();
void playMoveSfx();
void playUnlockSfx();

#endif