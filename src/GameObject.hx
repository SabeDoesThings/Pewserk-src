import hxd.res.Image;
import h2d.col.Bounds;
import h2d.Object;

class GameObject extends Object {
    public var sprite(default, set): Object;
    public var level: Level;

    public var hitbox(get, default): Bounds;

    public function new(_level: Level) {
        level = _level;
        super(level);
    }

    public function update(dt: Float) {}
    
    function get_hitbox() {
        hitbox.x = this.x;
        hitbox.y = this.y;

        return hitbox;
    }

    function set_sprite(obj: Object) {
        sprite = obj;
        sprite.parent = this;

        return sprite;
    }

    public function useAnimationFromSpriteStrip(image_resources: Image, speed, chosenFrames: Array<Int>, centered: Bool = true, lookLeft: Bool = false) {
        var oldSprite = sprite;
        sprite = Sprite.createAnimFromStrip(this, image_resources, speed, chosenFrames, centered, lookLeft);
        oldSprite.remove();

        return sprite;
    }
}