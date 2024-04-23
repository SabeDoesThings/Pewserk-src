package entities;

import hxd.Math;
import hxd.Res;

class Bot2 extends GameObject {
    public var direction: Float = 0;
    public var health: Int = 500;

    public function new(level_) {
        super(level_);
        var spr = useAnimationFromSpriteStrip(Res.bot2, 5, [0, 1, 2, 3]);
        hitbox = spr.getBounds();

        level.bots2.push(this);
    }

    override function update(dt:Float) {
        super.update(dt);

        var speed = 400;

        var b = this;
        var moveX = level.moveObjectWhenWallFree(this, b.x + Math.cos(b.direction) * speed * dt, b.y);
        var moveY = level.moveObjectWhenWallFree(this, b.x, b.y + Math.sin(b.direction) * speed * dt);
        if (!moveX || !moveY) 
            this.direction = Math.random(Math.PI * 2);
    }

    override function onRemove() {
        super.onRemove();

        level.bots2.remove(this);
    }
}