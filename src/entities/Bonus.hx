package entities;

import hxd.Res;

class Bonus extends GameObject {
    public function new(level_) {
        super(level_);
        var spr = useAnimationFromSpriteStrip(Res.bonus, 0, [0]);
        hitbox = spr.getBounds();
        
        level.bonuses.push(this);
    }

    override function onRemove() {
        super.onRemove();

        level.bonuses.remove(this);
    }
}