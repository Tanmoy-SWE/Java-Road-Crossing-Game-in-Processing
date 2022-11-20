
//The below 4 variable controls the game settings and difficulity
int lives = 3;
int lines = 5;
int n_cars = 2;
int speed_of_cars = 12;


float[] x = new float[8]; //declaring a variable named x,y
float y; 
float[] carWidth = new float[8];//declaring a variable named carWidth,carHeight,wheelDiameter
float[] carHeight = new float[8];
float wheelDia;
int i;
float xspeed=1; //declaring the speed
int X;
int p; //declaring variable for pedestrian p,q,r & s
int q;
int rate; //speed of the pedestrian
int r;
int s, ind;
int pts = 0;
PFont f;


int[] colors = {#ff0000,#4DC943, #0000ff};  //color of the cars
  
float[] carX = new float[8];     //Declaring the array of x axis position of cars


void setup() {
  size(1200, 800); //setting the size 
  f = createFont("Arial",16,true); //Format of the text
  y = height/5;
  for(int j=0; j<lines; j++){    // for loop for cars position, width and height of each line
      x[j] = random(200,500);    // putting value for x,y,carWeidth,carHeight and wheeldiameter
      carWidth[j] = width/6;
      carHeight[j] = carWidth[j]/4.5;
  }
  wheelDia = carHeight[0]/3;  // Defining diameter of the wheels of the vehicle
  p=width/2;  //setting value for pedestrian location and height width
  q=height-30;
  r=40;
  s=40;
  rate=height/6;
}


void drawLines(int line1){
  for(int z=0; z<line1; z++){  //for loop for drawing no of lines defined in lines variable
    for (int i=0; i < width; i =i+10) { //for loop for the dash line ..
        line(i, y-25+(z*50), i+4, y-25+(z*50)); 
    }  
  }

}

void addPoints(){
   if (q<=0 ){
     p=width/2;  //setting value for pedestrian location and height width
     q=height;
     pts = pts + 1;
     setup();
  }
}

void isLost(){
   for(int i=0; i<lines; i++){
      if (x[i]>p-r && x[i]<p+r && y-50+(i*50)>q-s && y-50+(i*50)<q+s){ //if the pedestrian touches the car then you will loose ..
          background(255);
          stroke(0);
          textAlign(CENTER, BOTTOM);
          textSize(100);
          text("GAME OVER!", width/2, height/2);  //End Note
          setup();     //setup the screen again after a round is lost 
          if(lives<=0){ //If the player has no life left
            noLoop();  // ending the game
          }
          lives = lives - 1; //reducing life in each losing round
      } 
      if(pts==5){  //If player scores 5 points then wins the game
          background(255);
          stroke(0);
          textAlign(CENTER, BOTTOM);
          textSize(100);
          text("YOU WIN!", width/2, height/2); //End Note of winning message
      }
   }
}




void draw() {

  background(255);
  textFont(f,16);                  // STEP 3 Specify font to be used
  fill(0);                         // STEP 4 Specify font color
  text("Total Points : "+pts,width-200,height-50);
  text("Total Lives Left : "+lives,width-200,height-80);
  stroke(0);
  strokeWeight(1.5);
  //line(0, height/4, width, height/4);
  drawLines(lines);  // passing number of lines defined by me in the drawline function

  rectMode(CENTER); //specify center coordinates instead of top-left coordinates
  fill(#4DC943);
  stroke(0);
  strokeWeight(1);
  for(int i=0; i<speed_of_cars; i++){  //for loop for setting up the speed of the cars
    for(int j=0; j<n_cars; j++){  //for loop for number of cars in a single line
      ind = i%lines;  //making sure ind has a value range between 0 to (lines - 1)
      rect(x[ind]+j*250-200, y-50+(ind*50), carWidth[ind], carHeight[ind]); // first rectangle shape of the car
      fill(colors[ind%3]);  //Defining different colors using colors array
      rect(x[ind]+j*250-200, y-50+(ind*50), carWidth[ind], carHeight[ind]/3); //midddle rectangle of the car
      fill(255);
      if(ind==0){  // Setting window only for the first car
          square(x[ind]+j*250-200+2*carWidth[ind]/5, y-50-2*carHeight[ind]/6, wheelDia);//window of the car
      }
      noStroke();
      fill(0);
      circle(x[ind]+j*250-200-2*carWidth[ind]/6, y-50+(ind*50)+3*carHeight[ind]/6, wheelDia); //first wheel of the car
      circle(x[ind]+j*250-200+2*carWidth[ind]/6, y-50+(ind*50)+3*carHeight[ind]/6, wheelDia); // 2nd wheel of the car
      x[ind] = x[ind] + xspeed + random(-3,3); //car is moving having a random acceleration 
      if (x[ind]>width+carWidth[ind]/2) { //reset loop
        x[ind]=-carWidth[ind];
      } else {
        x[ind] = x[ind] + xspeed + random(-5,5);  //car is moving having a random acceleration 
      }
    }
  }
  fill(#EA2D2D);
  //image(img, p, q, r, s);
  rect(p, q, r, s); //setting the pedestrian
  isLost(); //Checking if the pedestrian crossed the lines. If not, lives reduced by 1.
  addPoints(); //Adding points if the pedestrian crossed the line
} 

void keyPressed() {
  if (key == 'a') // the pedestrian will go left if i press a
    p=p-height/16;
  if (key=='d')//// the pedestrian will go right if i press d
    p=p+height/16;
  if (key=='w')// the pedestrian will go up if i press w
    q=q-height/16;
  if (key=='s')// the pedestrian will go down if i press s
    q=q+height/16;
}
