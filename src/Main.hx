import h2d.Scene;
import levels.*;
import screens.*;

class Main extends hxd.App {
    public var level: Level;
    public var screen: Screen;

    public static var inst(get, null): Main;
    static function get_inst(): Main {
        if (inst == null)
            inst = new Main();

        return inst;
    }

    override function init() {
        screen = new Menu();
        level = new Level01();
        setScreen(screen);
    }

    public function setLevel(level: Level) {
        setScene(level);
        this.level = level;
    }

    public function setScreen(screen: Screen) {
        setScene(screen);
        this.screen = screen;
    }

    override function update(dt: Float) {
        level.update(dt);
        screen.update();
    }

    override function dispose() {
        super.dispose();

        level.dispose();
        screen.dispose();
    }

    static function main() {
        #if sys
        hxd.Res.initLocal(); // important! allows the app access to our game's resource files: images (sprites), audio, etc.
        #else
        hxd.Res.initEmbed(); // use hxd.Res.initEmbed(); for html5/js
        #end
        
        inst;
    }
}