% Ms. Balland
% Braulio Carrion Coveria
% 6/9/2017
% This is a where is waldo game. The objective is to find waldo


import GUI
% Declaration section
var intfont, intfont0, intfont1, playButton, instruction, unlimited, timed, Exit, stageNumber, x, y, button, eighteen, finalAnswer, settings, back : int
var Limit : int := -1
const del := 10
var timeElapsed := 0
var mainWin := Window.Open ("position : 640;400, graphics : 640;400")
var instructionsWin : int
var username, password : string
var waldo : int := Pic.FileNew ("WALDO.jpg")
eighteen := Font.New ("Comic Sans MS:14")
intfont := Font.New ("Comic Sans MS:24")
intfont0 := Font.New ("Comic Sans MS:20")
intfont1 := Font.New ("Comic Sans MS:64")

%  forward procedure main  menu
forward proc mainMenu
% pause program
proc pauseProgram
    var reply : string (1)
    % sets screem so cursor doesnt appear
    View.Set ("nocursor")
    % waits until a key is pressed
    getch (reply)
end pauseProgram

% title program
proc title
    % sets height to 50
    var height : int := 50
    cls
    % draws the striped background
    drawfillbox (0, 0, 640, 400, 40)
    drawfillbox (0, height, 640, height * 2, white)
    drawfillbox (0, height * 3, 640, height * 4, white)
    drawfillbox (0, height * 5, 640, height * 6, white)
    drawfillbox (0, height * 7, 640, height * 8, white)
    % animation for loading screen / moving rectangle
    for x : 0 .. 800
	Font.Draw ("Loading...", 0, 60, intfont, 40)
	drawfillbox (0 + x, 10, 20 + x, 40, white)
	delay (2)
	View.Update
    end for
    cls
    % clears screen (we dont want the loading thing to stay) and background is draw again
    drawfillbox (0, 0, 640, 400, 40)
    drawfillbox (0, height, 640, height * 2, white)
    drawfillbox (0, height * 3, 640, height * 4, white)
    drawfillbox (0, height * 5, 640, height * 6, white)
    drawfillbox (0, height * 7, 640, height * 8, white)
    % locates and displays the title Wheres waldo
    locate (2, 40)
    Font.Draw ("Where's Waldo?", 200, 370, intfont, 40)
    View.Update
end title
% game over screen
proc endScreen
    % declares variables for pictures
    var level1answer : int := Pic.FileNew ("Level1answer.jpg")
    var level2answer : int := Pic.FileNew ("Level2answer.jpg")
    var level3answer : int := Pic.FileNew ("Level3answer.jpg")
    %  runs title
    title
    % runs if statement to  see which level was just played
    % if the level was one-three and they found waldo (if finalAnswer) it displays a picture saying they were incorrect and showing were waldo was, then pause program is ran to continue to main menu
    if stageNumber = 1 then
	if finalAnswer = 1 then
	    Pic.Draw (level1answer, 0, 0, picCopy)
	    drawfillbox (0, 0, 300, 100, white)
	    Font.Draw ("Correct!", 25, 60, intfont, 40)
	    Font.Draw ("Here was Waldo!", 25, 30, intfont, 40)
	    % if they didnt find waldo (if finalAnswer) it displays a picture saying they were incorrect and showing were waldo was, then pause program is ran to continue to main menu
	elsif finalAnswer = 2 then
	    Pic.Draw (level1answer, 0, 0, picCopy)
	    drawfillbox (0, 0, 300, 100, white)
	    Font.Draw ("Here was Waldo!", 25, 30, intfont, 40)
	    Font.Draw ("Incorrect!", 25, 60, intfont, 40)
	end if
	Font.Draw ("Press any key to continue!", 25, 05, eighteen, 40)
	View.Update
	pauseProgram
	mainMenu
	View.Update
    elsif stageNumber = 2 then
	if finalAnswer = 1 then
	    Pic.Draw (level2answer, 0, 0, picCopy)
	    drawfillbox (0, 0, 300, 100, white)
	    Font.Draw ("Here was Waldo!", 25, 30, intfont, 40)
	    Font.Draw ("Correct!", 25, 60, intfont, 40)
	elsif finalAnswer = 2 then
	    Pic.Draw (level2answer, 0, 0, picCopy)
	    drawfillbox (0, 0, 300, 100, white)
	    Font.Draw ("Here was Waldo!", 25, 30, intfont, 40)
	    Font.Draw ("Incorrect!", 25, 60, intfont, 40)
	end if
	Font.Draw ("Press any key to continue!", 25, 05, eighteen, 40)
	View.Update
	pauseProgram
	mainMenu
	View.Update
    elsif stageNumber = 3 then
	if finalAnswer = 1 then
	    Pic.Draw (level3answer, 0, 0, picCopy)
	    drawfillbox (0, 0, 300, 100, white)
	    Font.Draw ("Here was Waldo!", 25, 30, intfont, 40)
	    Font.Draw ("Correct!", 25, 60, intfont, 40)
	elsif finalAnswer = 2 then
	    Pic.Draw (level3answer, 0, 0, picCopy)
	    drawfillbox (0, 0, 300, 100, white)
	    Font.Draw ("Here was Waldo!", 25, 30, intfont, 40)
	    Font.Draw ("Incorrect!", 25, 60, intfont, 40)
	end if
	Font.Draw ("Press any key to continue!", 25, 05, eighteen, 40)
	View.Update
	pauseProgram
	mainMenu
	View.Update
    end if
