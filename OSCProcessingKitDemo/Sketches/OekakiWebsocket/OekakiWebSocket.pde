// OekakiWebSocket - Processing

import websockets.*;

interface PAINTCOLOR {
    int
    RED    = 0,
    GREEN    = 1,
    BLUE   = 2,
    PURPLE = 3,
    AQUA  = 4,
    YELLOW = 5;
};

color[] colors = {
    color(192, 0, 0),
    color(0, 192, 0),
    color(0, 0, 192),
    color(192, 0, 192),
    color(0, 192, 192),
    color(192, 192, 0),
};

WebsocketClient wsc;
int selectedColor;
JSONArray points = new JSONArray();

void setup(){
    size(600,600);
    wsc = new WebsocketClient(this, "ws://localhost:8080");
    noStroke();
    strokeWeight(2);

    selectedColor = PAINTCOLOR.RED;
    textSize(32);
}

void draw(){
    background(255);

    for(int i = 0;i < colors.length; i++){
        color c = colors[i];
        if(i==selectedColor){
            stroke(128, 128, 128);
        }else{
            noStroke();
        }
        fill(c);
        ellipse(30,(i + 1) * 50,30,30);
    }

    fill(255, 0 ,0);
    text("X", 20, height - 50);

    if(mousePressed){
        mousePressed();
    }

    for (int i = 0; i < points.size(); i++) {
        JSONObject item = points.getJSONObject(i);
        fill(item.getInt("red"),item.getInt("green"),item.getInt("blue"));
        ellipse(item.getInt("x"), item.getInt("y"), 10, 10);
    }
}

void mousePressed() {
    for(int i = 0;i < colors.length; i++){
        if(mouseX > 15 && mouseX < 45 && mouseY > ((i+1) * 50 - 15) && mouseY < ((i+1) * 50 + 15)){
            selectedColor = i;
            return;
        }
    }
    if(mouseX > 15 && mouseX < 45 && mouseY > height - 70 && mouseY < height - 50){
        JSONObject json = new JSONObject();
        json.setBoolean("delete", true);
        wsc.sendMessage(json.toString());
        return;
    }

    JSONObject json = new JSONObject();

    json.setInt("red", int(red(colors[selectedColor])));
    json.setInt("green", int(green(colors[selectedColor])));
    json.setInt("blue", int(blue(colors[selectedColor])));
    json.setInt("x", mouseX);
    json.setInt("y", mouseY);

    wsc.sendMessage(json.toString());
}

void webSocketEvent(String msg){
    println(msg);
    JSONArray json = parseJSONArray(msg);
    points = json;
}
