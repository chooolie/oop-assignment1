

void setup()
{
  size(500, 500, P3D);
  textMode(SHAPE);
  loadValues();
  
}

ArrayList<Value> values = new ArrayList<Value>();


void loadValues()
{
  String[] lines = loadStrings("Assignment.csv");//add the file saved in folder called data
  for (int i = 0 ; i < lines.length ; i ++)
  {
    Value value = new Value(lines[i]);
    //NOTE: values - is the array list value in brackets is your call of the class.
    values.add(value);
  }
}
 