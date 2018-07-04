// SimpleTouch - Processing

void setup() {
    background(255, 255, 255);
    fill(255,0 ,0);
}

void draw() {
    if(mousePressed){
        ellipse(mouseX, mouseY, 20, 20);
    }
}

