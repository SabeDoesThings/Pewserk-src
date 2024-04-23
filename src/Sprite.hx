import h2d.Anim;
import hxd.res.Image;

class Sprite {
    public static function createAnimFromStrip(parent, image_resource: Image, speed, chosenFrames: Array<Int>, centered: Bool = true, lookLeft: Bool = false): Anim {
        var height = image_resource.getSize().height;
        var autoCout = Math.floor(image_resource.getSize().width / height);
        var allFrames = image_resource.toTile().split(autoCout);
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