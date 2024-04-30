import h2d.Anim;
import hxd.res.Image;

class Sprite {
    public static function createAnimFromStrip(parent, image_resource: Image, speed, numOfFrames: Int, chosenFrames: Array<Int>, centered: Bool = true, lookLeft: Bool = false): Anim {
        var allFrames = image_resource.toTile().split(numOfFrames);
        for (f in allFrames) {
            if (centered)
                f.setCenterRatio();
            if (lookLeft)
                f.flipX();
        }
        var frames = [for (i in chosenFrames) allFrames[i]];

        return new Anim(frames, speed, parent);
    }
}
