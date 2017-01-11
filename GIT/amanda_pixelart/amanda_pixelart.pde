/* 
Amanda Herz
CS2 Fall 2016

P I X E L  A R T
See what art pieces you can create with your mouse!

(A program for abstracting and then realizing famous art pieces.
Press the SPACEBAR to put down or pick up your brush.
Press ENTER to switch to a different source artwork.
Press DELETE to pick up your brush clear the canvas (and don't forget to press SPACEBAR when you're ready to draw again).
Press 'S' to save your work!
Change the pixelation and smear of brush in the variables below.)

*/

// variables for determining pixelation and smear of brush (larger # = more pixelated and more smeared)
int pixelation = 2; 
float smear = 1; //0, 1, 2

// creates new array list to hold current pixels
ArrayList<pixel> pixels = new ArrayList<pixel>(); 

// creates new PImage to hold the current artwork
PImage srcImg;

// variables for determining color
color fill;
color fill1,fill2,fill3,fill4;

// variables for switching source artwork or reseting canvas
int scheme;
int drawscheme;
boolean switchS = false;
boolean reset = false;
boolean splitP = true;

// variables for determining index
int index1,index2,index3,index4;

// boolean for determing whether loop is on or off
boolean loop = true;

// creates an object of the pixel class
pixel pixel;


void setup(){
  
  size(750,750); // size matches image
 
  // sets modes for appearance and location
  colorMode(HSB,360,100,100);
  imageMode(CENTER);
  rectMode(CORNER);
  noStroke();
  
  // begins with a random source artwork
  switchScheme();

  // adds initial pixels to array list and then draws them
  pixels.add(new pixel(0,0,width/2));
  pixels.add(new pixel(0,height/2,width/2));
  pixels.add(new pixel(width/2,0,width/2));
  pixels.add(new pixel(width/2,height/2,width/2)); //<>// //<>//
  drawPixels();
  
}


void draw(){ 
  
  // if ENTER was pressed...  
  if (switchS == true){ 
    
    // switches to a new random source work 
    switchScheme();
    switchS = false;
  }
  
  if (splitP == true){
    
    // splits an individual pixel into pixels depending on mouse position
    splitPixel();  
  }
  
  if (reset == true){  //<>// //<>//
     //<>// //<>//
    int listLength = pixels.size()-1;
    
    // removes all pixels currently on list
    for(int i=listLength; i>-1; i--){ //<>// //<>//
      pixels.remove(i); //<>// //<>//
    } //<>// //<>//
    
    // adds then draw starting pixels //<>// //<>//
    pixels.add(new pixel(0,0,width/2)); //<>// //<>//
    pixels.add(new pixel(0,height/2,width/2)); //<>// //<>//
    pixels.add(new pixel(width/2,0,width/2)); //<>// //<>//
    pixels.add(new pixel(width/2,height/2,width/2)); //<>// //<>//
    drawPixels(); //<>// //<>//
    
    reset = false; //<>// //<>//
    loop = false; //<>// //<>//
  }
}


// function that draws the first four pixels from the list
void drawPixels(){
    //<>// //<>//
    for (int i=0;i<4;i++){
      
        // uses the pixel values directly behind the corner of each pixel to determine fill
        fill = srcImg.get(int(pixels.get(i).xpos),int(pixels.get(i).ypos));
        
        // draws pixel with said fill
        pixels.get(i).make(fill); //<>// //<>//

    }
}