end endScreen
% stage program is were the puzzle is displayed
proc stage
    % variables for the picture of the puzzle
    var level1 : int := Pic.FileNew ("Level1.jpg")
    var level2 : int := Pic.FileNew ("Level2.jpg")
    var level3 : int := Pic.FileNew ("Level3.jpg")
    % if stage 1-3 was chosen it displays the level depending on the picture
    if stageNumber = 1 then
	Pic.Draw (level1, 0, 0, picCopy)
	View.Update
	loop
	    % Time. DelaySinceLast calculates how long it took to run this porgram (this procedure) if it took the amount the person set as their time limit if exits
	    Time.DelaySinceLast (del)
	    timeElapsed += 10
	    % sees where the mouse was clicked and where it is, if its in the given locations then it goes to the endscreen and sets the level to 1-3
	    mousewhere (x, y, button)
	    if button = 1 then
		if (x >= 115 and x <= 145) and (y >= 260 and y <= 300) then
		    % sets final answer to 1 (found waldo)
		    finalAnswer := 1
		    endScreen
		    View.Update
		    exit
		end if
	    end if
	    % exits if ESC if pressed
	    % array char of boolean is an array for every key
	    var chars : array char of boolean
	    % input key down checks which key is being pressed
	    Input.KeyDown (chars)
	    % if the key that is being pressed is ESC key then it returns to the main menu
	    if chars (KEY_ESC) then
		mainMenu
		View.Update
		exit
	    end if
	    % exit when reaches time limit
	    if timeElapsed = Limit * 1000 then
		% sets final answer to 2 (didnt find waldo)
		finalAnswer := 2
		% goes to end screen
		endScreen
		View.Update
		exit
	    end if
	end loop
	% same thing that was just above in the if statement goes for this, its just a differnt puzzle
    elsif stageNumber = 2 then
	Pic.Draw (level2, 0, 0, picCopy)
	View.Update
	loop
	    Time.DelaySinceLast (del)
	    timeElapsed += 10
	    mousewhere (x, y, button)
	    if button = 1 then
		if (x >= 510 and x <= 540) and (y >= 265 and y <= 300) then
		    finalAnswer := 1
		    endScreen
		    View.Update
		    exit
		end if
	    end if
	    var chars : array char of boolean
	    Input.KeyDown (chars)
	    if chars (KEY_ESC) then
		mainMenu
		View.Update
		exit
	    end if
	    if timeElapsed = Limit * 1000 then
		finalAnswer := 2
		endScreen
		View.Update
		exit
	    end if
	end loop
    elsif stageNumber = 3 then
	Pic.Draw (level3, 0, 0, picCopy)
	View.Update
	loop
	    Time.DelaySinceLast (del)
	    timeElapsed += 10
	    mousewhere (x, y, button)
	    if button = 1 then
		if (x >= 290 and x <= 325) and (y >= 160 and y <= 305) then
		    finalAnswer := 1
		    endScreen
		    View.Update
		    exit
		end if
	    end if
	    var chars : array char of boolean
	    Input.KeyDown (chars)
	    if chars (KEY_ESC) then
		mainMenu
		View.Update
		exit
	    end if
	    if timeElapsed = Limit * 1000 then
		finalAnswer := 2
		endScreen
		View.Update
		exit
	    end if
	end loop
    end if
