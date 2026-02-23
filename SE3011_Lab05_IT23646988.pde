int state = 0;
int score = 0;

int startTime;
int duration = 30; 


float px, py;
float pr = 20;
float step = 5;


float ox, oy;
float oxs = 3;
float oys = 2;
float or = 15;


float hx, hy;
float ease = 0.1;


boolean trails = false;

void setup() {
  size(700, 350);
  resetGame();
}

void draw() {


  if (state == 1 && trails) {
    fill(255, 40);
    noStroke();
    rect(0, 0, width, height);
  } else {
    background(255);
  }


  if (state == 0) {
    textAlign(CENTER, CENTER);
    textSize(40);
    fill(255, 0 ,0);
    text("ORB Hunt", width/2, height/2 - 20);
    text("Press ENTER to Start!", width/2, height/2 + 20);
  }

  
  if (state == 1) {

    int elapsed = (millis() - startTime) / 1000;
    int timeLeft = duration - elapsed;

    if (timeLeft <= 0) {
      state = 2;
    }

    if (keyPressed) {
      if (keyCode == RIGHT) px += step;
      if (keyCode == LEFT)  px -= step;
      if (keyCode == UP)    py -= step;
      if (keyCode == DOWN)  py += step;
    }

    
    px = constrain(px, pr, width - pr);
    py = constrain(py, pr, height - pr);

    
    ox += oxs;
    oy += oys;

    
    if (ox > width - or || ox < or) oxs *= -1;
    if (oy > height - or || oy < or) oys *= -1;

  
    if (dist(px, py, ox, oy) < pr + or) {
      score++;
      ox = random(or, width - or);
      oy = random(or, height - or);

      
      oxs *= 1.1;
      oys *= 1.1;
    }

    
    hx = hx + (px - hx) * ease;
    hy = hy + (py - hy) * ease;

    
    fill(0);
    ellipse(ox, oy, or*2, or*2);

    
    fill(255,0,0);
    ellipse(px, py, pr*2, pr*2);

    
    fill(255,255,255);
    ellipse(hx, hy, 14, 14);

    
    fill(0);
    textAlign(LEFT, TOP);
    textSize(20);
    text("Score: " + score, 20, 20);
    fill(255,0,0);
    text("Time Left: " + timeLeft, 20, 40);
     fill(0);
    text("Press T for Trails", 20, 60);
  }

  
  if (state == 2) {
    textAlign(CENTER, CENTER);
    textSize(25);
    fill(0);
    text("Time Over!", width/2, height/2 - 20);
    fill(255,0,0);
    text("Your score: " + score, width/2, height/2);
    fill(0);
    text("Press R to Restart", width/2, height/2 + 20);
  }
}

void keyPressed() {

  
  if (state == 0 && keyCode == ENTER) {
    state = 1;
    startTime = millis();
  }

 
  if (state == 2 && (key == 'r' || key == 'R')) {
    resetGame();
    state = 0;
  }

 
  if (key == 't' || key == 'T') {
    trails = !trails;
  }
}


void resetGame() {
  score = 0;

  px = width/2;
  py = height/2;

  ox = random(or, width - or);
  oy = random(or, height - or);

  oxs = 3;
  oys = 2;

  hx = px;
  hy = py;
}
