// Particle - Processing

float getRandomNumber(float min, float max) {
    return random(min, max);
}

class Dot {
    float x = 0.0;
    float y = 0.0;
    float vx = 0.0;
    float vy = 0.0;
    float w = 0.0;
    float h = 0.0;

    Dot(float w, float h) {
        this.w = w;
        this.h = h;
    }

    void update() {
        this.vx = this.vx + getRandomNumber(0.0, 2.0) - 1.0;
        this.vx = this.vx * 0.96;
        this.vy = this.vy + getRandomNumber(0.0, 2.0) - 1.0;
        this.vy = this.vy * 0.96;

        this.x = this.x + this.vx;
        this.y = this.y + this.vy;

        if (this.x > this.w) { this.x = this.w; this.vx = this.vx * - 1.0; }
        if (this.x < 0) { this.x = 0; this.vx = this.vx * - 1.0; }
        if (this.y > this.h) { this.y = this.h; this.vy = this.vy * - 1.0; }
        if (this.y < 0) { this.y = 0; this.vy = this.vy * - 1.0; }
    }
}

final int totalDots = 50;
ArrayList<Dot> dots = new ArrayList<Dot>();
float diameter = 12.0;

void setup() {
    size(600, 600);
    fill(255, 0, 0, 255);
    noStroke();
    for(int i = 0; i < totalDots; i++){
        Dot d = new Dot(width, height);
        d.x = random(width);
        d.y = random(height);
        d.vx = random(getRandomNumber(0.0, 2.0) - 1.0);
        d.vx = random(getRandomNumber(0.0, 2.0) - 1.0);
        dots.add(d);
    }

    background(0);
}

void draw() {
    fill(0, 0, 0, 25);
    rect(0, 0, width, height);

    float r = 255;
    float g = 255;
    float b = 255;

    for(Dot dot : dots) {
        r = dot.x / width * 255;
        g = dot.y / height * 255;
        fill(r, g, b, 255);
        dot.update();
        ellipse(dot.x, dot.y, diameter, diameter);
    }
}
