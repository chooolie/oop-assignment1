class Value
{
  float year;
  float mother_age;
  float within_marriage;
  float outside_marriage;
 
   
  Value(String line)
  {
    //Need to split into parts before delcaring the parts
    String[] parts = line.split("\t");
      
    year = Float.parseFloat(parts[0]);
    mother_age = Float.parseFloat(parts[1]);
    within_marriage = Float.parseFloat(parts[2]);
    outside_marriage = Float.parseFloat(parts[3]);
   
  }  
}