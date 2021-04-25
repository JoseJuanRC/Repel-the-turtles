import java.util.LinkedList;
import java.util.Comparator;

float lastTurtleTime = 0;
float timeBetweenTurtles = 1500;

LinkedList<Turtle> turtles = new LinkedList<Turtle>();

void checkNewTurtle() {

  
  if (millis() - lastTurtleTime > timeBetweenTurtles) {
    lastTurtleTime = millis();
    turtles.add(new Turtle());
    
    // Ordenamos la lista para que los más pequeños aparezcan debajo de los grandes
    turtles.sort(new Comparator<Turtle>(){
    @Override
        public int compare(Turtle t1,Turtle t2){
            return int (t1.size - t2.size);
        }
    });
  }
}

void deleteTurtle() {
  for (int i = 0; i<turtles.size(); i++)
    if (turtles.get(i).deleteTurtle()) {
      turtles.remove(i);
      break;
    }
}

void drawTurtle() {
  checkNewTurtle();
  deleteTurtle();
  
  for (Turtle turtle : turtles) {
    turtle.drawTurtle();
  }
}


public class Turtle {

  private float xPos;
  private float yPos;
  
  private float xInc;
  private float yInc;
  
  private float rot;
  
  private PImage shape;
  
  private boolean chageDirection;
  public float size;
  
  
  public Turtle() {
    yPos = random(0, height);
    xPos = width*1.2;
    
    xInc = -random(3,6);
    yInc = 0;
    
    rot = -PI/2;
    
    size = random(50,150);
    shape = loadImage("Textures/turtle.png");
    
    chageDirection = true;
    
  }
  
  public boolean deleteTurtle() {
    return (xPos < -width/5 || xPos > width*1.5 || yPos < -height/5 || yPos > height*1.5);
  }
  
  public void drawTurtle() {
    push();
    if (chageDirection && wave) checkChangeDirectation();
    xPos+=xInc;
    yPos+=yInc;
    
    translate(xPos,yPos, 0);
    rotateZ(rot);
    image(shape, -size/2, -size/2, size, size);
    pop();
  }
  
  private void checkChangeDirectation() {
    if (Math.sqrt(pow(lastMouseX-xPos,2) +pow(lastMouseY - yPos,2)) < size + distanceValue) {

      xInc = min(max(-lastMouseX + xPos,-6),6);
      yInc = min(max(-lastMouseY + yPos,-6),6);
      
      float x = 0;
      float y = -1;
      
      float vx = xInc;
      float vy = yInc;
      
      float mod = (float) Math.sqrt(Math.pow(vx,2) + Math.pow(vy,2));
      
      vx /= mod;
      vy /= mod;
      
      // Calculamos el ángulo de rotación
      rot = acos((y*vy + x*vx)/(x*x+y*y));
      
      if (lastMouseX>xPos) {
       
        if (lastMouseY>yPos) rot-=PI/2;
        else rot+=PI/2;
      }
      
      chageDirection = false;
      
    }
      
  }
}
