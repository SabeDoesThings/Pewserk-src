package screens;

import levels.Level01;
import hxd.Key;
import h2d.Text;
import hxd.res.DefaultFont;

class Menu extends Screen {
    override function init() {
        var font = DefaultFont.get();
        var mainMenuText = new Text(font, this);
        mainMenuText.text = "Pewserk!\n\nPress 'SPACE' to start";
        mainMenuText.x = this.width / 2;
        mainMenuText.y = this.height / 2;
        font.resizeTo(32);
    }

    override function update(dt:Float) {
        if (Key.isPressed(Key.SPACE)) {
            Main.inst.setLevel(new Level01());
        }
    }

    override function dispose() {
        super.dispose();
    }
}