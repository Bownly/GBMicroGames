# GBMicroGames (Working title)
This is the repository for whatever this Gameboy microgames jam project ends up getting named.
Link to the jam page on Itch: [https://itch.io/jam/gb-microgames-jam](https://itch.io/jam/gb-microgames-jam)


## Setup - How To
0. Reach out to me (@Bownly) either on Twitter or Itch and let me know that you want to participate. I'll assign a bank number to you.
1. Fork the repo and make a branch off of master.
2. Make a folder in the project's root directory with your Itch name as the folder name. (If you want, you can make a copy of the Template folder and work off of that as a base.)
3. Add a line for your microgame inside *Engine/database/microgameList.h*. The proper format should be pretty self explanatory.
4. In *make.bat*, add a call to your personal *make* file, and add your files to the line at the end that builds the rom. Again, the proper format should be self explanatory.


## New to GBDK?
- [GBDK (4.0.6)](https://github.com/gbdk-2020/gbdk-2020/releases/tag/4.0.6) - You'll definitely need to download this. And note that if your gbdk folder isn't located at C:/gbdk, you'll have to change the makefiles in this project to point to wherever your gbdk folder is located.
- [GBDK docs](https://gbdk-2020.github.io/gbdk-2020/docs/api/docs_getting_started.html) - Honestly, these docs cover pretty much everything you need to know. I learn new stuff every time I visit them. They're great. In fact, ignore this entire section and just read through these docs. Any tip I could give you is already in the docs.
- [hUGETracker](https://github.com/SuperDisk/hUGETracker/releases) - You can use this to make music for you microgames. Well, more like "have to", rather than "can". The engine expects songs exported into .c format from hUGETracker.
- [GBTD/GBMB](https://github.com/gbdk-2020/GBTD_GBMB/releases) - Tools for making gbdk compliant tiles and maps. These aren't technically necessary, but they're pretty decent at what they do.
- [Rom usage tool](https://github.com/bbbbbr/romusage) - Not neccessary by any means, but it's a handy tool for seeing how much bank space you've used up.


## Integrating your microgame with the engine
- Every microgame will have a single main function that will be called every frame. For this function, please stick to the naming convention of *yournameGamenameMicrogameMain()*. (e.g. *bownlyBowMicrogameMain()* for a microgame called Bow made by Bownly)
- Each microgame will have 3 different difficulties (values: 0, 1, 2). You can get the current difficulty by reading the global variable, *mgDifficulty*. Treat this as a readonly variable that the engine will write to before your microgame begins. Its value will remain unchanged for the duration of your microgame, so don't worry about having to make a local copy or anything. It's up to you to determine how to manifest the different levels of difficulty within the context of your microgame.
- Each microgame will have 3 different levels of speed (values: 0, 1, 2). The variable for this is *mgSpeed*. The above explanation for *mgDifficulty* also applies for mgSpeed. Do note that not every microgame will have a way to integrate mgSpeed changes. Like a microgame where you just button mash the A button. In those situations, the speed up that the engine applies to the countdown timer is enough.
- When the player has completed your microgame, set *mgStatus* to *WON* (don't forget to include *Engine/enums.h*). Similarly, set mgStatus to *LOST* if the player has lost your microgame.
- For testing your microgame, head to *phaseInitMicrogameManager()* inside *Engine/microgameManagerState.c*. There you'll see a call to *loadNewMG()*. Pass in your microgame's enum instead. And then look inside *microgameManagerGameLoop()*. Comment out any call to *loadNewMG()* to ensure that the game manager never loads a different microgame. Feel free to play with the calculations for the values of *mgDifficulty* and *mgSpeed*. Just make sure to not commit any of those changes.


## Graphics guidelines
- Don't write any data to the following background tiles: 0x00-0x2F, 0xF0-0xFF.
- Also, don't touch sprite #39.
- Keep the black color of *OBP_0* black. If you don't know what that means, then you probably don't need to worry about it.
- Similarly, don't use the window layer. Like the above items, it's reserved for the countdown timer visuals.


## Audio guidelines
- This project uses hUGEDriver for music. If you're used to using .mod files with gbt_player, switching over will be simple. You can import your .mod files into hUGETracker and export them to GBDK .c format. I've noticed that the import doesn't always work properly, but copy/pasting the patterns from OpenMPT into hUGETracker worked for me whenever importing didn't.
- Don't set the tempo anywhere in your tracks (using F05, etc). That'll mess up the game engine's dynamic song speed logic. Instead, set the Tempo value on the General tab of your song in hUGETracker. The engine will subtract the current value of *mgSpeed* (0-2) from your song's tempo value when it loads the song.
- *hUGEDriver.h* is located inside */hUGETracker/*, so you'll want to change the hUGEDriver include line at the top of your song's exported GBDK .c file to point there instead.
- In your microgame's code, you'll want to add an include to */Engine/songPlayer.h"*.
- When you want to load a new song, call *playSong()* from *songPlayer* instead of *hUGE_init()* from *hUGEDriver*.
- Note that the engine will call *hUGE_dosound()*, so you don't need to worry about calling it inside your code.


## Misc guidelines and tips
- If you end up getting errors to the effect of "missing file: Engine/o/whatever", create a folder called "o" inside the Bownly, Engine, and Template folders.
- Look for *actual template cart art.png* inside */Template/cart art*. For each microgame you make, include an edit of that pic. Don't worry about putting it into the rom or anything. I'll do all of that during the post-jam compilation steps. The only restrictions are that you keep the outline intact, and don't touch the two rows of white pixels towards the top.
- Preface as many files and variables as possible with your username to avoid multiple definition errors. And/or make your variables static when appropriate, for similar reasons.
- Use any and all of the code in the codebase as reference material as much as you'd like. Heck, that's exactly what the entire Template folder is there for.
- Keep all of your work inside of your assigned bank(s), and don't forget that you can fit multiple microgames in a single bank. If you need another bank, let me know and I'll find one for you (if available).
- Try to keep controls consistent and easily intuited by someone playing your microgame for the first time. And don't use the Start button. That's reserved by the engine for pausing.
- If the player times out, the engine will consider it a loss, so not all microgames need to have an explicit lose condition.
- Regardless of how or when a microgame ends, the engine will linger on your microgame until the countdown timer runs out. What this means is that your game logic should keep running in some form after you change mgStatus. Ideally, you could play some victory/loss animations/audio, or something like that. Have fun with it. In fact, have fun with all of this. If you're ever not having fun, I'll come to your house and yell at you until you start having fun.
- Keep microgame instruction strings to a maximum of 18 characters, including spaces. But try to keep them even shorter if possible. (i.e. "SHOOT!" over "SHOOT EVERY TARGET!") The style should be full caps and conclude with an exclamation mark.
- Take a peek at *common.c* and *fade.c*. You might have use for the functions in those files. Those are both in bank 0, so they'll always be accessible to your microgames.
- Don't write to SRAM.
- By all means, please use any of the following global variables freely: *substate*, *curJoypad*, *prevJoypad*, *i*, *j*, *k*, *l*, *m*, *n*, *r*, *animTick*, *animFrame*. For GB dev, it's best to reuse existing variables over instantiating new ones, and that's what these variables are for. Just don't forget to initialize them if you plan on using them.
- When determining a duration value for your microgame, tailor it to a maxed out mgDifficulty and mgSpeed. Ideally, you want it to only be barely clearable under those conditions.
- If you want to contribute a boss microgame, I ask that you please contribute at least one normal microgame first. The difference between a boss microgame and a normal microgame is that the former is a longer experience and has no time limit (but should last no more than ~60s).
- If you want to contribute a mini game (think Pyoro from the original WarioWare), I also ask that you please contribute at least one microgame first. Mini games are basically the equivalent of a stretch goal, and I want to keep the ratio of mini:micro games pretty low.
- This will be a grey cart game, so no Gameboy Color-only features allowed. If this jam goes well, perhaps we can do a GB MicroGames DX jam next year.
- There's an asset sharing thread in the Community tab of the jam page on itch. Please go there and contribute if you can!


## Content guidelines
In terms of subject matter, let's keep it E rated, evergreen, and noncontroversial. Topics to avoid: religion, economics, philosophies, politics, identity politics, non-cartoon violence, sexual content, drug references, irl/current events, memes, swear words, etc. If you're in doubt, ask yourself if it'd be included in the original WarioWare. If you're still in doubt, run the idea by me. I'll veto even a completed microgame if I have to, but I obviously don't want to.


## Legal
I'm not a lawyer, but you won't lose any IP rights or anything for whatever you contribute. I want your stuff to remain yours. And don't include any content from anyone else's IPs, obviously. However, you are encouraged to include content from your own existing IPs. I'm a big sucker for cross-overs and self-references, so please do include content from your previous projects (so long as everything's compliant with the content guidelines, of course).

As for license stuff, throw a license file in your folder to decide the license for your work. If you don't want to mess with that, then you can just let your stuff inherit whatever license I decide to go with for the rest of the code. My current plan is to keep the repo public as a resource for our fellow Gameboy devs. I'll have to figure out a license that allows use of the code, but not the assets/IPs.

Note that this is intended to be a noncommercial project. That said, if the game is good enough, I might look into doing a small physical run of the game (if I can find anyone willing to manufacture and sell carts at cost, that is).


## Submission guidelines
1. Make sure you have the most up to date master code merged into your branch.
2. Create a pull request into master. (Ideally, you should combine every microgame that you made during the jam into a single PR.)
3. Include a link to your PR in your submission form on the gamejam page on itch.
3. Cross your fingers that everything goes well.


## Misc.
Thanks for reading all of the above junk. By the way, if you have any good ideas for a name for this project, let me know. "GB MicroGames" is not a very catchy name. Also, if you want to help contribute art/music to the actual game itself (like for the title screen, etc.), please reach out to me.

(Test)
