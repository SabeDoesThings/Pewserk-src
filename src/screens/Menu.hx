package screens;

import levels.Level08;
import h2d.Font;
import levels.Level01;
import hxd.Key;
import h2d.Text;
import hxd.res.DefaultFont;
import h2d.Scene;

class Menu extends Screen {
    public static var font: Font;
    public var mainMenuText: Text;

    public function new() {
        super();

        font = DefaultFont.get();
        mainMenuText = new Text(font, this);
        mainMenuText.text = "Pewserk!\n\nPress 'SPACE' to start";
        mainMenuText.setPosition(1280 / 2, 720 / 2.5);
        mainMenuText.textAlign = Center;
        mainMenuText.scale(4);
    }

    override function update() {
        if (Key.isPressed(Key.SPACE)) {
            Main.inst.setLevel(new Level01());  
        }
    }

    override function dispose() {
        super.dispose();
    }
}