import java.util.*;
// The class where the magic happens
class Algorithm{
 // Where is the start node
 PVector start;
 // Wjere is the end node
 PVector end;
 // A reference of the board
 Node[][] board;
 //List of neightbours
 ArrayList<Node> listOfNeightbourd;
 //List of visited nodes
 ArrayList<Node> visitedNodes;
 //Current node to analyze
 Node currentNode;
 //Iteration counter, for debuging purpose
 int iteration = 0;

 
 
 public Algorithm(Node[][] board, PVector start, PVector end){
   this.board = board;
   this.start = start;
   this.end = end;
   listOfNeightbourd = new ArrayList<Node>();
   visitedNodes = new ArrayList<Node>();
   
 }
 
 //Method that start the execution
 void start()
 {
   //First iteration done by hand
   currentNode =  board[(int)start.x][(int)start.y];
   visitedNodes.add(currentNode);
   analyzeNeightbours();
   Collections.sort(listOfNeightbourd);
   
 
   
   while( listOfNeightbourd.size()>0) //<>//
   {
     //Add the current node to the visited list
     currentNode = listOfNeightbourd.get(0);
     //Set the node as visited
     currentNode.isVisited=true;
     //Remove it from the neightbour list
     listOfNeightbourd.remove(0);
     //Add it to the visited list
     visitedNodes.add(currentNode);
     //Analyze the neightbours node of the current node
     analyzeNeightbours();
     //Sort in ascending order the neightbour list depending in the f value
     Collections.sort(listOfNeightbourd);
     //Get the lowest f  neightbour node 
 
     //if we arrive to the end node we stop
     if(currentNode.col == end.x && currentNode.row == end.y)
       break;
     iteration++;
    
   }
   //Paint the final path
   paintFinalPath();
   
 }
 
 
 /**
 Mark the node of the final path as "Final path" using the parent attribute
 */
 void paintFinalPath() {
  while(currentNode.parent!=null)
  {
    currentNode.isPath = true;
    currentNode = currentNode.parent;
  }
   
 }
 
 /**
 Analyze the neightbours nodes: Calculate the cost and add it to the neightbour list
 */
 void analyzeNeightbours(){
  for(int i= currentNode.col-1 ; i<= currentNode.col+1; i++){
       for(int  j = currentNode.row - 1; j<=currentNode.row+1;j++){
         if(i>=0 && i <board.length && j >= 0 && j< board[i].length && !board[i][j].isABlock)
         {
           //Check  if the node is in the visited list
          if(!visitedNodes.contains(board[i][j])){
            //Check if the node is not in the neightbourg list
           if(!listOfNeightbourd.contains(board[i][j])){
             //Add it to the list
             listOfNeightbourd.add(board[i][j]);
             //Safe the parent
             board[i][j].parent = currentNode;
             //Calculate the f,h,c value
             calculateCost((Node)board[i][j]);
           }
           //If it is in the neightbour list
           else{
             //Save the f value
             float f = (board[i][j].f);
             //Calculate again the g,h,f values
             calculateCost(board[i][j]);
             //Check if it is lower or not in order to save it the new path
             if(f<  board[i][j].f){
                board[i][j].f=f;
             }else{
              ((Node) board[i][j]).parent= currentNode;
             
           }
         }
       }
         }}
  }
 }
 
 //Calculate the g, h and f values
 void calculateCost(Node theNode){
   //Cost of the path
   theNode.g = 100;
   //Heuristic value, distance to the end node
   theNode.h = sqrt(pow(theNode.col - end.x,2)+pow(theNode.row - end.y,2));
   //the total heuristic value: the sum of g + h
   theNode.f = theNode.g + theNode.h;
   //we have to sum the parent heuristic cost to the new cost
   theNode.f = theNode.f +currentNode.f;
   
 }  
}
