#ifndef SONG_PLAYER_H
#define SONG_PLAYER_H

void playSong(UINT8, UINT8);
void stopSong();
void pauseSong(UINT8 newState);
void songPlayerUpdate();
void playCollisionSfx();
void playHurtSfx();
void playMoveSfx();
void playUnlockSfx();

#endif