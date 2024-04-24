import entities.Bot2;
import h2d.col.Point;
import h2d.TileGroup;
import h2d.col.Bounds;
import hxd.Res;
import entities.Bonus;
import hxd.Math;
import h2d.Object;
import entities.Bot1;
import entities.Player;
import h2d.Scene;

class Level extends Scene {
    public var walls: Array<{bounds: Bounds, type: Int}> = [];
    public var backgroundTilegroup: TileGroup;

    public var player: Player;
    public var bots1: Array<Bot1> = [];
    public var bots2: Array<Bot2> = [];
    public var bonuses: Array<Bonus> = [];

    public static var score: Int = 0;

    public function new() {
        super();

        backgroundTilegroup = new TileGroup(Res.wall.toTile(), this);
    }

    public function moveObjectWhenWallFree(obj: Object, x: Float, y: Float) {
        if (checkForWall(x, y) == false) {
            obj.setPosition(x, y);

            return true;
        }

        return false;
    }

    public function checkForWall(x: Float, y: Float) {
        var point = new Point(x, y);
        for (w in walls) {
            if (w.bounds.contains(point) && w.type == 1) {
                return true;
            }
        }

        return false;
    }

    public function createWall(x: Float, y: Float) {
        var tile = Res.wall.toTile();
        var chosenTile = tile;
        chosenTile.scaleToSize(32, 32);
        backgroundTilegroup.add(x, y, chosenTile);

        var bounds = new Bounds();
        bounds.set(x, y, 32, 32);

        walls.push(
            {
                bounds: bounds,
                type: 1
            }
        );
    }

    public function assignRandomPosition(obj: Object, width: Float, height: Float) {
        obj.setPosition(Math.random(width), Math.random(height));
    }

    public function wrapInsideScene(obj: Object){
        if(obj.x < 0)
            obj.x = 1280;
        if(obj.y < 0)
            obj.y = 720;
        if(obj.x > 1280)
            obj.x = 0;
        if(obj.y > 720)
            obj.y = 0;
    }

    public function update(dt: Float) {}
}