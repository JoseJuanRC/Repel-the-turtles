PShader sh;
PShape background;

boolean wave = false;
int lastMouseX;
int lastMouseY;

float distanceValue = 0f;
float maxDistance = 20f;

int timeIntro = 6000; // 6 segundos

PFont f;

void setup() {
  size(640, 640, P3D);
  noStroke();
  fill(204);
  sh = loadShader("water.glsl");
  sh.set("u_resolution", float(width), float(height));
  sh.set("maxDistance", maxDistance) ;

  // Definimos los colores
  sh.set("rippleColor",0.5,1,1) ;
  sh.set("waterColor", 0.18, 0.6295794, 0.8584906) ;


  background = createShape(RECT, -width/2, -height/2, width*2, height*2); 
  background.translate(0, 0, -200);
  PImage texture = loadImage( "Textures/sand.jpg");
  background.setTexture(texture);
}

void draw() {
  if (millis() < timeIntro) {
    drawIntro();
  } else {
    fill(200, 0, 0);
    shape(background);
  
    fill(0, 0, 0);
    drawTurtle();
  
    if (wave) {
      if (distanceValue>maxDistance) {
        wave=false;
        distanceValue = 0f;
      } else distanceValue+=0.2f;
    }
    
    sh.set("u_time", float(millis())/float(1000)) ;
    sh.set("distanceValue", distanceValue) ;
  
    shader(sh);
    rect(0, 0, width, height);
    resetShader();
  }
}

void drawIntro() {
  background(0);
  textAlign(CENTER);
  f = createFont("Arial",26,true); 
  textFont(f);
  text("Haz click con el ratón para espantar a las tortugas",width/2,height/2); 

  
  textAlign(LEFT);
  f = createFont("Arial",18,true); 
  textFont(f);
  text("Hecho por: José Juan Reyes Cabrera",0,height/1.02); 

}

void mousePressed() {
  wave = true;
  distanceValue=0f;
  sh.set("u_mouse", float(mouseX), height - float(mouseY));

  lastMouseX = mouseX;
  lastMouseY = mouseY;
}
