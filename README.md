# chessercise-target
This program is an extension to the existing chessercise

Usage: $ruby chessercise-target.rb -piece 'knight' -location 'd2' -target

Please provide 4 or 5 arguments while running the program

Please use the argument '-target' to get the opposition location that can be killed in the shortest move/s.

<p>Random numbers are generated using rand function. Once locations are computed, we are checking 
if the opposing location is not as same as the piece location and if the locations are unique.
</p>

<p> Once we have the list of the locations with us, we will be checking if any of the locations match the 
1st move of the piece type given or not. If found, we mark it that the location is killed in first move.
Else, we will be checking the valid moves of the 1st moves and checking with the positions of the list recursively. 
</p>
