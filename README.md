# GBMicroGames (Working title)
What if WarioWare, but real? This is the repository for whatever this Gameboy microgames jam project ends up getting named.


##Setup - how to
1. Clone the repo and make a branch off of master.
2. Make a folder in your project's root directory with your Itch name as the folder name.
3. Add a value for your microgame to the *MICROGAME* enum in *enums.h*. The name should follow the naming convention of *MG_YOURNAME_MICROGAMENAME*
4. Navigate to *Shared/database/microgameData.c*. In there, add an entry for your microgame.
5. In *main.c*, add an #include line for your main c file
6. Still in *main.c*, add a *case* for your microgame that calls your main function to the switch statement around line ~150. Just follow the pattern of the other cases. Note that your main function will be called every frame, and will be the only entry point to your microgame's code.
7. In *make.bat*, add a call to your personal *make* file, and add your files to the line at the end that builds the rom.


##Integrating your microgame with the engine:
- As mentioned above, every microgame will have a single main function that will be called every frame. For this function, please stick to the naming convention of *yournameGamenameMicrogameMain()*. (e.g. *bownlyBowMicrogameMain()* for a microgame called Bow made by Bownly)
- Each microgame will have 3 different difficulties (values: 0, 1, 2). You can get the current difficulty by reading the global variable, *mgDifficulty*. This is a readonly variable that the engine will write to before your microgame begins. Its value will remain unchanged for the duration of your microgame, so don't worry about having to make a local copy or anything. It's up to you to determine how to manifest the different levels of difficulty within the context of your microgame.
- Each microgame will have 3 different levels of speed (values: 0, 1, 2). The variable for this is *mgSpeed*. The above explanation for *mgDifficulty* also applies for mgSpeed.
- When the player has completed your microgame, set *mgStatus* to *WON* (don't forget to include *Shared/enums.h*). Similarly, set mgStatus to *LOST* if the player has lost your microgame.


##Things to keep in mind:
- Use any and all of the code in the codebase as reference material as much as you'd like. Heck, that's explicitly what *Shared/states/sharedTemplateMicrogame.c* is there for.
- Don't write any data to the last row of sprites/background tiles (0xF0-0xFF).
- Keep all of your work inside of your assigned bank(s), and don't forget that you can fit multiple microgames in a single bank. If you need another bank, let me know and I'll find one for you (if available).
- Try to keep controls consistent and easily intuited by someone playing your microgame for the first time. And don't use the Start button. That's reserved by the engine for pausing.
- If the player times out, the engine will consider it a loss, so not all microgames need to have an explicit *LOST* status.
- Regardless of how a microgame ends, expect the engine to take a second or two to transition away from your microgame. What this means is that your game logic should keep running in some form after you change mgStatus. Ideally, you could play some victory/loss animations/audio, or something like that.
- Keep instruction strings to a maximum of 18 characters, including spaces. But try to keep them even shorter if possible. (i.e. "SHOOT!" over "SHOOT EVERY TARGET!") The style should be full caps and conclude with an exclamation mark.
- Take a peek at *common.c* and *fade.c*. You might have use for the functions in those files. Those are both in bank 0, so they'll always be accessible to your microgames.
- Don't write to RAM.
- By all means, please use any of the following global variables freely: *substate*, *curJoypad*, *prevJoypad*, *i*, *j*, *k*, *l*, *m*, *n*, *r*, *animTick*, *animFrame*. For GB dev, it's best to reuse existing variables over instantiating new ones, and that's what these variables are for. Just don't forget to initialize them if you plan on using them.

Content guidelines:
You are encouraged to include content from your own existing IPs, but don't include anything from anyone else's IPs. In terms of subject matter, let's keep it E rated, evergreen, and noncontroversial. Topics to avoid: religion, economics, philosophies, politics, identity politics, non-cartoon violence, sexual content, drug references, irl/current events, memes, swear words, etc. If you're in doubt, ask yourself if it'd be included in the original WarioWare. If you're still in doubt, run the idea by me. I'll even veto a completed game if I have to, but I obviously don't want to.
