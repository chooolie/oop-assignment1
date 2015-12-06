import java.util.*;

ArrayList<Value> data = new ArrayList<Value>();
ArrayList<String> publisher = new ArrayList<String>();




float border;
int min, max;

void setup()
{
  size(1000, 1000);

  loaddata();
  calcMinMax();
  border = width * 0.1f;
  
  for(int i = 0; i<data.size();i++)
{
  publisher.add(data.get(i).publisher);
}

//println(publisher);
Collections.sort(publisher);//function to sort in alphabetical order
println(publisher);
}



void loaddata()
{
  String[] lines = loadStrings("Book2.csv");//add the file saved in folder called data
  //println(lines);
  for (int i = 0; i < lines.length; i ++)
  {
    Value value = new Value(lines[i]);
    //NOTE: values - is the array list value in brackets is your call of the class.
    data.add(value);
  }
}

void calcMinMax()
{

  max = data.get(0).volume_sales;
  min = data.get(0).volume_sales; 

  for (Value v : data)

  {
    if (v.volume_sales < min)
    {
      min = v.volume_sales;
    }
    if (v.volume_sales > max)
    {
      max = v.volume_sales;
    }
  }
}


void drawLineGraph()
{
  
  //part of first graph
  
  stroke(204, 153, 255);  
  line(border - 5, height - border, width - border, height - border);
  line(border, border, border, height - border + 5);


  for (int i = 1; i < data.size(); i ++)
  {
    stroke(204, 255, 255);
    float x1 = map(i - 1, 0, data.size() - 1, border, width - border);
    float y1 = map(data.get(i - 1).volume_sales, min, max, height - border, border);
    float x2 = map(i, 0, data.size() - 1, border, width - border);
    float y2 = map(data.get(i).volume_sales, min, max, height - border, border);
    line(x1, y1, x2, y2);
  }
}



void drawGraph1()
{
  if (mouseX >= border && mouseX <= width - border)
  {
    stroke(255, 102, 178);
    fill(255, 0, 0);
    line(mouseX, border, mouseX, height - border);
    int i = (int) map(mouseX, border, width - border, 0, data.size() - 1);
    float y = map(data.get(i).volume_sales, min, max, height - border, border);
    ellipse(mouseX, y, 5, 5);
    fill(255);
    text("Title: " + data.get(i).title, mouseX + 10, y);
    text("Author: " + data.get(i).author, mouseX + 10, y + 10);
    text("Volumes sold: "+ data.get(i).volume_sales, mouseX +10, y+20);
  }
}
void drawGraph2()
{
  
  
   background(255);
   stroke(0);
   switch (mode2)
  { 
  case 0:
  {
    fill(255,0,0);
   rect(500,300,300,500);
   break;
  }
  
  case 1:
  {
   for(int c = 0;c<publisher.size();c++) 
   {
     print(c);
   }
    
   
  
   /* fill(122);
    rect(500,300,300,500);
    rect(200,300,300,500);
    */
    
   
    break;
  }
   
  
}
}



void draw()
{
  background(0);
  switch (mode)
  { 
  case 0:
    {
      drawLineGraph();
      drawGraph1();

      break;
    }
  case 1:
    {

     drawGraph2();

      break;
    }
  }
}



int mode = 0;
int mode2 = 0;

void keyPressed()
{
  if (key >= '0' && key <='9')
  {
    mode = key - '0';
  }
    if (key == CODED)
  {
    if (keyCode == SHIFT) 
    {
      if(mode2 == 1)
      {
          mode2 = 0; }
      
      else
      {
          mode2 = 1; }
      }
    }
  println(mode,mode2);
}