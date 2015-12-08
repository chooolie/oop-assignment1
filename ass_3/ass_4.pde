import java.util.*;

ArrayList<Value> data = new ArrayList<Value>();
ArrayList<String> publisher = new ArrayList<String>();

int[] pub_arr;

float border;
int min, max ;
import java.util.*;
import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;
boolean keyP;

Minim minim;
AudioPlayer song;
PImage image;



float segments = 12;
int centX, centY;
float lastX, lastY;
int col = 100;

//int colInc = 1;
float rot = 0.0f; // rotate by this each time
import controlP5.*;

ControlP5 cp5;

//int colors = color(255);

boolean toggleValue = false;

color[] colors = new color[16];//[pub_arr.length];

void setup()
{
  size(1000, 1000);

  loaddata();

  calcMinMax();

  border = width * 0.1f;

  for (int i = 0; i < data.size (); i++)
  {
    publisher.add(data.get(i).publisher);
  }

  for (int i = 0; i < colors.length; i ++)
  {
    colors[i] = color(0, random(100, 255), random(100, 255));
  }

  Collections.sort(publisher);//function to sort in alphabetical order
  order();
  create_array();
  smooth();
  centX = width / 2;
  centY = height / 2;
  lastX = centX;
  lastY = centY; 
  //println(publisher);
  println("g1 = " + g1);
  println("g2 = " + g2);
  println("g3 = " + g3);
  println("g4 = " + g4);
  println(pub_arr[1]);
  //make noise
  minim = new Minim(this);
  song = minim.loadFile("page_flip.wav");
  //creating toggle button
  cp5 = new ControlP5(this);

  // create a toggle
  cp5.addToggle("toggleValue")
    .setPosition(40, 100)
    .setSize(50, 20)
    ;
}

void drawSpiral()
{

  float offset = 0.0f; // Offset each iteration by this
  background(0);
  image = loadImage("spirals.JPG");
  float bigRadius = 1;
  float smallRadius = 2;
  segments = 8;

  for (int i = 0; i < 30; i ++)
  {
    float thetaInc = TWO_PI / segments;    
    for (float theta = 0; theta < TWO_PI; theta += thetaInc)
    {
      float x = centX + sin(theta + offset + rot) * bigRadius; 
      float y = centY -cos(theta + offset + rot) * bigRadius;

      lastX = x;
      lastY = y;
      image(image, x, y, smallRadius * 2.0f, smallRadius * 2.0f);
    }
    bigRadius += 5f;
    smallRadius += 0.2f;
    offset += 0.1f;
  }

  rot += (float)(mouseX - centY) / ((float) height * 10.0f);
  text("Slide mouse accross screen to see all books", 100, 100);
  border= 20;
  if (mouseX >= border && mouseX <= width - 220)
  {
    stroke(255, 102, 178);
    fill(255, 0, 0);
    //line(mouseX, border, mouseX, height - border);
    int i = (int) map(mouseX, border, width - border, 0, data.size() - 1);
    fill(255);
    textSize(35);
    text(" " + data.get(i).title, mouseX + 10, 200);
  }
}

void drawMenu()
{
  background(0);
  stroke(255);
  strokeWeight(20);
  fill(255);
  line(0, 333, 1000, 333);
  line(0, 666, 1000, 666);
  textSize(40);
  fill(255, 51, 51);
  text("Press 1 for first graph", 250, 200);
  text("Press 2 for second graph", 245, 500);
  text("Press 3 for book animation", 240, 800);
}

void loaddata()
{
  String[] lines = loadStrings("Book2.csv");//add the file saved in folder called data
  for (int i = 0; i < lines.length; i ++)
  {
    Value value = new Value(lines[i]);
    data.add(value);
  }
}

void order()
{
  for (int c = 0; c < publisher.size(); c++)
  {
    if (publisher.get(c).equals("Transworld"))
    {
      g1++;//group 1
    }
    if (publisher.get(c).equals("Bloomsbury"))
    {
      g2++;
    }
    if (publisher.get(c).equals("Random House"))
    {
      g3++;
    }
    if (publisher.get(c).equals("Little Brown Book"))
    {
      g4++;
    }

    if (publisher.get(c).equals("Quercus"))
    {
      g5++;
    }
    if (publisher.get(c).equals("Penguin"))
    {
      g6++;
    }
    if (publisher.get(c).equals("Hodder & Stoughton"))
    {
      g7++;
    }
    if (publisher.get(c).equals("Pan Macmillan"))
    {
      g8++;
    }
    if (publisher.get(c).equals("Canongate"))
    {
      g9++;
    }
    if (publisher.get(c).equals("HarperCollins"))
    {
      g10++;
    }
    if (publisher.get(c).equals("Orion"))
    {
      g11++;
    }
    if (publisher.get(c).equals("Scholastic Ltd."))
    {
      g12++;
    }
    if (publisher.get(c).equals("Headline"))
    {
      g13++;
    }
    if (publisher.get(c).equals("Random House Childrens Books G"))
    {
      g14++;
    }
    if (publisher.get(c).equals("D.C. Thomson"))
    {
      g15++;
    }
    if (publisher.get(c).equals("Profile Books Group"))
    {
      g16++;
    }
  }
}

