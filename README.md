# chessercise-target
This program is an extension to the existing chessercise

Usage: $ruby chessercise-target.rb -piece 'knight' -location 'd2' -target

Please provide 2 or 3 arguments while running the program

Please use the argument '-target' to get the opposition location that can be killed in the shortest move/s.

<p>Random numbers are generated using rand function. Once locations are computed, we are checking 
if the opposing location is not as same as the piece location and if the locations are unique.
</p>

<p>get_most_distant_tile method returns the distant opposing piece </p>


<p> Once we have the most distant location of the opposition of the locations with us, we will be searching for the 
most distant tile recursively </p>

<p>Graph search such as Breadth First Search implementation would be ideal for more performance</p>