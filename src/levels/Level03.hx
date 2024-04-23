package levels;

import screens.Menu;
import hxd.res.DefaultFont;
import h2d.Text;
import entities.Bonus;
import sys.io.File;
import hxd.Math;
import entities.Bot1;
import entities.Player;

class Level03 extends Level {
    var score: Int = 0;
    var updatableInfoHUD: Text;

    public function new() {
        super();

        LevelLoader.loadLevel(File.getContent("./res/txt_levels/level03.txt"), this);

        player = new Player(this);
        player.setPosition(53, 215);
        player.scale(2);

        for (bot in bots1) {
            bot.scale(2);
            bot.direction = Math.random(Math.PI * 2);
        }

        // score
        var t = new Text(DefaultFont.get(), this);
        t.textColor = 0xFFFF00;
        t.scale(2);
        updatableInfoHUD = t;
    }

    override function update(dt: Float) {
        player.update(dt);
        if (player.x > this.width) {
            Main.inst.setLevel(new Level04());
        }
        wrapInsideScene(player);

        updateBots(dt);

        updateInfoHud();

        checkCollisionBullets();

        checkCollisionPlayerAndBots();

        checkCollisionPlayerAndBonuses();
    }

    function updateBots(dt: Float) {
        for (b in bots1) {
            b.update(dt);
            wrapInsideScene(b);
        }
    }

    function checkCollisionBullets() {
        for (b in player.bullets) {
            var bulletBounds = b.getBounds();

            for (e in bots1) {
                if (bulletBounds.intersects(e.hitbox)) {
                    bots1.remove(e);
                    e.remove();
                    player.bullets.remove(b);
                    b.remove();
                    score += 100;
                }
            }

            if (b.x >= this.width || b.x <= 0) {
                b.remove();
                player.bullets.remove(b);
                trace("bullet removed");
            }
            else if (b.y >= this.height || b.y <= 0) {
                b.remove();
                player.bullets.remove(b);
                trace("bullet removed");
            }
        }
    }

    function checkCollisionPlayerAndBots() {
        for (b in bots1) {
            if (b.hitbox.intersects(player.hitbox)) {
                this.removeChild(player);
                player.remove();
                Main.inst.setScreen(new Menu());
            }
        }
    }

    function checkCollisionPlayerAndBonuses() {
        for (b in bonuses) {
            if (b.hitbox.intersects(player.hitbox)) {
                bonuses.remove(b);
                b.remove();
                score += 250;
            }
        }
    }

    function updateInfoHud() {
        var t = updatableInfoHUD;
        t.text = 'score: $score';
        t.setPosition(0 + t.textWidth, 8);
    }

    override function dispose() {
        super.dispose();
    }
}