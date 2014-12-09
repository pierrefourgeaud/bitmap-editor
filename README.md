bitmap-editor
=============
*By Pierre Fourgeaud*

Ruby program that simulates a basic interactive bitmap editor. Bitmaps are represented as an M x N matrix of pixels with each element representing a colour.

#### Example:

	$ ./bitmap-editor
	> I 5 6
	> L 2 3 A
	> S
	OOOOO
	OOOOO
	OAOOO
	OOOOO
	OOOOO
	OOOOO
	> F 3 3 J
	> V 2 3 4 W
	> H 3 4 2 Z
	> S
	JJJJJ
	JJZZJ
	JWJJJ
	JWJJJ
	JJJJJ
	JJJJJ

## Commands

There are 9 supported commands:

|Commands|Description|
|--------|-----------|
| `I M N` | Create a new M x N image with all pixels coloured white (O).|
| `C` | Clears the table, setting all pixels to white (O).|
| `L X Y C` | Colours the pixel (X,Y) with colour C.|
| `V X Y1 Y2 C` | Draw a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive).|
| `H X1 X2 Y C` | Draw a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive).|
| `F X Y C` | Fill the region R with the colour C. R is defined as: Pixel (X,Y) belongs to R. Any other pixel which is the same colour as (X,Y) and shares a common side with any pixel in R also belongs to this region.|
| `S` | Show the contents of the current image.|
| `X` | Terminate the session.|
| `U` | Undo the previous command. Some command are not undoable. |
| `R` | Redo the command previously undone. |

## Added Feature

As part of the assignment, I added one more functionnality named **Undo/Redo**.

It works like we are used to in many software. You do a command and you can remove the effect of this command by undoing it.

Remember that some command are not undoable like *Show*, *Quit* or even *Undo*.

You can call the Undo/Redo command by using **U** and **R** respectively.

#### Example:

	> I 5 6
	> L 2 3 A
	> S
	OOOOO
	OOOOO
	OAOOO
	OOOOO
	OOOOO
	OOOOO
	> U
	> S
	OOOOO
	OOOOO
	OOOOO
	OOOOO
	OOOOO
	OOOOO
	> R
	> S
	OOOOO
	OOOOO
	OAOOO
	OOOOO
	OOOOO
	OOOOO

Here you see that we Undo the command Fill and redoit afterwards. *(Note: You see that the Show command is ignored when we call the Undo/Redo command.)*


## Run the tests

First install `rspec`:

    $ gem install rspec

And then:

    $ Rake