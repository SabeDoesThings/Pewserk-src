import entities.Bot2;
import entities.Bot1;
import entities.Bonus;

class LevelLoader {
    public static function loadLevel(levelString: String, startX: Float = 0, startY: Float = 0, level: Level) {
        var fieldSize = 32;
        var x = 0;
        var y = 0;

        var positionInScene = (x: Int, y: Int) -> {
            var sx = (x * fieldSize) + startX;
            var sy = (y * fieldSize) + startY;
            return {
                x: sx,
                y: sy
            };
        };

        for (i in 0...levelString.length) {
            var char = levelString.charAt(i);
            switch (char) {
                case "\n":
                    y++;
                    x = 0;
                case "o":
                    //bonus
                    var bonus = new Bonus(level);
                    var posInSc = positionInScene(x, y);
                    bonus.setPosition(posInSc.x + 16, posInSc.y + 16);
                case "z":
                    //bot1
                    var bot1 = new Bot1(level);
                    var posInSc = positionInScene(x, y);
                    bot1.setPosition(posInSc.x + 16, posInSc.y + 16);
                case "x":
                    //bot2
                    var bot1 = new Bot2(level);
                    var posInSc = positionInScene(x, y);
                    bot1.setPosition(posInSc.x + 16, posInSc.y + 16);
                case "#":
                    //wall
                    var posInSc = positionInScene(x, y);
                    level.createWall(posInSc.x, posInSc.y);
                default:
            }
            x++;
        }
    }
}