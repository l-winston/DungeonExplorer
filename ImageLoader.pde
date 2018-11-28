import java.util.Scanner;
import java.util.Arrays;

PImage sheet;


PImage[] walls = new PImage[3+3+5+2+4+3+2+6+8+6];
int wallc = 0;
PImage[] columns = new PImage[3];
int columnsc = 0;
PImage[] floors = new PImage[10];
int floorsc = 0;
//edge
//hole
PImage[] doors = new PImage[6];
int doorsc = 0;
PImage[] chests = new PImage[3];
int chestsc = 0;
PImage[] flasks = new PImage[8];
int flasksc = 0;
//skull
//crate
//coin_anim
//ui_heart
//weapon
//tiny_zombie
//goblin
//imp
//skelet
//muddy
//swampy
//zombie
//ice_zombie
//masked_orc
//orc_warrior
//orc_shaman
//nercromancer
//wogol
//chort
//big_zombie
//ogre
//big_demon
//elf_f
//elf_m
//knight_f
//knight_m
//wizzard_f
//wizzard_m


void loadImages() {
  sheet = loadImage("tileset.png");
  String[] data = loadStrings("tileinfo.txt");
  for (int i = 0; i < data.length; i++) {
    //file includes some empty lines, check to skip them
    if (data[i].length() <= 0)
      continue;

    Scanner scan = new Scanner(data[i]);

    // find the type picture the info represents by using the first word (seperated by an underscore character)
    String type;
    int underscore = data[i].indexOf("_");
    // sometimes, the data doensn't contain "_"
    // ex: edge 96 128 16 16
    // in this case, just take first word
    if (underscore == -1) {
      type = scan.next();
    } else {
      type = data[i].substring(0, data[i].indexOf("_"));
      // in the case that the string does contain "_", call scan.next(); so scanner's "cursor" goes to the anyways numbers
      scan.next();
    }

    // store all coordinate info of tile
    int[] coords = new int[5];
    // default # of tiles to 1
    coords[4] = 1;
    int coordsc = 0;
    while (scan.hasNextInt()) {
      coords[coordsc++] = scan.nextInt();
    }

    for (int j = 0; j < coords[4]; j++) {
      switch(type) {
      case "wall":
        break;
      case "column":
        break;
      case "floor":
        break;
      case "doors":
        break;
      case "chest":
        break;
      case "flask":
        break;
      }
    }
  }
}