end stage

% procedure for stage 1, it sets the stage number to 1 so when it checks which level was chosen 1 is the option
proc stage01
    title
    stageNumber := 1
    stage
end stage01
% procedure for stage 2, it sets the stage number to 2 so when it checks which level was chosen 2 is the option
proc stage02
    title
    stageNumber := 2
    stage
end stage02
% procedure for stage 3, it sets the stage number to 3 so when it checks which level was chosen 3 is the option
proc stage03
    title
    stageNumber := 3
    stage
end stage03
% procedure for a random stage, it sets the stage number to random number available so when it checks which level was chosen the random number is the option
proc rdm1
    title
    stageNumber := Rand.Int (1, 3)
    stage
end rdm1
% stage selction runs a number of buttons which all lead to a different stage
proc stageSelection
    % declaration for pictures
    var park : int := Pic.FileNew ("Park.jpg")
    var market : int := Pic.FileNew ("Market.jpg")
    var train : int := Pic.FileNew ("Train.jpg")
    var mark : int := Pic.FileNew ("Mark.jpg")
    % runs title
    title
    % displays the title for this section
    Font.Draw ("Stage Selection", 220, 327, intfont0, white)
    % draws a box with a label on it. If the mouse is over the location it changes to a preview of the level if it is clicked it then goes to that level
    % this is for each button, only differnece is the level it goes to, picture, and location and colour and text
    loop
	drawfillbox (210, 200, 400, 310, black)
	drawfillbox (220, 200, 420, 300, 60)
	drawfillbox (230, 210, 410, 290, 36)
	Font.Draw ("Market", 260, 250, intfont, black)
	mousewhere (x, y, button)
	if (x >= 220 and x <= 420) and (y >= 200 and y <= 300) then
	    drawfillbox (220, 200, 420, 300, 44)
	    Pic.Draw (market, 230, 210, picCopy)
	end if
	mousewhere (x, y, button)
	if button = 1 and (x >= 220 and x <= 420) and (y >= 200 and y <= 300) then
	    stage01
	    exit
	end if
	drawfillbox (10, 110, 210, 210, black)
	drawfillbox (20, 100, 220, 200, 21)
	drawfillbox (30, 110, 210, 190, 27)
	Font.Draw ("Train", 75, 150, intfont, black)
	Font.Draw ("Station", 65, 115, intfont, black)
	mousewhere (x, y, button)
	if (x >= 20 and x <= 220) and (y >= 100 and y <= 200) then
	    drawfillbox (20, 100, 220, 200, 44)
	    Pic.Draw (train, 30, 110, picCopy)
	end if
	mousewhere (x, y, button)
	if button = 1 and (x >= 20 and x <= 220) and (y >= 100 and y <= 200) then
	    stage02
	    exit
	end if
	drawfillbox (630, 110, 430, 210, black)
	drawfillbox (620, 100, 420, 200, 112)
	drawfillbox (610, 110, 430, 190, 34)
	Font.Draw ("Amusement", 430, 150, intfont, black)
	Font.Draw ("Park", 490, 115, intfont, black)
	mousewhere (x, y, button)
	if (x >= 420 and x <= 620) and (y >= 100 and y <= 200) then
	    drawfillbox (620, 100, 420, 200, 14)
	    Pic.Draw (park, 430, 110, picCopy)
	end if
	mousewhere (x, y, button)
	if button = 1 and (x >= 420 and x <= 620) and (y >= 100 and y <= 200) then
	    stage03
	    exit
	end if
	drawfillbox (220, 0, 420, 100, 44)
	drawfillbox (230, 10, 410, 90, 67)
	Font.Draw ("Random", 260, 50, intfont, black)
	mousewhere (x, y, button)
	if (x >= 220 and x <= 420) and (y >= 0 and y <= 100) then
	    drawfillbox (220, 0, 420, 100, 14)
	    Pic.Draw (mark, 230, 10, picCopy)
	end if
	mousewhere (x, y, button)
	if button = 1 and (x >= 220 and x <= 420) and (y >= 0 and y <= 100) then
	    rdm1
	    exit
	end if
	View.Update
	delay (75)
    end loop
