Minim minim;
AudioPlayer song;

void loadSound(){
   minim = new Minim(this);
   song = minim.loadFile("theme_extended.mp3", 2048);
   //song.loop();
}
