
interface IDisplayable {
  void display();
}

interface IMoveable {
  void mover();
}

interface IController {
  void readCommand();
}


abstract class GameObject implements IDisplayable, IMoveable {
  PVector position;
  PImage img;
  float size;

  GameObject(float x, float y, String imgPath, float size) {
    position = new PVector(x, y);
    img = loadImage(imgPath);
    img.resize((int)size, (int)size); 
    this.size = size;
  }

  public void display() {
    image(img, position.x, position.y);
  }

  public abstract void mover();
}


class Nave extends GameObject implements IController {
  Nave(float x, float y, String imgPath, float size) {
    super(x, y, imgPath, size);
  }

  public void mover() {
   
  }

  public void readCommand() {
    if (keyPressed) {
      if (key == 'w') position.y -= 5;
      if (key == 's') position.y += 5;
      if (key == 'a') position.x -= 5;
      if (key == 'd') position.x += 5;
    }
  }

  public void disparar(ArrayList<Bala> balas) {
    balas.add(new Bala(position.x + size / 2, position.y, "bala.png", size));
  }
}


class Asteroid extends GameObject {
  Asteroid(float x, float y, String imgPath, float size) {
    super(x, y, imgPath, size);
  }

  public void mover() {
    position.y += 2; 
    if (position.y > height) {
      position.y = 0;
      position.x = random(width);
    }
  }
}


class Enemy extends GameObject {
  Enemy(float x, float y, String imgPath, float size) {
    super(x, y, imgPath, size);
  }

  public void mover() {
    position.y += 1; 
    if (position.y > height) {
      position.y = 0;
      position.x = random(width);
    }
  }
}


class Bala extends GameObject {
  Bala(float x, float y, String imgPath, float size) {
    super(x, y, imgPath, size / 2); 
  }

  public void mover() {
    position.y -= 5; 
  }
}


ArrayList<Bala> balas = new ArrayList<Bala>();


ArrayList<Asteroid> asteroids = new ArrayList<Asteroid>();


ArrayList<Enemy> enemies = new ArrayList<Enemy>();

Nave nave;

void setup() {
  size(800, 600);

  
  nave = new Nave(width / 2, height - 60, "nave.jpg", 50);


  for (int i = 0; i < 5; i++) {
    asteroids.add(new Asteroid(random(width), random(height / 2), "asteroid.png", 50));
  }


  for (int i = 0; i < 3; i++) {
    enemies.add(new Enemy(random(width), random(height / 3), "enemy.jpg", 50));
  }
}

void draw() {
  background(0);

 
  nave.readCommand();
  nave.display();

  
  for (int i = balas.size() - 1; i >= 0; i--) {
    Bala b = balas.get(i);
    b.mover();
    b.display();
    if (b.position.y < 0) {
      balas.remove(i); // Eliminar la bala si sale de la pantalla
    }
  }


  for (Asteroid a : asteroids) {
    a.mover();
    a.display();
  }

  
  for (Enemy e : enemies) {
    e.mover();
    e.display();
  }
}

void keyPressed() {
  if (key == ' ') {
    nave.disparar(balas); 
  }
}
