import processing.core.PApplet;
import org.jbox2d.common.Vec2;

/** Runs against the compiled sketch, with its real assets and Box2D world. */
public class GameplayRegression extends DungeonExplorer {
  int checks;

  void check(boolean condition, String message) {
    if (!condition) throw new AssertionError(message);
    checks++;
    println("PASS: " + message);
  }

  @Override public void setup() {
    try {
      super.setup();
      song.pause();
      startGame();
      check(main.hp == PLAYER_MAX_HP, "new game starts at full health");
      FireBullet fire = new FireBullet(100, 100, 0, 0, 10, main);
      BigDemon enemy = new BigDemon(200, 200);
      enemy.create();
      rooms[current].addEntity(enemy);
      enemy.hit(fire);
      enemy.hit(fire);
      check(!toDestroy.contains(enemy), "enemy survives nonlethal damage");
      enemy.hit(fire);
      check(enemy.hp == 0 && toDestroy.contains(enemy), "enemy dies at exactly zero HP");
      applyEntityChanges();
      check(!rooms[current].entities.contains(enemy) && enemy.walkbox == null,
            "dead enemy and physics body are removed");
      enemy.destroyBody();
      check(enemy.walkbox == null, "destroying a body twice is harmless");

      key = 'w'; keyPressed();
      main.step();
      check(main.keysdown[0] && main.walkbox.getLinearVelocity().y > 0, "movement begins");
      key = ESC; keyPressed();
      check(phase == Phase.PAUSE && !main.keysdown[0] && main.walkbox.getLinearVelocity().length() == 0,
            "pause clears held movement and velocity");
      // Simulate a release arriving while paused, including a stale held flag.
      main.keysdown[0] = true;
      key = 'w'; keyReleased();
      check(!main.keysdown[0], "key releases are processed while paused");
      key = ESC; keyPressed();
      main.step();
      check(phase == Phase.GAME && main.walkbox.getLinearVelocity().length() == 0,
            "resume stays stationary");

      Room oldRoom = rooms[current];
      main.shoot(0);
      Entity pending = toCreate.iterator().next();
      nextRoom();
      check(oldRoom.entities.contains(pending) && !rooms[current].entities.contains(pending),
            "queued projectile stays in its original room");
      check(toCreate.isEmpty() && toDestroy.isEmpty(), "room switch drains old-room queues");
      for (int i = 0; i < rooms.length - 1; i++) nextRoom();
      check(current == 0 && pending.walkbox != null, "returning to a room recreates its bodies");
      toDestroy.add(pending);
      nextRoom();
      check(!oldRoom.entities.contains(pending), "pending deletion finishes before leaving room");
      nextRoom(); nextRoom(); nextRoom();
      check(!oldRoom.entities.contains(pending), "deleted projectile does not return");

      main.step();
      Vec2 hitPosition = box2d.getBodyPixelCoord(main.hitbox);
      FireBullet ownShot = new FireBullet(hitPosition.x, hitPosition.y, 0, 0, 10, main);
      ownShot.create();
      rooms[current].addEntity(ownShot);
      box2d.step();
      check(main.hp == PLAYER_MAX_HP, "player's own projectile does not damage them");
      toDestroy.add(ownShot);
      applyEntityChanges();
      FireBullet enemyShot = new FireBullet(hitPosition.x, hitPosition.y, 0, 0, 10, enemy);
      enemyShot.create();
      rooms[current].addEntity(enemyShot);
      box2d.step();
      check(main.hp == PLAYER_MAX_HP - enemyShot.damage,
            "real Box2D contact routes enemy projectile damage to player");
      for (int i = 0; i < 10; i++) main.hit(fire);
      check(main.hp == 0 && phase == Phase.GAME_OVER, "lethal damage clamps HP and ends the game");
      key = 'r'; keyPressed();
      check(main.hp == PLAYER_MAX_HP && current == 0 && phase == Phase.GAME,
            "restart restores health and first room");
      main.hit(new GreenCircleBullet(0, 0, 0, 0, 20, enemy));
      check(main.hp == 0 && phase == Phase.GAME_OVER, "overkill damage cannot make HP negative");

      // Title rendering used to leak one style stack entry on every frame.
      phase = Phase.START;
      for (int i = 0; i < 100; i++) drawTitleBackground();
      check(true, "title background renders repeatedly without overflowing the style stack");
      println("PASS: all " + checks + " gameplay regression checks");
      exit();
    } catch (Throwable failure) {
      failure.printStackTrace();
      System.exit(1);
    }
  }

  @Override public void draw() {}

  public static void main(String[] args) {
    PApplet.main(PApplet.concat(args, new String[] {GameplayRegression.class.getName()}));
  }
}