end stageSelection
% In this program the user sets a time limit for themselves
proc getTime
    % hides the two buttons
    title
    % adds 1 to limit
    Limit += 1
    loop
	View.Set ("offscreenonly")
	% draws the background with a plus and minus sign
	drawfillbox (100, 240, 540, 340, red)
	drawfillbox (125, 280, 200, 300, black)
	drawfillbox (515, 280, 440, 300, black)
	drawfillbox (488, 253, 467, 328, black)
	% displays the number of second the player wants as a limit
	Font.Draw ((intstr (Limit)), 250, 265, intfont1, black)
	% finds out where the mouse is located and if the button on the mouse is clicked. If the button is clicked and the mouse  is located either on the plus or minus then it either adds or subtracts to limit
	mousewhere (x, y, button)
	%%
	if button = 1 and (x >= 440 and x <= 515) and (y >= 253 and y <= 328) then
	    Limit += 1
	end if
	mousewhere (x, y, button)
	if Limit > 0 and button = 1 and (x >= 125 and x <= 200) and (y >= 280 and y <= 300) then
	    Limit -= 1
	end if
	% displyas text
	Font.Draw ("Seconds", 290, 245, eighteen, black)
	% draws an oval with text in it as a button
	drawfilloval (320, 100, 130, 60, 112)
	drawfilloval (320, 100, 120, 50, 34)
	Font.Draw ("Set...", 210, 75, intfont1, black)
	% if the mouse if located on the button the colours change, and if the mouse button is clicked on the button then it continues to the stage selection
	mousewhere (x, y, button)
	if (x >= 190 and x <= 450) and (y >= 40 and y <= 160) then
	    drawfilloval (320, 100, 130, 60, 104)
	    drawfilloval (320, 100, 120, 50, 32)
	    Font.Draw ("Set...", 210, 75, intfont1, 0)
	end if
	mousewhere (x, y, button)
	if button = 1 and (x >= 240 and x <= 440) and (y >= 50 and y <= 150) then
	    stageSelection
	    exit
	end if
	View.Update
	delay (75)
    end loop
end getTime
% this program either goes to unlimited time or goes to timed
proc timeLimit
    % diposes buttons and gets rid of them
    GUI.Dispose (playButton)
    GUI.Dispose (instruction)
    GUI.Dispose (Exit)
    % runs title
    title
    % draws the title of this window display
    Font.Draw ("Time Selection", 210, 320, intfont, white)
    var unlimitedPic : int := Pic.FileNew ("unlimited.jpg")
    var timePic : int := Pic.FileNew ("time.jpg")
    loop
	drawfillbox (10, 110, 210, 210, black)
	drawfillbox (20, 100, 220, 200, 56)
	drawfillbox (30, 110, 210, 190, 54)
	Font.Draw ("Unlimted", 60, 150, intfont, black)
	Font.Draw ("Time", 75, 115, intfont, black)
	mousewhere (x, y, button)
	if (x >= 20 and x <= 220) and (y >= 100 and y <= 200) then
	    drawfillbox (20, 100, 220, 200, 44)
	    Pic.Draw (unlimitedPic, 30, 110, picCopy)
	end if
	mousewhere (x, y, button)
	if button = 1 and (x >= 20 and x <= 220) and (y >= 100 and y <= 200) then
	    stageSelection
	    exit
	end if
	drawfillbox (630, 110, 430, 210, black)
	drawfillbox (620, 100, 420, 200, 156)
	drawfillbox (610, 110, 430, 190, 91)
	Font.Draw ("Time", 490, 150, intfont, black)
	Font.Draw ("Limit", 490, 115, intfont, black)
	mousewhere (x, y, button)
	if (x >= 420 and x <= 620) and (y >= 100 and y <= 200) then
	    drawfillbox (620, 100, 420, 200, 14)
	    Pic.Draw (timePic, 430, 110, picCopy)
	end if
	mousewhere (x, y, button)
	if button = 1 and (x >= 420 and x <= 620) and (y >= 100 and y <= 200) then
	    getTime
	    exit
	end if
	delay (75)
	View.Update
	end loop
