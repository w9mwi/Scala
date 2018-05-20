// The following example shows how to read a text file,
// and print its contents to the screen.

import java.io.FileNotFoundException
import scala.io.{BufferedSource, Source}

object Demo
{
  def main(args: Array[String]): Unit =
  {
    try
    {
      val filePathAndName:String = "/home/tbouril/ch8.txt"
      var fileSource:BufferedSource = Source.fromFile(filePathAndName)

      // The fileSource DOES print here...
      println("1) fileSource.mkString = " + fileSource.mkString)

      // The fileSource does NOT print here, because the file iterator has been "spent."
      println("2) fileSource.mkString = " + fileSource.mkString)
      fileSource.close // When done using the file, always close it!

      // By default (as shown ABOVE), a Source and BufferedSource file iterator is of
      // type Iterator[Char], which means they read one Char at a time from the file.
      // Reading Chars one at a time is inefficient--so we can use other Iterator
      // types to read files.  For example, the code BELOW calls the getLines()
      // method, which uses a file iterator of type Iterator[String], which reads
      // one line of text (as a full String) at a time.
      fileSource = Source.fromFile(filePathAndName)
      val fileContents:Iterator[String] = fileSource.getLines
      println("\n3) fileContents = " + fileContents.mkString)
      fileSource.close // When done using the file, always close it!
    }
    catch
    { case fnfe:FileNotFoundException => println("File Not Found, Jack!") }
  }
}
=========================================================
=========================================================
object Demo
{
  def main(args: Array[String]): Unit =
  {
    val str:String = "Each word in this String is separated by a blank-space character, which is considered " +
      "the delimiter char.  This String of words is converted below to an Array[String] data type.  " +
      "Where each element in this Array will contain a single word in this String.  " +
      "No blank-space chars (the delimiter char.) will appear in the elements of this Array[String] " +
      "because the split() method called below designates that as the delimiter char.  When this " +
      "String prints, it will also print the Array index, which begins at zero."
    var arrayString:Array[String] = str.split(" ")
    var count:Int = 0
    for (tempString <- arrayString)
    {
      println(count + ") " + tempString)
      count += 1
    }
    // The next line of code shows how to use 's' char as the delimiter,
    // so the printed String will NOT contain the lowercase 's' char.
    arrayString = str.split("s+") // The '+' char means the char before it can occur 1 or
                                  // more times.  ('*' designates zero or more times.)
    println(arrayString.mkString) // PRINTS the text below...
  }
}
=========================================================
=========================================================
import java.io.FileNotFoundException
import scala.io.Source

object Demo
{
  def main(args: Array[String]): Unit =
  {
    try
    {
      // NOTE: The identityMatrix.txt file referenced below contains this text:
      //       1.0, 0.0, 0.0,
      //       0.0, 1.0, 0.0,
      //       0.0, 0.0, 1.0
      val filePathAndName:String = "/home/tbouril/identityMatrix.txt"
      // The following delimiter argument (" *, *") means zero or more
      // space chars. (' ') BEFORE the comma is valid, AND zero or more
      // space chars. (' ') AFTER the comma is valid.  Calling fileToDataGrid()
      // reads the identityMatrix.txt file into a 3X3 2-dimensional Array of
      // Double types.
      val matrix:Array[Array[Double]] = fileToDataGrid(filePathAndName, " *, *")
      println(matrix.flatten.mkString) // Prints: 1.00.00.00.01.00.00.00.01.0

      // ************************************************
      // The following code prints the 2 indices of each element in the 2-dimensional matrix
      // Array, and the contents of that element.  The first 2 of 8 lines printed are:
      // matrix(0)(0) = 1.0
      // matrix(0)(1) = 0.0
      var count_1:Int = 0
      var count_2:Int = 0
      for (tempArray_1 <- matrix)
      {
        for (tempArray_2 <- tempArray_1)
        {
          println("matrix(" + count_1 + ")(" + count_2 + ") = " + tempArray_2)
          count_2 += 1
        }
        count_1 += 1
        count_2 = 0 // Must reset the second index to zero.
      }
      // ************************************************
    }
    catch
    { case fnfe:FileNotFoundException => println("File Not Found, Jack!") }
  }

