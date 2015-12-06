class Value
{
  int rank;
  String title;
  String  author;
  int volume_sales;
  String publisher;
 
   
  Value(String line)
  {
    //Need to split into parts before delcaring the parts
    String[] parts = line.split(",");
      
    rank = Integer.parseInt(parts[0]);
    title = parts[1];
    author = parts[2];
    volume_sales = Integer.parseInt(parts[3]);
    publisher = parts[4];
   
  }  
}