end timeLimit
% exit screen for when the program is over
proc exitScreen
    % disposes the  buttons
    GUI.Dispose (playButton)
    GUI.Dispose (instruction)
    GUI.Dispose (Exit)
    % runs title
    title
    % displyas a text saying goodbye to ____ (username entered) and displays my name
    Font.Draw ("Goodbye..." + username, 200, 265, intfont, 40)
    Font.Draw ("By: Braulio Carrion", 200, 215, intfont, white)
    View.Update
    Music.PlayFileStop
    delay (1500)
    % closes window
    Window.Close (mainWin)
    Window.Close (instructionsWin)
    GUI.Quit
end exitScreen
% exit screen from the login (its different because you cant dispose the buttons cause there are none at the moment but exact same thing as other exit screen)
proc exitScreen1
    title
    Font.Draw ("Goodbye... ", 275, 265, intfont, 40)
    Font.Draw ("By: Braulio Carrion", 200, 215, intfont, white)
    View.Update
    Music.PlayFileStop
    delay (1500)
    Window.Close (mainWin)
    GUI.Quit
end exitScreen1
% this program hides the instuctions window and opens the mainMenu on the main window
proc closeWin
    Window.Hide (instructionsWin)
    Window.Show (mainWin)
    mainMenu
end closeWin
% this procedure displays  the instructions of the game
proc instuctions
    % hides the main window and opens a new one for the  instructions
    Window.Hide (mainWin)
    instructionsWin := Window.Open ("position : 05;05, graphics : 640;400")
    % runs title
    title
    cls
    % clears screen cause we only needed the loading screen
    % draws a pic of waldo
    Pic.Draw (waldo, 50, 0, picCopy)
    % displays the instructions
    Font.Draw ("Instructions", 50, 320, intfont1, 40)
    Font.Draw ("To play Click anywhere on the screen", 3, 265, eighteen, 7)
    Font.Draw ("where you think Waldo might be.", 3, 215, eighteen, 7)
    Font.Draw ("If you find him you WIN,", 3, 165, eighteen, 7)
    Font.Draw ("if you don't you LOSE!", 3, 115, eighteen, 7)
    Font.Draw ("You can press ESC to Exit the game!", 3, 65, eighteen, 7)
    Font.Draw ("GOOD LUCK!!!", 3, 15, intfont0, 7)
    % creates a gui button to go  back to the main menu, but first it goes to closeWin to  close the windows
    back := GUI.CreateButton (200, 15, 0, "Go Back!", closeWin)
    % sets colour of button
    GUI.SetColor (back, 40)
    View.Update
