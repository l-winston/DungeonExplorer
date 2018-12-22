import java.util.Scanner;
import java.util.Arrays;

PImage sheet;

void loadImages() {
  // load main spritesheet
  sheet = loadImage("game/tileset.png");

  // store all data in a String array
  String[] data = loadStrings("game/tileinfo.txt");
  for (int i = 0; i < data.length; i++) {
    //file includes some empty lines, check to skip them
    if (data[i].length() <= 0)
      continue;

    // create a scanner to parse the data
    Scanner scan = new Scanner(data[i]);

    // find the type picture the info represents by using the first word (seperated by an underscore character)
    String name = scan.next();

    // store all coordinate info of tile
    int[] coords = new int[5];
    // default # of tiles to 1
    coords[4] = 1;
    int coordsc = 0;
    while (scan.hasNextInt()) {
      coords[coordsc++] = scan.nextInt();
    }

    scan.close();

    // iterate for each frame in the animation (if it is an image, coords[4] = 1)
    for (int j = 0; j < coords[4]; j++) {

      // get the specified area
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
      } else if (startsWith(name, "tiny_zombie_idle_anim")) {
        tiny_zombie_idle_anim[j] = tile;
      } else if (startsWith(name, "tiny_zombie_run_anim")) {
        tiny_zombie_run_anim[j] = tile;
      } else if (startsWith(name, "goblin_idle_anim")) {
        goblin_idle_anim[j] = tile;
      } else if (startsWith(name, "goblin_run_anim")) {
        goblin_run_anim[j] = tile;
      } else if (startsWith(name, "imp_idle_anim")) {
        imp_idle_anim[j] = tile;
      } else if (startsWith(name, "imp_run_anim")) {
        imp_run_anim[j] = tile;
      } else if (startsWith(name, "skelet_idle_anim")) {
        skelet_idle_anim[j] = tile;
      } else if (startsWith(name, "skelet_run_anim")) {
        skelet_run_anim[j] = tile;
      } else if (startsWith(name, "muddy_idle_anim")) {
        muddy_idle_anim[j] = tile;
      } else if (startsWith(name, "muddy_run_anim")) {
        muddy_run_anim[j] = tile;
      } else if (startsWith(name, "swampy_idle_anim")) {
        swampy_idle_anim[j] = tile;
      } else if (startsWith(name, "swampy_run_anim")) {
        swampy_run_anim[j] = tile;
      } else if (startsWith(name, "zombie_idle_anim")) {
        zombie_idle_anim[j] = tile;
      } else if (startsWith(name, "zombie_run_anim")) {
        zombie_run_anim[j] = tile;
      } else if (startsWith(name, "ice_zombie_idle_anim")) {
        ice_zombie_idle_anim[j] = tile;
      } else if (startsWith(name, "ice_zombie_run_anim")) {
        ice_zombie_run_anim[j] = tile;
      } else if (startsWith(name, "masked_orc_idle_anim")) {
        masked_orc_idle_anim[j] = tile;
      } else if (startsWith(name, "masked_orc_run_anim")) {
        masked_orc_run_anim[j] = tile;
      } else if (startsWith(name, "orc_warrior_idle_anim")) {
        orc_warrior_idle_anim[j] = tile;
      } else if (startsWith(name, "orc_warrior_run_anim")) {
        orc_warrior_run_anim[j] = tile;
      } else if (startsWith(name, "orc_shaman_idle_anim")) {
        orc_shaman_idle_anim[j] = tile;
      } else if (startsWith(name, "orc_shaman_run_anim")) {
        orc_shaman_run_anim[j] = tile;
      } else if (startsWith(name, "necromancer_idle_anim")) {
        necromancer_idle_anim[j] = tile;
      } else if (startsWith(name, "necromancer_run_anim")) {
        necromancer_run_anim[j] = tile;
      } else if (startsWith(name, "wogol_idle_anim")) {
        wogol_idle_anim[j] = tile;
      } else if (startsWith(name, "wogol_run_anim")) {
        wogol_run_anim[j] = tile;
      } else if (startsWith(name, "chort_idle_anim")) {
        chort_idle_anim[j] = tile;
      } else if (startsWith(name, "chort_run_anim")) {
        chort_run_anim[j] = tile;
      } else if (startsWith(name, "big_zombie_idle_anim")) {
        big_zombie_idle_anim[j] = tile;
      } else if (startsWith(name, "big_zombie_run_anim")) {
        big_zombie_run_anim[j] = tile;
      } else if (startsWith(name, "ogre_idle_anim")) {
        ogre_idle_anim[j] = tile;
      } else if (startsWith(name, "ogre_run_anim")) {
        ogre_run_anim[j] = tile;
      } else if (startsWith(name, "big_demon_idle_anim")) {
        big_demon_idle_anim[j] = tile;
      } else if (startsWith(name, "big_demon_run_anim")) {
        big_demon_run_anim[j] = tile;
      } else if (startsWith(name, "elf_f_idle_anim")) {
        elf_f_idle_anim[j] = tile;
      } else if (startsWith(name, "elf_f_run_anim")) {
        elf_f_run_anim[j] = tile;
      } else if (startsWith(name, "elf_f_hit_anim")) {
        elf_f_hit_anim = tile;
      } else if (startsWith(name, "elf_m_idle_anim")) {
        elf_m_idle_anim[j] = tile;
      } else if (startsWith(name, "elf_m_run_anim")) {
        elf_m_run_anim[j] = tile;
      } else if (startsWith(name, "elf_m_hit_anim")) {
        elf_m_hit_anim = tile;
      } else if (startsWith(name, "knight_f_idle_anim")) {
        knight_f_idle_anim[j] = tile;
      } else if (startsWith(name, "knight_f_run_anim")) {
        knight_f_run_anim[j] = tile;
      } else if (startsWith(name, "knight_f_hit_anim")) {
        knight_f_hit_anim = tile;
      } else if (startsWith(name, "knight_m_idle_anim")) {
        knight_m_idle_anim[j] = tile;
      } else if (startsWith(name, "knight_m_run_anim")) {
        knight_m_run_anim[j] = tile;
      } else if (startsWith(name, "knight_m_hit_anim")) {
        knight_m_hit_anim = tile;
      } else if (startsWith(name, "wizzard_f_idle_anim")) {
        wizzard_f_idle_anim[j] = tile;
      } else if (startsWith(name, "wizzard_f_run_anim")) {
        wizzard_f_run_anim[j] = tile;
      } else if (startsWith(name, "wizzard_f_hit_anim")) {
        wizzard_f_hit_anim = tile;
      } else if (startsWith(name, "wizzard_m_idle_anim")) {
        wizzard_m_idle_anim[j] = tile;
      } else if (startsWith(name, "wizzard_m_run_anim")) {
        wizzard_m_run_anim[j] = tile;
      } else if (startsWith(name, "wizzard_m_hit_anim")) {
        wizzard_m_hit_anim = tile;
      } else if (startsWith(name, "weapon_knife")) {
        weapon_knife = tile;
      } else if (startsWith(name, "weapon_rusty_sword")) {
        weapon_rusty_sword = tile;
      } else if (startsWith(name, "weapon_regular_sword")) {
        weapon_regular_sword = tile;
      } else if (startsWith(name, "weapon_red_gem_sword")) {
        weapon_red_gem_sword = tile;
      } else if (startsWith(name, "weapon_big_hammer")) {
        weapon_big_hammer = tile;
      } else if (startsWith(name, "weapon_hammer")) {
        weapon_hammer = tile;
      } else if (startsWith(name, "weapon_baton_with_spikes")) {
        weapon_baton_with_spikes = tile;
      } else if (startsWith(name, "weapon_mace")) {
        weapon_mace = tile;
      } else if (startsWith(name, "weapon_katana")) {
        weapon_katana = tile;
      } else if (startsWith(name, "weapon_saw_sword")) {
        weapon_saw_sword = tile;
      } else if (startsWith(name, "weapon_anime_sword")) {
        weapon_anime_sword = tile;
      } else if (startsWith(name, "weapon_axe")) {
        weapon_axe = tile;
      } else if (startsWith(name, "weapon_machete")) {
        weapon_machete = tile;
      } else if (startsWith(name, "weapon_cleaver")) {
        weapon_cleaver = tile;
      } else if (startsWith(name, "weapon_duel_sword")) {
        weapon_duel_sword = tile;
      } else if (startsWith(name, "weapon_knight_sword")) {
        weapon_knight_sword = tile;
      } else if (startsWith(name, "weapon_golden_sword")) {
        weapon_golden_sword = tile;
      } else if (startsWith(name, "weapon_lavish_sword")) {
        weapon_lavish_sword = tile;
      } else if (startsWith(name, "weapon_red_magic_staff")) {
        weapon_red_magic_staff = tile;
      } else if (startsWith(name, "weapon_green_magic_staff")) {
        weapon_green_magic_staff = tile;
      }

      // shift over the position
      coords[0] += coords[2];
    }
  }
  
  loadExplosionImages();

  loadBulletImages();

  loadUiImages();
}


