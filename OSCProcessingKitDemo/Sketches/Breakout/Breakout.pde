// Breakout - Processing
class Block {
    PVector origin;
    PVector size;
    Block(PVector origin, PVector size) {
        this.origin = origin;
        this.size = size;
    }

    void update() {
        fill(255);
        rect(this.origin.x, this.origin.y, this.size.x, this.size.y);
    }

    float top(){
        return this.origin.y;
    }
    float left(){
        return this.origin.x;
    }
    float right(){
        return this.origin.x + this.size.x;
    }
    float bottom(){
        return this.origin.y + this.size.y;
    }
}

class BlockGenerator {
    final PVector BLOCK_SIZE = new PVector(10, 5);
    final int BLOCK_HEIGHT = 30;

    ArrayList<Block> generate(int frameWidth){
        ArrayList<Block> blocks = new ArrayList<Block>();
        for(int x = 0; x < BLOCK_SIZE; x++){
            for(int y = 0; y < BLOCK_SIZE; y++){
                Block block = new Block(new PVector(x * (frameWidth / BLOCK_SIZE), y * BLOCK_HEIGHT), new PVector(frameWidth / BLOCK_SIZE, BLOCK_HEIGHT));
                blocks.add(block);
            }
        }
        return blocks;
    }
}

class Ball {
    PVector center;
    PVector size;
    PVector velocity;

    Ball(PVector center, PVector size, PVector velocity){
        this.center = center;
        this.size = size;
        this.velocity = velocity;
    }

    void update(){
        fill(255);
        this.center.add(this.velocity);
        ellipse(this.center.x, this.center.y, this.size.x, this.size.y);
    }

    float top(){
        return this.center.y - this.size.y / 2;
    }
    float left(){
        return this.center.x - this.size.x / 2;
    }
    float right(){
        return this.center.x + this.size.x / 2;
    }
    float bottom(){
        return this.center.y + this.size.y / 2;
    }
}

class Bar {
    PVector origin;
    PVector size;
    Bar(PVector origin, PVector size){
        this.origin = origin;
        this.size = size;
    }

    void update(){
        fill(255);
        rect(this.origin.x, this.origin.y, this.size.x, this.size.y);
    }

    float top(){
        return this.origin.y;
    }
    float left(){
        return this.origin.x;
    }
    float right(){
        return this.origin.x + this.size.x;
    }
    float bottom(){
        return this.origin.y + this.size.y;
    }
}

class HitChecker {  
    void check() {
        if(ball.top() >= height){
            ball = new Ball(new PVector(width / 2 - 200, bar.origin.y - 200),new PVector(20, 20),new PVector(3, 3));
        }
        if (ball.left() <= 0 || ball.right() >= width){
            ball.velocity.x = -ball.velocity.x;
        }
        if (ball.top() <= 0){
            ball.velocity.y = -ball.velocity.y;
        }

        if (bar.top() <= ball.center.y && bar.bottom() >= ball.center.y && bar.left() <= ball.center.x && bar.right() >= ball.center.x){
            float bar_y1 = ball.center.x * (bar.size.y / bar.size.x) + bar.bottom();
            float bar_y2 = ball.center.x * -(bar.size.y / bar.size.x) + bar.top();

            if((ball.center.y <=bar_y1 && ball.center.y <= bar_y2) || (ball.center.y >= bar_y1 && ball.center.y >= bar_y2)){
                ball.velocity.x = - ball.velocity.x;
            } else {
                ball.velocity.y = - ball.velocity.y;
                ball.velocity.x = max(-3, min(3, -((bar.left() + ball.right()) - ball.center.x * 2)));
            }
        }

        ArrayList<Block> removes = new ArrayList<Block>();

        for(Block block : blocks){
            if (block.top() <= ball.center.y && block.bottom() >= ball.center.y && block.left() <= ball.center.x && block.right() >= ball.center.x){
                float y1 = ball.center.x * (block.size.y / block.size.x) + block.bottom();
                float y2 = ball.center.x * -(block.size.y / block.size.x) + block.top();

                if((ball.center.y <= y1 && ball.center.y <= y2)){
                    ball.velocity.x = - ball.velocity.x;
                }else if((ball.center.y >= y1 && ball.center.y >= y2)){
                    ball.velocity.x = - ball.velocity.x;
                }else if((ball.center.y >= y1 && ball.center.y <= y2)){
                    ball.velocity.y = - ball.velocity.y;
                }else if((ball.center.y <= y1 && ball.center.y >= y2)){
                    ball.velocity.y = - ball.velocity.y;
                }
                removes.add(block);
            }
        }

        for(Block block: removes){
            blocks.remove(block);
        }
    }
}

Ball ball;
Bar bar;
ArrayList<Block> blocks;
HitChecker hitChecker = new HitChecker();
BlockGenerator generator = new BlockGenerator();

void setup(){
    size(600, 600);
    bar = new Bar(new PVector(0, height - 50), new PVector(100, 10));
    ball = new Ball(new PVector(width / 2 - 200, bar.origin.y - 200),new PVector(20, 20),new PVector(4, 4));
    blocks = generator.generate(width);
}

void draw(){
    background(0);
    ball.update();

    bar.origin.x = mouseX - bar.size.x / 2;
    bar.update();

    for(Block block: blocks){
        block.update();
    }

    hitChecker.check();

    if(blocks.size() == 0){
        blocks = generator.generate(width);
    }
}