void splitPixel(){
  
   // adjusts smear to realistic bounds
   if (smear>2) smear = 2;
   
   // for each pixel in pixels...
   for(int i = 0; i<pixels.size(); i++){
     
     // if the mouse is within the bounds of that pixel...
     if (mouseX>pixels.get(i).xpos &&
     mouseX<pixels.get(i).xpos+pixels.get(i).size && 
     mouseY<pixels.get(i).ypos+pixels.get(i).size &&
     mouseY>pixels.get(i).ypos){
       
         // variables to hold the indexes of the next four list additions
         index1 = pixels.size();
         index2 = pixels.size()+1;
         index3 = pixels.size()+2;
         index4 = pixels.size()+3;
         
         // if the size of that pixel is greater than the pixelation value...
         if (pixels.get(i).size > pixelation){
           
           // add four pixels that are a quarter of it's size to the list
           pixels.add(new pixel(pixels.get(i).xpos, pixels.get(i).ypos, pixels.get(i).size/2+smear));
           pixels.add(new pixel(pixels.get(i).xpos+pixels.get(i).size/2, pixels.get(i).ypos+pixels.get(i).size/2, pixels.get(i).size/2+smear));
           pixels.add(new pixel(pixels.get(i).xpos, pixels.get(i).ypos+pixels.get(i).size/2+1, pixels.get(i).size/2+smear));
           pixels.add(new pixel(pixels.get(i).xpos+pixels.get(i).size/2, pixels.get(i).ypos, pixels.get(i).size/2+smear));
           
           // set their fills according to source artwork
           fill1 = srcImg.get(int(pixels.get(i).xpos),int(pixels.get(i).ypos));
           fill2 = srcImg.get(int(pixels.get(i).xpos+pixels.get(i).size/2),int(pixels.get(i).ypos+pixels.get(i).size/2));
           fill3 = srcImg.get(int(pixels.get(i).xpos),int(pixels.get(i).ypos+pixels.get(i).size/2));
           fill4 = srcImg.get(int(pixels.get(i).xpos+pixels.get(i).size/2),int(pixels.get(i).ypos));
           
           // draw those pixels
           pixels.get(index1).make(fill1);
           pixels.get(index2).make(fill2);
           pixels.get(index3).make(fill3);
           pixels.get(index4).make(fill4);
           
           // remove the initial reference pixel from the list
           pixels.remove(i);
         }
     }
   }
}


// function that enables source artwork switch while drawing
void switchScheme(){

    // avoids repeating sourceworks
    int temp = drawscheme;
    drawscheme = floor(random(20));
    if (drawscheme == temp && temp !=0) drawscheme = floor(random(temp));
    else if (drawscheme == temp && temp == 0) drawscheme = floor(random(1,20));
    
    // switches to one of ten artworks
    switch(drawscheme){
      case 0:
        println("monet");
        srcImg = loadImage("monet.png");
        redraw();
        break;
      case 1:
        println("kahlo");
        srcImg = loadImage("kahlo.jpg");
        redraw();
        break;
      case 2:
        println("murakami");
        srcImg = loadImage("murakami.jpg");
        redraw();
        break;
      case 3:
        println("beksinski");
        srcImg = loadImage("beksinski.jpg");
        redraw();
        break;
      case 4:
        println("lichtenstein");
        srcImg = loadImage("lichtenstein.jpg");
        redraw();
        break;
      case 5:
        println("gaugin");
        srcImg = loadImage("gauguin.jpg");
        redraw();
        break;
      case 6:
        println("okeefe");
        srcImg = loadImage("okeefe.jpg");
        redraw();
        break;
      case 7:
        println("klimt");
        srcImg = loadImage("klimt.jpg");
        redraw();
        break;
      case 8: 
        println("basquiat");
        srcImg = loadImage("basquiat.jpg");
        redraw();
        break;
      case 9:
        println("bosch");
        srcImg = loadImage("bosch.jpg");
        redraw();
        break;
      case 10:
        println("bosch");
        srcImg = loadImage("bosch.jpg");
        redraw();
        break;
      case 11:
        println("hokusai");
        srcImg = loadImage("hokusai.jpg");
        redraw();
        break;
      case 12:
        println("warhol");
        srcImg = loadImage("warhol.jpg");
        redraw();
        break;
      case 13:
        println("manet");
        srcImg = loadImage("manet.jpg");
        redraw();
        break;
      case 14:
        println("dali");
        srcImg = loadImage("dali.jpg");
        redraw();
        break;
      case 15:
        println("pollock");
        srcImg = loadImage("pollock.jpg");
        redraw();
        break;
      case 16:
        println("magritte");
        srcImg = loadImage("magritte.jpg");
        redraw();
        break;
      case 17:
        println("picasso");
        srcImg = loadImage("picasso.jpg");
        redraw();
        break;
      case 18:
        println("stella");
        srcImg = loadImage("stella.jpg");
        redraw();
        break;
      case 19:
        println("vermeer");
        srcImg = loadImage("vermeer.jpeg");
        redraw();
        break;
      }   
}


void keyPressed() {

  // switches draw loop back on
  if ( key == ' '){
    if(loop == true){
      noLoop(); 
      loop = false;
    }else if(loop == false){
      splitP = true;
      loop();
      loop = true;
    }
  }
  
  // switches scheme
  if (key == RETURN || key == ENTER){
    switchS = true;
  }
  
  // resets pixels
  if (key == DELETE || key == BACKSPACE){
    splitP = false;
    reset = true;
  } //<>// //<>//
  
  // saves frame
  if ( key == 's'|| key  == 'S') saveFrame("pixel_art_####.jpg");
}