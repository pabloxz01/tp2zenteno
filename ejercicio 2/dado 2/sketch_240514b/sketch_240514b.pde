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
  PImage[] dadoImages;
  
  Dado(float x, float y, float size) {
    super(x, y);
    this.size = size;
    
    dadoImages = new PImage[6];
    for (int i = 0; i < 6; i++) {
      dadoImages[i] = loadImage("dado" + (i + 1) + ".png");
    }
  }
  
  void roll() {
    value = int(random(1, 7));
  }
  
  void display() {
    PImage img = dadoImages[value - 1];
    image(img, position.x, position.y, size, size);
  }
}

class Tablero extends GameObject {
  ArrayList<Dado> dadosList;
  String resultText;
  
  Tablero(float x, float y) {
    super(x, y);
    dadosList = new ArrayList<Dado>();
    resultText = "";
  }
  
  void display() {
    background(220);
    
    for (int i = 0; i < dadosList.size(); i++) {
      Dado dado = dadosList.get(i);
      float offsetX = (i % 4) * 120;
      float offsetY = floor(i / 4) * 120;
      dado.position.set(position.x + offsetX, position.y + offsetY);
      dado.display();
    }
    
    fill(0);
    textSize(16);
    textAlign(RIGHT, TOP);
    text(resultText, width - 20, 20);
  }
  
  void rollDados() {
    Dado dado = new Dado(position.x, position.y, 100);
    dado.roll();
    dadosList.add(dado);
    updateResultText();
  }
  
  void updateResultText() {
    resultText = "Resultados: ";
    for (int i = 0; i < dadosList.size(); i++) {
      Dado dado = dadosList.get(i);
      resultText += dado.value + " ";
      
      if ((i + 1) % 4 == 0) {
        resultText += "\n";
      }
    }
  }
}

Tablero tablero;

void setup() {
  size(600, 400);
  
  tablero = new Tablero(width / 2, 50);
  
  createButton("Lanzar Dado", width / 2 - 50, height - 50, 100, 30);
}

void draw() {
  tablero.display();
}

void createButton(String label, float x, float y, float w, float h) {
  fill(200);
  rect(x, y, w, h, 10);
  
  fill(0);
  textSize(14);
  textAlign(CENTER, CENTER);
  text(label, x + w / 2, y + h / 2);
}

void mouseClicked() {
  if (mouseX > width / 2 - 50 && mouseX < width / 2 + 50 && mouseY > height - 50 && mouseY < height - 20) {
    tablero.rollDados();
  }
}