end instuctions
% here the user can select which song they want playing in the background
proc songSelection
    % runs title
    title
    % displays the title of the program
	Font.Draw ("Song Selection", 220, 327, intfont0, white)
    loop
	drawfillbox (220, 260, 440, 320, black)
	drawfillbox (200, 250, 430, 310, 54)
	drawfillbox (210, 260, 420, 300, 90)
	Font.Draw ("JEOPARDY!", 223, 270, intfont, black)
	% in this small program boxes are drawn to create buttons, if the mouse if in the location of the button it changes colour. If they click the button then the song plays in a loop. If  they click set then the song is set for the whole program until it ends or they turn it off
	mousewhere (x, y, button)
	if (x >= 200 and x <= 430) and (y >= 250 and y <= 310) then
	    drawfillbox (200, 250, 430, 310, 124)
	    drawfillbox (210, 260, 420, 300, 63)
	    Font.Draw ("JEOPARDY!", 223, 270, intfont, black)
	end if
	mousewhere (x, y, button)
	if button = 1 and (x >= 200 and x <= 430) and (y >= 250 and y <= 310) then
	    Music.PlayFileLoop ("Jeopardy.mp3")
	end if
	drawfillbox (220, 60, 440, 120, black)
	drawfillbox (200, 50, 430, 110, 32)
	drawfillbox (210, 60, 420, 100, 42)
	Font.Draw ("Family Feud!", 223, 70, intfont, black)
	mousewhere (x, y, button)
	if (x >= 200 and x <= 430) and (y >= 50 and y <= 110) then
	    drawfillbox (200, 50, 430, 110, 58)
	    drawfillbox (210, 60, 420, 100, 14)
	    Font.Draw ("Family Feud!", 223, 70, intfont, black)
	end if
	mousewhere (x, y, button)
	if button = 1 and (x >= 200 and x <= 430) and (y >= 50 and y <= 110) then
	    Music.PlayFileLoop ("Family.mp3")
	end if
	drawfillbox (170, 160, 480, 220, black)
	drawfillbox (150, 150, 470, 210, 112)
	drawfillbox (160, 160, 460, 200, 78)
	Font.Draw ("The Price Is Right!", 167, 170, intfont, black)
	mousewhere (x, y, button)
	if (x >= 150 and x <= 470) and (y >= 150 and y <= 210) then
	    drawfillbox (150, 150, 470, 210, 45)
	    drawfillbox (160, 160, 460, 200, 116)
	    Font.Draw ("The Price Is Right!", 167, 170, intfont, black)
	end if
	mousewhere (x, y, button)
	if button = 1 and (x >= 150 and x <= 470) and (y >= 150 and y <= 210) then
	    Music.PlayFileLoop ("Price.mp3")
	end if
	drawfillbox (290, 15, 340, 40, 112)
	Font.Draw ("Set!", 295, 20, eighteen, black)
	if button = 1 and (x >= 300 and x <= 330) and (y >= 15 and y <= 40) then
	    mainMenu
	    exit
	end if
	delay (50)
	View.Update
    end loop
end songSelection
% settings program is where the user decides wether they want the music on or off
proc setting
% disposes buttons
    GUI.Dispose (playButton)
    GUI.Dispose (instruction)
    GUI.Dispose (Exit)
    % runs title
    title
    % displays the title of the procedure
    Font.Draw ("Sound Selection", 220, 327, intfont0, white)
    loop
    % this program creates an on and off button. if the mouse is in the location of the buttons then the  buttons change colour, if they click the mouse button in that area then the  music either turns off if clicked on off or goes to song selction if on is clicked
	drawfillbox (250, 60, 420, 160, black)
	drawfillbox (240, 50, 410, 149, 112)
	drawfillbox (250, 60, 400, 139, 62)
	Font.Draw ("ON!", 247, 70, intfont1, black)
	drawfillbox (240, 210, 430, 310, black)
	drawfillbox (230, 200, 420, 299, 112)
	drawfillbox (240, 210, 410, 289, 62)
	Font.Draw ("OFF", 240, 220, intfont1, black)
	mousewhere (x, y, button)
	if (x >= 240 and x <= 410) and (y >= 50 and y <= 150) then
	    drawfillbox (240, 50, 410, 149, 192)
	    drawfillbox (250, 60, 400, 139, 10)
	    Font.Draw ("ON!", 247, 70, intfont1, black)
	elsif (x >= 230 and x <= 420) and (y >= 200 and y <= 300) then
	    drawfillbox (230, 200, 420, 299, 192)
	    drawfillbox (240, 210, 410, 289, 10)
	    Font.Draw ("OFF", 240, 220, intfont1, black)
	end if
	mousewhere (x, y, button)
	if button = 1 then
	    if (x >= 230 and x <= 420) and (y >= 200 and y <= 300) then
		Music.PlayFile ("SoundButton.mp3")
		Music.PlayFileStop
		mainMenu
		exit
	    elsif (x >= 240 and x <= 410) and (y >= 50 and y <= 150) then
		Music.PlayFile ("SoundButton.mp3")
		songSelection
		exit
	    end if
	end if
	delay (50)
	View.Update
    end loop
