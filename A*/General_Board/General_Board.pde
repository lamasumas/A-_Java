
Node[][] board;
boolean isOriginSet;
boolean isEndSet;
Algorithm algorithm;
PVector start;
PVector end;

/**
This set up the board
*/
void settings()
{
  size(900,900);
  board = new Node[800/50 -1 ][800/50 -1];
  isOriginSet = false;
  isEndSet = false;
  
}
/**
Initialize the  board 
*/
void setup() 
{
 for(int i= 0; i < 750; i+= 50)
 {
   for(int j = 0; j<750; j+=50)
   {
      board[i/50][j/50] = new Node(i,j, j/50,i/50) ;    
   }
 }
 
 
}

/**
This will loop during the execution and update the board
*/
void draw(){
  background(204);
  for(int i= 0; i < board.length; i++)
  {
   for(int j = 0; j<board[i].length; j++)
   {
      board[i][j].paint();
   }
 }
}

/**
Process mouse event
- Left click set up the start node
- Right click set up the end node
- Right click, after setting up the end node, set up obstacles
*/
void mousePressed(){
  
  int x = mouseX;
  int y = mouseY;
  int squareX = x/50;
  int squareY= y/50;
    
  if(x <800 && y<800 && squareX<15 && squareY<15)
  {
    if(mouseButton== LEFT && !isOriginSet){
      board[squareX][squareY].setOrigin();
      start = new PVector(squareX, squareY);
      isOriginSet=true;    
    }
    else if(mouseButton == RIGHT && !isEndSet){
       board[squareX][squareY].setEnd();
        end = new PVector(squareX, squareY);
        isEndSet = true;
      }
    else if(mouseButton==RIGHT && isOriginSet){
        board[squareX][squareY].isABlock = true;
 
    }
    
  }
  
}

/**
Process keyboard event:
- if 's' is pressed the algorithm starts executing
- if 'r' is pressed the board is reset
*/
void keyPressed(){
 if ( key == 's')
 {
   algorithm = new Algorithm(board, start,end);
   algorithm.start();
 }
 else if(key =='r')
 {
     settings();
     setup();
     draw();
 }
  
}
