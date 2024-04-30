package entities;

import hxd.Math;
import h2d.Graphics;
import hxd.Key;
import hxd.Res;

class Player extends GameObject {
    public var bullets: Array<Graphics> = [];

    public function new(level_) {
        super(level_);

        var spr = useAnimationFromSpriteStrip(Res.player, 5, 5, [0], false);
        hitbox = spr.getBounds();

        level.player = this;
    }

    override function update(dt: Float) {
        super.update(dt);
        playerMovement(dt);
        updateBullets();
        playerShooting();
    }

    function updateBullets() {
        for (b in bullets) 
            b.move(6, 6);
    }

    function playerShooting() {
        if (Key.isPressed(Key.MOUSE_LEFT)) {
            var bullet = new Graphics(level);
            bullet.setPosition(this.x, this.y);
            bullet.rotation = Math.atan2(level.mouseY - this.y, level.mouseX - this.x);
            bullet.beginFill(0x09FF00);
            bullet.drawRect(-8, -4, 35, 3);
            bullets.push(bullet);
            changePlayerAnimation([1], false, 0);
            Res.audio.laserShoot.play();
        }
        if (Key.isReleased(Key.MOUSE_LEFT)) {
            changePlayerAnimation([0], false, 0);
        }
    }

    function playerMovement(dt: Float) {
        var animSpeed = 10;
        var speed = 200;

        //moving up
        checkKeyboardKeys(
            Key.UP,
            Key.W,
            () -> {changePlayerAnimation([2, 3, 4], false, animSpeed);},
            () -> {level.moveObjectWhenWallFree(this, this.x, this.y - speed * dt);},
            () -> {changePlayerAnimation([0], false, 0);}
        );

        //moving down
        checkKeyboardKeys(
            Key.DOWN,
            Key.S,
            () -> {changePlayerAnimation([2, 3, 4], false, animSpeed);},
            () -> {level.moveObjectWhenWallFree(this, this.x, this.y + speed * dt);},
            () -> {changePlayerAnimation([0], false, 0);}
        );

        //moving left
        checkKeyboardKeys(
            Key.LEFT,
            Key.A,
            () -> {changePlayerAnimation([2, 3, 4], true, animSpeed);},
            () -> {level.moveObjectWhenWallFree(this, this.x - speed * dt, this.y);},
            () -> {changePlayerAnimation([0], true, 0);}
        );

        //moving right
        checkKeyboardKeys(
            Key.RIGHT,
            Key.D,
            () -> {changePlayerAnimation([2, 3, 4], false, animSpeed);},
            () -> {level.moveObjectWhenWallFree(this, this.x + speed * dt, this.y);},
            () -> {changePlayerAnimation([0], false, 0);}
        );
    }

    function checkKeyboardKeys(key0: Int, key1: Int, onPressed: () -> Void, onDown: () -> Void, onRelease: () -> Void) {
        if (Key.isPressed(key0) || Key.isPressed(key1))
            onPressed();
        if (Key.isDown(key0) || Key.isDown(key1))
            onDown();
        if (Key.isReleased(key0) || Key.isReleased(key1))
            onRelease();
    }

    function changePlayerAnimation(chosenFrames: Array<Int>, lookLeft: Bool = false, speed) {
        useAnimationFromSpriteStrip(Res.player, speed, 5, chosenFrames, true, lookLeft);
    }
}
