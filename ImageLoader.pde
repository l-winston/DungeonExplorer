import java.util.Scanner;
import java.util.Arrays;

PImage sheet;

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
    String name = scan.next();

    //nt underscore = data[i].indexOf("_");
    // sometimes, the data doensn't contain "_"
    // ex: edge 96 128 16 16
    // in this case, just take first word
    //if (underscore == -1) {
    // type = scan.next();
    // } else {
    // type = data[i].substring(0, data[i].indexOf("_"));
    // in the case that the string does contain "_", call scan.next(); so scanner's "cursor" goes to the anyways numbers
    //scan.next();
    // }

    // store all coordinate info of tile
    int[] coords = new int[5];
    // default # of tiles to 1
    coords[4] = 1;
    int coordsc = 0;
    while (scan.hasNextInt()) {
      coords[coordsc++] = scan.nextInt();
    }

    scan.close();

    for (int j = 0; j < coords[4]; j++) {
      PImage tile = sheet.get(coords[0], coords[1], coords[2], coords[3]);

      if (startsWith(name, "wall")) {

        if (startsWith(name, "wall_fountain_mid_red_anim")) {
          wall_fountain_mid_red_anim[j] = tile;
        } else if (startsWith(name, "wall_fountain_basin_red_anim")) {
          wall_fountain_basin_red_anim[j] = tile;
        } else if (startsWith(name, "wall_fountain_mid_blue_anim")) {
          wall_fountain_mid_blue_anim[j] = tile;
        } else if (startsWith(name, "wall_fountain_basin_blue_anim")) {
          wall_fountain_basin_blue_anim[j] = tile;
        } else {
          walls[wallc++] = tile;
        }
      } else if (startsWith(name, "column")) {
        columns[columnc++] = tile;
      } else if (startsWith(name, "floor")) {
        if (startsWith(name, "floor_spikes_anim")) {
          floor_spikes_anim[j] = tile;
        } else {
          floors[floorc++] = tile;
        }
      } else if (startsWith(name, "doors")) {
        doors[doorc++] = tile;
      } else if (startsWith(name, "chest")) {
        if (startsWith(name, "chest_empty_open_anim")) {
          chest_empty_open_anim[j] = tile;
        } else if (startsWith(name, "chest_full_open_anim")) {
          chest_full_open_anim[j] = tile;
        } else if (startsWith(name, "chest_mimic_open_anim")) {
          chest_mimic_open_anim[j] = tile;
        }
      } else if (startsWith(name, "flask")) {
        flasks[flaskc++] = tile;
      } else if (startsWith(name, "coin_anim")) {
        coin_anim[j] = tile;
      }

      coords[0] += coords[2];
    }
  }
}

//returns whether b starts with a
boolean startsWith(String b, String a) {
  if (a.length() > b.length())
    return false;

  for (int i = 0; i < a.length(); i++) {
    if (a.charAt(i) != b.charAt(i))
      return false;
  }

  return true;
}
