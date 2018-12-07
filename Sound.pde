Minim minim;
AudioPlayer song;

void loadSound(){
   minim = new Minim(this);
   song = minim.loadFile("sound/theme_extended.mp3", 2048);
}
