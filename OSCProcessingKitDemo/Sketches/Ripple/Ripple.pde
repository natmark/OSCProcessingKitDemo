// Ripple - Processing

class Ripple {
    float x = 0.0;
    float y = 0.0;
    float size = 0.0;
    Ripple(float x, float y, float size) {
        this.x = x;
        this.y = y;
        this.size = size;
    }
}

ArrayList<Ripple> ripples = new ArrayList<Ripple>();

void setup() {
    size(600, 600);
}

void draw() {
    background(255, 255, 255);

    noFill();
    stroke(0, 0, 255);
    strokeWeight(1.0);

    ArrayList<Ripple> removes = new ArrayList<Ripple>() ;

    for(Ripple ripple : ripples){
        ripple.size = ripple.size + 5;
        ellipse(ripple.x, ripple.y, ripple.size, ripple.size);
        if(ripple.size >= 1000){
            removes.add(ripple);
        }
    }

    for(Ripple ripple : removes){
        ripples.remove(ripple);
    }

    if(int(random(20)) == 0){
        ripples.add(new Ripple(random(width), random(height), 0.0));
    }
}
