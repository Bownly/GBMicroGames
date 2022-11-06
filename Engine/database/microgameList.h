/* @brief New games can be added to the GB ROM by adding new entries to this list.
 *
 *        The macro looks like this:
 *        MICROGAME(gameId, gameMainFunction, bankId, duration, name, author, instructions)
 * 
 * @param gameId           The ID the game is associated with
 * @param gameMainFunction The function that will be called to run the game
 * @param bankId           Which bank ID the game code is located in
 * @param duration         How long the game takes until finish
 * @param name             Display name of the game
 * @param author           Author of the game
 * @param instructions     Instructions for the game
 */

#ifdef MICROGAME
MICROGAME(MG_TEMPLATE_FACE, templateFaceMicrogameMain, 1U, 3U, "TEMPLATE FACE GAME", "TEMPLATE DEV", "CHEER UP!")
MICROGAME(MG_BOWNLY_BOW, bownlyBowMicrogameMain, 2U, 4U, "BOW", "BOWNLY", "SHOOT!")
MICROGAME(MG_BOWNLY_MAGIPANELS5, bownlyMP5MicrogameMain, 2U, 4U, "MAGIPANELS 5", "BOWNLY", "INCREASE TO 5!")
MICROGAME(MG_BOWNLY_PASTEL_HEARTS, bownlyPastelHeartsMicrogameMain, 3U, 4U, "PASTEL HEARTS", "BOWNLY", "COLLECT!")
MICROGAME(MG_BOWNLY_PASTEL_DODGE, bownlyPastelDodgeMicrogameMain, 3U, 3U, "PASTEL DODGE", "BOWNLY", "DODGE!")
MICROGAME(MG_BOWNLY_THINGY, bownlyThingyMicrogameMain, 2U, 3U, "THINGY", "BOWNLY", "GET BANANA!")
#endif
