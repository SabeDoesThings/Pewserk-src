package entities;

import hxd.Math;
import hxd.Res;

class Bot1 extends GameObject {
    public var direction: Float = 0;

    public function new(level_) {
        super(level_);
        var spr = useAnimationFromSpriteStrip(Res.bot1, 5, [0, 1, 2]);
        hitbox = spr.getBounds();

        level.bots1.push(this);
    }

    override function update(dt:Float) {
        super.update(dt);

        var speed = 100;

        var b = this;
        var moveX = level.moveObjectWhenWallFree(this, b.x + Math.cos(b.direction) * speed * dt, b.y);
        var moveY = level.moveObjectWhenWallFree(this, b.x, b.y + Math.sin(b.direction) * speed * dt);
        if (!moveX || !moveY) 
            this.direction = Math.random(Math.PI * 2);
    }

    override function onRemove() {
        super.onRemove();

        level.bots1.remove(this);
    }
}