//returns whether or not String a is a substring of String b
boolean startsWith(String b, String a) {
  if (a.length() > b.length())
    return false;

  for (int i = 0; i < a.length(); i++) {
    if (a.charAt(i) != b.charAt(i))
      return false;
  }

  return true;
}

void loadUiImages() {
  startdefault = loadImage("ui/startdefault.png");
  starthover = loadImage("ui/starthover.png");
  optionsdefault = loadImage("ui/optionsdefault.png");
  optionshover = loadImage("ui/optionshover.png");
  helpdefault = loadImage("ui/helpdefault.png");
  helphover = loadImage("ui/helphover.png");
  backdefault = loadImage("ui/backdefault.png");
  backhover = loadImage("ui/backhover.png");
  exitdefault = loadImage("ui/exitdefault.png");
  exithover = loadImage("ui/exithover.png");  
  xdefault = loadImage("ui/xdefault.png");
  xhover = loadImage("ui/xhover.png");
  creditsdefault = loadImage("ui/creditsdefault.png");
  creditshover = loadImage("ui/creditshover.png");
  playdefault = loadImage("ui/playdefault.png");
  playhover = loadImage("ui/playhover.png");

  box = loadImage("ui/box.png");
}

void loadBulletImages() {
  sheet = loadImage("game/pixel_effects/11_fire_spritesheet.png");
  int frame_dimensions = sheet.width/8;
  for (int c = 0; c < pixel_effects_fire.length; c++) {
    int i = c/8;
    int j = c%8;
    pixel_effects_fire[c] = sheet.get(j*frame_dimensions, i*frame_dimensions, frame_dimensions, frame_dimensions);
  }

  circle_bullet_blue = loadImage("game/circle_bullets/blue.png");
  circle_bullet_red = loadImage("game/circle_bullets/red.png");
}

void loadExplosionImages(){
  sheet = loadImage("game/explosions/explosion-1.png");
  
  for(int i = 0; i < explosion_1.length; i++){
    explosion_1[i] = sheet.get(i*sheet.width/explosion_1.length, 0, sheet.width/explosion_1.length, sheet.height);
  }
  
  sheet = loadImage("game/explosions/explosion-2.png");
  
  for(int i = 0; i < explosion_2.length; i++){
    explosion_2[i] = sheet.get(i*sheet.width/explosion_2.length, 0, sheet.width/explosion_2.length, sheet.height);
  }
  
  sheet = loadImage("game/explosions/explosion-3.png");
  
  for(int i = 0; i < explosion_3.length; i++){
    explosion_3[i] = sheet.get(i*sheet.width/explosion_3.length, 0, sheet.width/explosion_3.length, sheet.height);
  }
}
