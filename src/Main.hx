import hxd.Key;
import h2d.SpriteBatch;

class Main extends hxd.App {
    var batch:SpriteBatch;
    var plr:Player;
    var speed:Int;
    override function init() {
        speed = 220;
        var mainscene = new h2d.Scene();
        setScene(mainscene);
        var img = hxd.Res.Toad.toTile();
        plr = new Player(s2d, hxd.Res.Goomba.toTile());
        plr.start(new Vector2(5, s2d.height - plr.getSize().height/2));
        batch = new h2d.SpriteBatch(img, s2d);
        batch.hasRotationScale = true;
        batch.hasUpdate = true;
        for (i in 0...3) {
            var td = new Toad(img);
            batch.add(td);
            td.reset();
        }
    }
    static function main() {
        hxd.Res.initEmbed();
        new Main();
    }
    override function update(dt:Float) {
        if (Key.isDown(Key.LEFT) || Key.isPressed(Key.LEFT)) {
            plr.x -= speed * dt;
        } else if (Key.isDown(Key.RIGHT) || Key.isPressed(Key.RIGHT)) {
            plr.x += speed * dt;
        }
    }
}



class Toad extends h2d.BasicElement {
    public function new(t:h2d.Tile) {
        super(t);
        gravity = 30;
        vy = Math.random() * 10;
    }
    public function reset() {
        scale = 0.05;
        y = 0;
        x = Math.random() * (batch.getScene().width - t.width*0.05);
        vy += Math.random() * 0.3;
    }
    override function update(dt:Float) {
        super.update(dt);
        if (y > batch.getScene().height) reset();
        if (x > (batch.getScene().width - t.width) || x > 0) x - 10 * cast (dt, Int);
        return true;
    }
}

class Player extends h2d.Object {
    var bitmap: h2d.Bitmap;
    public function new(scene:h2d.Object, t:h2d.Tile) {
        super(scene);
        this.bitmap = new h2d.Bitmap(t);
        addChild(bitmap);
        this.scaleX = 0.1;
        this.scaleY = 0.1;
    }
    public function start(pos:Vector2) {
        this.bitmap.x = this.getSize().width/2;
        this.bitmap.y = -this.getSize().height/2;
        this.x = pos.x + this.getSize().width/2; //sets object pos to pos.x + half of the object's width (for the anchor in the center)
        this.y = pos.y - this.getSize().height/2;//same
    }
}

class Vector2 {
    public var x:Float;
    public var y:Float;
    public function new(x, y:Float) {
        this.x = x;
        this.y = y;
    }
}