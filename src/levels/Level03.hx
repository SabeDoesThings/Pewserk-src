package levels;

import hxd.Res;
import screens.Menu;
import hxd.res.DefaultFont;
import h2d.Text;
import entities.Bonus;
import hxd.Math;
import entities.Bot1;
import entities.Player;

class Level03 extends Level {
     
    var updatableInfoHUD: Text;

    public function new() {
        super();

        var level3TXT = Res.txt_levels.level03.entry.getText();

        LevelLoader.loadLevel(level3TXT, this);

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
        if (player.x > 1280) {
            Main.inst.setLevel(new Level04());
        }
        if (player.x < 0) {
            player.x = 0;
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
                    Level.score += 100;
                    Res.audio.hitHurt.play();
                }
            }

            if (b.x >= 1280 || b.x <= 0) {
                b.remove();
                player.bullets.remove(b);
                trace("bullet removed");
            }
            else if (b.y >= 720 || b.y <= 0) {
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
                Level.score += 250;
                Res.audio.pickupCoin.play();
            }
        }
    }

    function updateInfoHud() {
        var t = updatableInfoHUD;
        t.text = 'score: ${Level.score}';
        t.setPosition(0 + t.textWidth, 8);
    }

    override function dispose() {
        super.dispose();
    }
}