// Colorful - Processing

void setup() {
    size(600,600);
    background(0, 0, 0);
    noStroke();
    colorMode(HSB);
}

void draw() {
    if(mousePressed){
        fill(random(255), 255, 255);
        float diameter = random(20) % 18;
        float x = mouseX + random(20) - 10;
        float y = mouseY + random(20) - 10;
        ellipse(x, y, diameter, diameter);
    }
}

