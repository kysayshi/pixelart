class pixel{
  
  // variables for position and size
  float xpos, ypos, size;
  float xStep, yStep;
  color fill;
  
  // pixel constructor function
  pixel(float x, float y, float diam){
    xpos = x; 
    ypos = y; 
    size = diam; 
  }
  
  // pixel display function
  void make(color fill){
    fill(fill); 
    noStroke();
    rect(xpos, ypos, size, size);
  }
  
}