void create_array()
{
  pub_arr = new int[16];
  pub_arr[0] = g1;
  pub_arr[1] = g2;       
  pub_arr[2] = g3;
  pub_arr[3] = g4;
  pub_arr[4] = g5;
  pub_arr[5] = g6;
  pub_arr[6] = g7;
  pub_arr[7] = g8;
  pub_arr[8] = g9;
  pub_arr[9] = g10;
  pub_arr[10] = g11;
  pub_arr[11] = g12;
  pub_arr[12] = g13;
  pub_arr[13] = g14;
  pub_arr[14] = g15;
  pub_arr[15] = g16;


  //times it by 5 to use later in the book graph
  for (int i = 0; i < pub_arr.length; i++)
  {
    pub_arr[i] = pub_arr[i] * 5;
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
  textSize(20);
  strokeWeight(10);
  stroke(204, 153, 255);  
  line(border - 5, height - border, width - border, height - border);
  line(border, border, border, height - border + 5);


  for (int i = 1; i < data.size (); i ++)
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

int g1, g2, g3, g4, g5, g6, g7, g8, g9, g10, g11, g12, g13, g14, g15, g16;//15 publishers

void drawGraph2()
{


  background(255);
  stroke(0);

  strokeWeight(2);

  switch (mode2)
  { 
  case 0:
    {
      pushMatrix();
      //to change the color of the book cover
      if (toggleValue==true) {
        fill(255, 51, 51);
      } else {
        fill(0, 0, 255);
      }

      rect(500, 300, 300, 500);


      popMatrix();
      textSize(25);
      text("Press shift to see data in a graph",450,850);
      
      //fill(255, 0, 0);
      //rect(500, 300, 300, 500);
      fill(255);
      textSize(25);
      text("Different publishers", 520, 350);
      textSize(15);
      text("Transworld"+g1 +"%", 520, 390);
      text("Bloomsbury"+g2 +"%", 520, 410);
      text("Random House"+g3 +"%", 520, 430);
      text("Little Brown Book"+g4 +"%", 520, 450);
      text("Quercus"+g5 +"%", 520, 470);
      text("Penguin"+g6 +"%", 520, 490);
      text("Pan Macmillan"+g7 +"%", 520, 510);
      text("Canongate"+g8 +"%", 520, 530);
      text("HarperCollins"+g9 +"%", 520, 550);
      text("Orion"+g10 +"%", 520, 570);
      text("Scholastic Ltd"+g11 +"%", 520, 590);
      text("Headline"+g12 +"%", 520, 610);
      text("HRandom House Childrens Books G"+g13 +"%", 520, 630);
      text("D.C. Thomson"+g14 +"%", 520, 650);
      text("Profile Books Group"+g15 +"%", 520, 670);

      break;
    }


  case 1:
    { 
      textSize(25);
      text("Press shift to go back to the cover",450,850);
      fill(122);
      rectMode(CORNER);
      rect(200, 300, 300, 500);
      rect(500, 300, 300, 500);
      int var = 0;
      rectMode(CORNERS);
      for (int i = 0; i<pub_arr.length; i++)
      {
        stroke(colors[i]);
        fill(colors[i]);
        //fill(255);
        if (i>0)
        {

          rect(500, 300+var, 800, 300+var+pub_arr[i]);
          var = var + pub_arr[i];
        } else
        {

          rect(500, 300, 800, 300+pub_arr[i]);
          var = var + pub_arr[i];
        }
      }        
      rectMode(CORNER);
    }

    break;
  }
}

void draw()
{
  background(0);
  switch (mode)
  { 

  case 0:
    {
      drawMenu(); 
      break;
    }
  case 1:
    {
      drawLineGraph();
      drawGraph1();  
      break;
    }
  case 2:
    {
      drawGraph2();
      break;
    }
  case 3:
    {
      drawSpiral();
      break;
    }
  }
}



int mode = 0;
int mode2 = 0;

void keyPressed()
{
  if (key >= '0' && key <='3')
  {
    mode = key - '0';
  }
  if (key == CODED)
  {
    if (keyCode == SHIFT) 
    {
      if (mode2 == 1)
      {
        mode2 = 0;
        keyP=true;
        song.play();//plays song
        song.rewind();//rewinds back to start so it can play again
      } else
      {
        mode2 = 1;
        keyP=true;
        song.play();
        song.rewind();
      }
    }
  }

  println(mode, mode2);
}