  /**
    * This dataGrid() function is a mind-mess.  Revisit this later.
    */
  def dataGrid(lines:Iterator[String], delim:String): Array[Array[Double]] =
  { (lines.map(s=>s.split(delim).map(_.toDouble))).toArray }

  /**
    * This fileToDataGrid() function is a mind-mess.  Revisit this later.
    */
  def fileToDataGrid(fileName:String, delim:String): Array[Array[Double]] =
  {
    val strIter:Iterator[String] = Source.fromFile(fileName).getLines()
    dataGrid(strIter, delim)
  }
}
=========================================================
=========================================================
import java.io.{File, FileNotFoundException}
import java.util.Scanner

import scala.io.{BufferedSource, Source}

object Demo
{
  def main(args: Array[String]): Unit =
  {
    try
    {
      // Instead of reading text from a file, the following line of code
      // reads text from a URL.  This text is then converted to a String.
      val text:BufferedSource = Source.fromURL("https://www.yahoo.com/")
      val pop = text.mkString

      // Below we use the Java Scanner class to read one "word" at a time,
      // and print it to the console.  Where "word" is any text String
      // separated by the delimiter, and the delimiter is whitespace by default.
      val filePathAndName:String = "/home/tbouril/ch8.txt"
      val scan:Scanner = new Scanner(new File(filePathAndName))
      while (scan.hasNext)
      {
        println(scan.next())
      }
      scan.close() // Don't forget to close the Scanner!
    }
    catch
    { case fnfe:FileNotFoundException => println("File Not Found, Jack!") }
  }
}
=========================================================
import java.io.File
import java.util.Scanner

object Demo
{
  def main(args:Array[String]): Unit =
  {
    // ints.txt is a text file of integers separated by space
    // and newline chars.
    val scan:Scanner = new Scanner(new File("/home/tbouril/ints.txt"))

    // Read each Int from the ints.txt file and print them to the console window.
    while (scan.hasNextInt)
    { println("Integer = " + scan.nextInt) }
  }
}
=========================================================
import java.io.{FileNotFoundException, FileWriter, PrintWriter}
import scala.io.{BufferedSource, Source}

object Demo
{
  def main(args: Array[String]): Unit =
  {
    try
    {
      val filePathAndName:String = "/home/tbouril/output.txt"

      // Create a new file, then write 100 random numbers to it,
      // where each number is followed by a single-space char.
      var pw = new PrintWriter(filePathAndName)
      for (idx <- 1 to 100) { pw.print(math.random + " ") }
      pw.flush();  pw.close(); // Don't forget to flush, then close the file!

      // Next, append 10 integers to the existing output.txt file created above.
      // The "true" Boolean parameter below prevents the file from being overwritten
      // if it already exists, so all new data will be appended to existing data.
      pw = new PrintWriter(new FileWriter(filePathAndName, true))
      for (idx <- 1 to 10) { pw.print(idx + " ") }
      pw.flush();  pw.close(); // Don't forget to flush, then close the file!

      // Next, open the output.txt file that was created above,
      // then print its contents to the console window.
      val fileSource:BufferedSource = Source.fromFile(filePathAndName)
      val stringOfNumbers:String = fileSource.mkString.map(replaceChar)
      println("stringOfNumbers = " + stringOfNumbers)
      fileSource.close() // Don't forget to close the file!
    }
    catch
    { case fnfe:FileNotFoundException => println("File Not Found, Jack!") }


    /**
      * This function replaces ' ' Chars with '\n' Chars,
      * @return
      */
    def replaceChar:(Char => Char) = { (a:Char) => if (a == ' ') '\n' else a }
  }
}
=========================================================
import java.io.{FileNotFoundException, PrintWriter}
import scala.io.{BufferedSource, Source}

