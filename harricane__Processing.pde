import processing.opengl.*;
ParticleSystem ps = new ParticleSystem();
boolean saveF = false,fixcheck = false;
int ball = 0,num=0;
 
void setup(){
  size(872,480,OPENGL);
  colorMode(HSB);
  noStroke();
  sphereDetail(6);
  ellipseMode(RADIUS);
}
 
void draw()
{
  background(#000000);
  lights();
  if(keyPressed && key != 'r' && key != 'e' && key != 'f' && key != 'p' && ball < 184)
  {
    ps.add(new Particle(width/2, height/2,-600,num));
    num++;
    ball++;
    if(saveF == false) saveF = true;
  }
  else if(keyPressed && key == 'p'){
    fixcheck = true;
  }
  else if(keyPressed && key == 's' && fixcheck == true){
    ps.restart();
    fixcheck = false;
  }
  else if(keyPressed && key == 'f'){
  }
  ps.run();
}
 
class Particle
{
  float x = width/2;
  float y = height/2;
  float z = -15;
  float ter_x,ter_y,ter_z=-50;
  float xv = -20+random(40);  
  float yv = -20+random(40);
  float zv= random(10);
  float maxYV = 20;
  float gravity = 0.1;
  float friction = 0.8;
  float radius = random(40) + 15;
  float radius_tmp;
  float b_xv,b_yv,b_zv;
  float ac = random(30,150);
  int rand,type;
  int fix_i = 0;
  color c = color((int)(Math.random()*255),255,255,255); 
  boolean bx = false,by = false,bz = false,fixfirst = true;
  
  Particle(){}
  
  Particle(float xp,float yp,float zp,int num){
    x = xp;
    y = yp;
    z = zp;
   radius_tmp = radius;
   terminal(num);
  }
 
  Particle(float xp,float yp,float zp,float xvel,float yvel,float zvel){
    this(xp, yp,zp,0);
    xv = xvel;
    yv = yvel;
    zv = zvel;
    radius = random(7,13);
  }
 
  void run(){
    update();
    render();
  }
 
  public void update(){
    if(x <= 0 && bx == false){
      b_xv = xv;
      xv = 0;
      bx = true;
    }
    else if(x >= width && bx == false){
      b_xv = xv;
      xv = 0;
      bx = true;
    }
 
    if(y > height && by == false){
      b_yv = yv;
      yv = 0;
      by = true;
    }else if(y < 0 && by == false){
      b_yv = yv;
      yv = 0;
      by = true;
    }
    if(z < -600 && bz == false){
      b_zv = zv;
      zv = 0;
      bz = true;
    }else if(z > 100 && bz == false){
      b_zv = zv;
      zv = 0;
      bz = true;
    }
    
    if(bx == true){
      xv += -b_xv/ac;
      if(abs(xv) >= abs(b_xv)){
        bx = false;
      }
    }
    if(by == true){
      yv += -b_yv/ac;
      if(abs(yv) >= abs(b_yv)){
        by = false;
      }
    }
    if(bz == true){
      zv += -b_zv/ac;
      if(abs(zv) >= abs(b_zv)){
        bz = false;
      }
    }
    y += yv;
    x += xv;    
    z += zv;    
    if(radius < radius_tmp) radius++;
    else if(radius > radius_tmp) radius--;   
  }
  
  void fix(){
      if(fixfirst == true){
      xv = (ter_x - x) /10;
      yv = (ter_y - y) /10;
      zv = (ter_z - z) /10;
      fixfirst = false;
      }
       if(fix_i < 5){
      x += xv;
      y += yv;
      z += zv;
       }
       if(radius > 20){
       radius -=0.6;
       }else if(radius < 19){
       radius += 0.6;
       }
      render();
      fix_i++; 
      if(fix_i == 5){
      fix_i = 0;
      fixfirst =  true;
      }  
      if(abs(ter_x - x) < 3 && abs(ter_y - y) < 3 && abs(ter_z - z) < 3){
      fix_i = 6;
      xv = 0;
      yv = 0;
      zv = 0;
      }   
  }
  
  void render(){
    fill(c);
    pushMatrix();
    translate(x,y,z);
    sphere(radius);
    popMatrix();
  }
    
  void terminal(int num){
    if(num<9){
      ter_x = 30;
      ter_y = 29*num;
    }else if(num < 11){
      ter_x = 57 + 27*(num-9);
      ter_y = 110;
    }else if(num < 20){
      ter_x = 110;
      ter_y = 29*(num-11);
    }
    else if(num < 29){
      ter_x = 235 - (num-20)*6.25;
      ter_y = 5 + (num-20)*28.125;
    }else if(num < 37){
      ter_x = 241.25 + (num-29)*6.25;
      ter_y = 33.125 + (num-29)*28.125;
    }else if(num < 38){
      ter_x = 235;
      ter_y = 160;
    }
 
    else if(num < 47){
      ter_x = 350;
      ter_y = (num-38)*28.75;
    }else if(num < 50){
      ter_x = 383.33 + (num-47) * 33.33;
      ter_y = 0;
    }else if(num < 53){
      ter_x = 383.33 + (num-50) * 33.33;
      ter_y = 110;
    }else if(num < 55){
      ter_x = 450;
      ter_y = 43.33 + (num-53) * 33.33;
    }else if(num < 59){
      ter_x = 375 + (num-55)*25;
      ter_y = 140 + (num-55)*30;
    }
    else if(num < 68){
      ter_x = 530;
      ter_y = (num-59)*28.75;
    }else if(num < 71){
      ter_x = 563.33 + (num-68) * 33.33;
      ter_y = 0;
    }else if(num < 74){
      ter_x = 563.33 + (num-71) * 33.33;
      ter_y = 110;
    }else if(num < 76){
      ter_x = 630;
      ter_y = 43.33 + (num-74) * 33.33;
    }else if(num < 80){
      ter_x = 555 + (num-76)*25;
      ter_y = 140 + (num-76)*30;
    }
    
    else if(num < 82){
      ter_x = 720 +(num-80)*30;
      ter_y = 0;
    }else if(num < 84){
      ter_x = 720 +(num-82)*30;
      ter_y = 230;
    }else if(num < 92){
      ter_x = 735;
      ter_y = 28.75 +(num-84)*28.75;
    }
 
    else if(num < 101){
      ter_x = 250 +(num-92) * 13.5;
      ter_y = 280;
    }else if(num < 107){
      ter_x = 250;
      ter_y = 280 +(num-101)*34;
    }else if(num < 113){
      ter_x = 250 +(num-107) * 20.25;
      ter_y = 480;
    }
 
    else if(num < 121){
      ter_x = 460 - (num-113)*6.25;
      ter_y = 280 + (num-113)*28.125;
    }else if(num < 128){
      ter_x = 466.125 + (num-121)*6.25;
      ter_y = 308.125 + (num-121)*28.125;
    }else if(num < 139){
      ter_x = 460;
      ter_y = 425;
    }
 
    else if(num < 148){
      ter_x = 570 ;
      ter_y = 280 +(num-139) * 26.25;
    }else if(num < 157){
      ter_x = 670;
      ter_y = 280 +(num-148) * 26.25;
    }else if(num < 164){
      ter_x = 582.5 +(num-157)*12.5;
      ter_y = 306.25 +(num-157) * 26.25;
    }
 
    else if(num < 173){
      ter_x = 760;
      ter_y = 280 +(num-164) * 26.25;
    }else if(num < 177){
      ter_x = 785 +(num-173)*25;
      ter_y = 280;
    }else if(num < 181){
      ter_x = 785 +(num-177)*25;
      ter_y = 490;
    }else if(num < 184){
      ter_x = 785 +(num-181)*25;
      ter_y = 385;
    }
  }
  
  void restart(){
    xv = -20 + random(40);
    yv = -20 + random(40);
    zv = random(10);
    fixfirst = true;
    fix_i = 0;
  } 
}
 
class ParticleSystem
{
  ArrayList particles = new ArrayList();
  ParticleSystem(){}
  void add(Particle p){
    particles.add(p);
  }
   
  void removeAll(){
    particles.clear();
  }
  void run(){
    for(int i = 0; i < particles.size(); i++){
      Particle p = (Particle)particles.get(i);
      if(fixcheck == false) p.run();
      else p.fix();
    }
  }
  
  void restart(){
    for(int i=0;i<particles.size();i++){
      Particle p = (Particle)particles.get(i);
      p.restart();
    }
  }
}
