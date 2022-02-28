The Hangman game program has been modularized into meaningful subroutines.
I have implemented this program using regular expressions taught in the class.

-> 100 words have been hardcoded in the program. To add more words, you can pass the file name as a parameter
E.g:- perl Hangman.pl words.txt

For the file:- 
-> The word should consist of lowercase letters
-> Each new word should be in new line

Instructions for the game:-
-> The game will welcome you with an initial screen.
-> The word to guess is represented by a row of dashes, giving the number of letters in the word.
-> If the player suggests a letter which occurs in the word, the program writes it in all its correct positions
-> If the suggested letter does not occur in the word, the program draws one element of a hanged man stick
figure and this requires number of tries by 1.
-> The game is over when:-
   -> The player completes the word, or guesses the whole word correctly – Player Wins!
   -> Number of tries exceeds a limit (completes the hangman diagram) – Player loses!

-> The suggested letter is invalid if it is already in guessed letters or is not in the range of a to z.
-> The player can guess the word or the entire word at one go, but if the word has been guessed before
   the program will show them the invalid input
-> When the game ends, the program will ask whether to continue or exit the game.
   -> 1 to continue
   -> -1 to exit

