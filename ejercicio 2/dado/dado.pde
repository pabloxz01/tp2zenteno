
abstract class GameObject {
  PVector position;
  
  GameObject(float x, float y) {
    position = new PVector(x, y);
  }
  
  abstract void display(); 
}

class Dado extends GameObject {
  int value;
  float size;
  
  Dado(float x, float y, float size) {
    super(x, y);
    this.size = size;
  }
  
  void roll() {
    value = int(random(1, 7));
  }
  
  void display() {
    rectMode(CENTER);
    fill(255);
    rect(position.x, position.y, size, size, 10);
    
    fill(0);
    textSize(20);
    textAlign(CENTER, CENTER);
    text(value, position.x, position.y);
  }
}

class Tablero extends GameObject {
  Dado dado;
  String resultText;
  
  Tablero(float x, float y) {
    super(x, y);
    dado = new Dado(x, y, 50); 
    resultText = "";
  }
 
  void display() {
    dado.display(); 
    
    fill(0);
    textSize(16);
    textAlign(RIGHT, TOP);
    text(resultText, position.x + 50, position.y - 50); 
  }
}

ArrayList<Dado> dadosList = new ArrayList<Dado>();
Tablero tablero;
boolean rolling = false;

void setup() {
  size(400, 400);
  
  tablero = new Tablero(width/2, height/2);
}

void draw() {
  background(220);
  
  tablero.display();
   
  fill(0);
  textSize(16);
  textAlign(CENTER, BOTTOM);
  text("Presiona ESPACIO para lanzar el dado", width/2, height - 20);
}

void keyPressed() {
  if (key == ' ' && !rolling) {
    tablero.dado.roll(); 
    dadosList.add(tablero.dado); 
    
    updateResultText();
    rolling = true;
  }
}

void updateResultText() {
  tablero.resultText = "Resultados: ";
  for (int i = 0; i < dadosList.size(); i++) {
    Dado dado = dadosList.get(i);
    tablero.resultText += dado.value + " ";
    
    if ((i + 1) % 4 == 0) {
      tablero.resultText += "\n"; 
    }
  }
}

void mouseClicked() {
  if (mouseX > width - 120 && mouseY < 20) {
    displayDadosResults();
  }
}

void displayDadosResults() {
  println("Dados obtenidos:");
  for (Dado dado : dadosList) {
    println(dado.value);
  }
}
