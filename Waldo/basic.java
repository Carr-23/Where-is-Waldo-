import java.awt.*;
import hsa.Console;
import hsa.Message;
import java.io.*;


public class Numeric2DArray
{
    Console c = new Console ();

    String input;

    static final int row = 4;
    static final int col = 5;
    int min, max, total, end1, end2;
    int[] [] number = new int [row] [col];

    boolean anything = true;

    public void askData ()
    {

	while (anything)
	    try
	    {
		c.setCursor (1, 1);
		c.setColor (Color.white);
		c.fillRect (0, 0, 640, 500);
		c.print ("Enter The amount of random integers you want to store (max 20): ");
		input = c.readLine ();

		total = Integer.parseInt (input);

		if (total <= 20 && total > 0)
		{
		    break;
		}
		new Message ("Pleas Input a value less than 20!", "Error Message");
	    }

	catch (NumberFormatException e)
	{
	    new Message ("Pleas Input an integer!", "Error Message");
	}


	while (anything)
	    try
	    {
		c.setCursor (2, 1);
		c.setColor (Color.white);
		c.fillRect (0, 20, 640, 500);
		c.print ("Enter The minimum value the integer can be: ");
		input = c.readLine ();

		min = Integer.parseInt (input);
		break;
	    }

	catch (NumberFormatException e)
	{
	    new Message ("Pleas Input an integer!", "Error Message");
	}

	while (anything)
	    try
	    {
		c.setCursor (3, 1);
		c.setColor (Color.white);
		c.fillRect (0, 40, 640, 500);
		c.print ("Enter The maximum value the integer can be: ");
		input = c.readLine ();

		max = Integer.parseInt (input);
		break;
	    }

	catch (NumberFormatException e)
	{
	    new Message ("Pleas Input an integer!", "Error Message");
	}
    }


    public void displayData ()
    {
	String fileName = "numGrid.txt";

	if (((total - 1) / 5) == 0)
	{
	    end1 = 1;
	    end2 = total - 1;
	}
	if (((total - 1) / 5) == 1)
	{
	    end1 = 2;
	    end2 = (total - 1) - 5;
	}
	if (((total - 1) / 5) == 2)
	{
	    end1 = 3;
	    end2 = (total - 1) - 10;
	}
	if (((total - 1) / 5) == 3)
	{
	    end1 = 4;
	    end2 = (total - 1) - 15;
	}

	int end3 = 4;
	try
	{
	    PrintWriter output = new PrintWriter (new FileWriter (fileName));
	    for (int x = 0 ; x < end1 ; x++)
	    {
		if (x == end1 - 1)
		{
		    end3 = end2;
		}
		for (int y = 0 ; y <= end3 ; y++)
		{
		    number [x] [y] = ((int) (Math.random () * (max - min + 1)) + (min));
		    output.println ((number [x] [y]));
		}

	    }
	    output.close ();
	}

	catch (IOException e)
	{
	}


	c.setColor (Color.black);
	c.setFont (new Font ("Garamond", 1, 40));
	c.drawRect (170, 100, 300, 300);

	if (Math.sqrt (total) == (int) Math.sqrt (total))
	{
	    for (int yCoord = 170 ; yCoord <= 370 ; yCoord = yCoord + (int) (300 / Math.sqrt (total)))
	    {
		for (int xCoord = 170 ; xCoord <= 370 ; xCoord = xCoord + (int) (300 / Math.sqrt (total)))
		{
		    c.drawRect (xCoord, -70 + yCoord, xCoord + (int) (300 / Math.sqrt (total)), -70 + yCoord + (int) (300 / Math.sqrt (total)));
		    try
		    {
			String line = "";

			for (int y = 0 ; y <= (int) (300 / Math.sqrt (total)) ; y++)
			{
			    BufferedReader info;
			    info = new BufferedReader (new FileReader ((fileName)));
			    line = info.readLine ();
			    c.drawString (line, (int) (300 / Math.sqrt (total)) / 2 + xCoord, (int) (300 / Math.sqrt (total)) / 10 + yCoord);
			}
		    }
		    catch (IOException e)
		    {
		    }
		}
	    }
	}
    }




    public static void main (String[] args)
    {
	Numeric2DArray t = new Numeric2DArray ();
	t.askData ();
	t.displayData ();
    }
}