end setting
% main menu is where all the buttons are that lead to different programs
body proc mainMenu
    Limit := -1
    title
    Font.Draw ("Main Menu", 250, 320, intfont, white)
    % creates 4 buttons, one goes to play, one goes to instructions, one goes to settings, and one exits
    playButton := GUI.CreateButton (310, 215, 0, "Play!", timeLimit)
    instruction := GUI.CreateButton (290, 165, 0, "Instructions!", instuctions)
    settings := GUI.CreateButton (285, 115, 0, "Music Settings!", setting)
    Exit := GUI.CreateButton (310, 65, 0, "Exit!", exitScreen)
    % each button has a different colour
    GUI.SetColor (playButton, white)
    GUI.SetColor (instruction, 40)
    GUI.SetColor (settings, white)
    GUI.SetColor (Exit, 40)
    View.Update
end mainMenu
% login program gets the users username and password and only cotinues if the password is correct
proc login
    loop
	title
	% this displays a text of the title
	Font.Draw ("Login", 280, 320, intfont, white)
	Font.Draw ("Username: ", 100, 260, intfont, 40)
	locatexy (300, 260)
	% gets uername
	get username
	Font.Draw ("Password: ", 100, 160, intfont, 40)
	locatexy (300, 160)
	%gets password
	get password
	% if password is equalto 0 then it goes to  the exit screen
	if password = "0" then
	    exitScreen1
	    exit
	end if
	% it exits the loops/continues if password is equal to 123
	exit when password = "123"
	locatexy (100, 160)
	% displays a messege if password is incorrect
	Font.Draw ("Enter the right password or Enter 0 to Exit!", 15, 60, intfont0, 40)
	delay (2000)
    end loop
    mainMenu
end login


proc intro
    % this runs an animation of where moving up
    for x : -100 .. 300
	Font.Draw ("Where", 196, x - 5, intfont1, white)
	Font.Draw ("Where", 198, x - 5, intfont1, white)
	Font.Draw ("Where", 197, x, intfont1, 40)
	delay (15)
    end for
    % this runs an animation of is moving up
    for x : -100 .. 200
	Font.Draw ("Is", 306, x - 5, intfont1, white)
	Font.Draw ("Is", 308, x - 5, intfont1, white)
	Font.Draw ("Is", 307, x, intfont1, 40)
	delay (15)
    end for
    % this runs an animation of waldo moving up
    for x : -100 .. 100
	Font.Draw ("Waldo!", 196, x - 5, intfont1, white)
	Font.Draw ("Waldo!", 198, x - 5, intfont1, white)
	Font.Draw ("Waldo!", 197, x, intfont1, 40)
	delay (15)
    end for
    % displys a picture of waldo with a grow
    Pic.DrawSpecial (waldo, 0, 0, picCopy, picGrowCenterToEdge, 2000)
    delay (500)
    title
    % draws a start button. if the mouse if in the location of that button then it changes colour. if the mouse button is clicked over that location then it continues
    loop
	drawfillbox (200, 60, 460, 160, black)
	drawfillbox (190, 50, 450, 149, 112)
	drawfillbox (200, 60, 440, 139, 62)
	Font.Draw ("Start!", 197, 70, intfont1, black)
	mousewhere (x, y, button)
	if (x >= 190 and x <= 450) and (y >= 50 and y <= 150) then
	    drawfillbox (190, 50, 450, 150, 104)
	    drawfillbox (200, 60, 440, 139, 11)
	    Font.Draw ("Start!", 197, 70, intfont1, 0)
	end if
	mousewhere (x, y, button)
	if button = 1 and (x >= 190 and x <= 450) and (y >= 50 and y <= 150) then
	    Music.PlayFile ("SoundButton.mp3")
	    login
	    exit
	end if
	delay (50)
    end loop
    loop
	exit when GUI.ProcessEvent
    end loop
end intro

intro
