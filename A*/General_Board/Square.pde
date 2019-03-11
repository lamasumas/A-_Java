// This is the node class
class Node implements Comparable<Node>{
  //Position in the screen
  PVector pos;
  // Flags that can have the node
  boolean isOrigin;
  boolean isVisited;
  boolean isEnd;
  boolean isPath;
  boolean isABlock;
  // The parent node in order to get the best path
  Node parent;
  // Row and Col in the board
  int row;
  int col;
  //Cost of the path
  float g;
  //Estimated cost
  float h;
  //Total value prediction.
  float f;
  
  Node(int x, int y, int row, int col){
    pos = new PVector(x, y);
    this.row = row;
    this.col = col;
    isOrigin= false;
    isVisited = false;
    isABlock=false;
    paint();
  }
  
  /**
  Paint the node depending in the flag
  */
  void paint() {
   if(isOrigin){
     fill(255,255,0);
     rect(pos.x, pos.y, 45, 45);  
   }
   else if(isEnd){
     fill(0,255,250);
     rect(pos.x, pos.y, 45, 45);  
   }
   else if(isABlock){
     fill(70,70,0);
     rect(pos.x, pos.y, 45, 45); 
   }
   else if(isPath){
     fill(0,100,20);
     rect(pos.x, pos.y, 45, 45);  
   }
   else if(isVisited){
     fill(0,50,100);
     rect(pos.x, pos.y, 45, 45);  
   }
   else{
     fill(0,255,0);
     rect(pos.x, pos.y, 45, 45);
   
   }
  }
  
  void setOrigin(){
    if(!isEnd)
      isOrigin= true;
  }
  
  void setEnd(){
    if(!isOrigin)
      isEnd = true;  
  } 
  
  PVector getPos(){
    return pos;
    
  }
  
  void setABlock(){
   isABlock = true; 
  }
  
  /**
  This is a comparator for ordering later the neightbour list
  */
  public int compareTo(Node theNode){
    return this.f > theNode.f?1:-1;
  }
  
}