object Demo
{
  def main(args: Array[String]): Unit =
  {
    try
    {
      val inFile:String  = "/home/tbouril/input.txt"
      val outFile:String = "/home/tbouril/output.txt"

      // The literal function c=>c.toUpper is what's
      // used to convert chars to uppercase.
      mapFile(inFile, outFile, c=>c.toUpper)
    }
    catch
    { case fnfe:FileNotFoundException => println("File Not Found, Jack!") }
  }

  /**
    * This function reads from the inFile, and writes that text to the
    * the outFile as all upper-case chars.
    *
    * @param inFile - An input file that contains text.
    * @param outFile - An output file that contains text copied from the inFile.
    * @param trans - A literal function that converts a char to uppercase.
    */
  def mapFile(inFile:String, outFile:String, trans:Char=>Char): Unit =
  {
    val pw:PrintWriter    = new PrintWriter(outFile)
    val in:BufferedSource = Source.fromFile(inFile)

    // The following for() loop converts each Char read from the
    // inFile to upper case, then writes it to the outFile.
    for (c <- in) { pw.print(if (c >= 'a' && c <= 'z' || c >= 'A' && c <= 'Z') trans(c) else c) }
    in.close();  pw.close();
  }
}
=========================================================
=========================================================
import scala.io.Source

object Demo
{
  type NameData = (String, Int, String, Int)

  def main(args: Array[String]) =
  {
    // Each line of the WI.TXT file contains comma-delimted String
    // data in this format:  stateAbbreviation, sex, year, name, numberBorn
    // EXAMPLE:  WI,M,1958,Thomas,1445
    val fileName:String = "/home/tbouril/ScalaData/WI.TXT"

    // Initialize an Array[String], where each element of the Array
    // contains a single line of text obtained from the WI.TXT file.
    val nameArray:Array[String]  = Source.fromFile(fileName).getLines().toArray
    val nameData:Array[NameData] = nameArray.map(parseLine)

    // Print the NameData tuple obtained from every element of the nameData Array.
    // nameData.foreach(println)

    println("nameArray contains " + nameArray.length + " lines of text.")

    val sex:String  = "M"
    val year:Int    = 1958
    val name:String = "Thomas"
    val data:Array[NameData] = nameData.filter(nd => nd._1.equalsIgnoreCase(sex)  &&
                                               nd._2 == year  &&
                                               nd._3.equalsIgnoreCase(name))

    // NOTE: Because of the way the WI.TXT file's data is defined, the data
    //       Array should always contain either zero elements, or one element.
    println("data contains " + data.length + " element(s).")
    if (data.length == 1)
    { println("Year = " + year + ", Sex = " + sex + ", Name = " + name + ", Number Born = " + data(0)._4) }
    else
    { println("No data found for Year = " + year + ", Sex = " + sex + ", Name = " + name) }

    val female1959:Array[NameData] = nameData.filter(x => x._1 == "F"  &&  x._2 == 1959)
    var maxNames:Int   = female1959.map(_._4).max

    // Print the NameData for the most common female name(s) born in 1959.
    female1959.filter(_._4 == maxNames).foreach(println)

    // Print the NameData for all female names occurring 100 times and born in 1959.
    val rose:Array[NameData] = nameData.filter(x => x._1 == "F"  &&  x._2 == 1959  &&  x._4 == 100)
    rose.foreach(println)
  }

  /**
    * Pass this function a line of text delimited by commas where the line
    * of text has this format: (String, String, Int, String, Int).  Then,
    * return the final 4 values of that String as the type NameData.
    * @param line
    * @return
    */
  def parseLine(line:String): NameData =
  {
    val parts:Array[String] = line.split(",")
    (parts(1), parts(2).toInt, parts(3), parts(4).toInt)
  }
}
=========================================================
=========================================================
