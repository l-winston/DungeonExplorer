import processing.core.PApplet;

/** Deterministic playthrough of the real sketch; saves unedited rendered frames. */
public class CaptureScreenshots extends DungeonExplorer {
  @Override public void setup() {
    randomSeed(42);
    super.setup();
    song.pause();
  }

  @Override public void draw() {
    focused = true;
    if (frameCount == 335) {
      randomSeed(7);
      startGame();
      nextRoom();
    }
    if (frameCount == 340 || frameCount == 348) main.shoot(0);
    if (frameCount == 362) {
      randomSeed(7);
      startGame();
      nextRoom();
      main.weapon = new NatureStaff();
    }
    if (frameCount == 365 || frameCount == 375) main.shoot(0.6f);
    super.draw();
    if (frameCount == 330) saveFrame("screenshots/title-screen.png");
    if (frameCount == 350) saveFrame("screenshots/fire-staff.png");
    if (frameCount == 385) saveFrame("screenshots/nature-staff.png");
    if (frameCount == 390) exit();
  }

  public static void main(String[] args) {
    PApplet.main(PApplet.concat(args, new String[] {CaptureScreenshots.class.getName()}));
  }
}
