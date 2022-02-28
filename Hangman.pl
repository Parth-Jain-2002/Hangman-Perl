#!/usr/local/bin/perl

# Subroutine to get random word assigned
sub random_word{
    @words=("computer","radio","calculator","teacher","bureau","police","geometry","president","subject",
    "country","enviroment","classroom","animals","province","month","politics","puzzle","instrument","kitchen","language",
    "vampire","ghost","solution","service","software","security","phonenumber","expert","website","agreement",
    "support","compatibility","advanced","search","triathlon","immediately","encyclopedia","endurance",
    "distance","nature","history","organization","international","championship","government","popularity",
    "thousand","feature","wetsuit","fitness","legendary","variation","equal","approximately","segment",
    "priority","physics","branche","science","mathematics","lightning","dispersion","accelerator","detector",
    "terminology","design","operation","foundation","application","prediction","reference","measurement",
    "concept","perspective","overview","position","airplane","symmetry","dimension","toxic","algebra","illustration",
    "classic","verification","citation","unusual","resource","analysis","license","comedy","screenplay",
    "production","release","emphasis","director","trademark","vehicle","aircraft","experiment","metaverse");
    
    # Using the wordFile subroutine to add more words to the hardcoded list
    wordFile();
    $size = scalar @words;
    
    # Using rand function to generate a random number and using it to generate a random word
    $random = int(rand($size-1));
    $curr_word = $words[$random];
    return $curr_word
}

# Subroutine to add more words to the hardcoded list. For this to happen, user has to give the text file as parameter
sub wordFile(){
    
    #In the text file provided, each new word should start on a new line
    if($#ARGV == 0){
        $file_name = $ARGV[0];
   
        open($fh, "<" , $file_name);
        # Adding each line which contains a new word to the words list
        while($line = <$fh>){
            push(@words,$line);
        }
        close($fh);
    }
}

# Subroutine to display the graphic version of the hangman according to the number of guesses remaining
sub gui{
    my ($guess) = @_;
    if($guess == 6){
        print "  ______   \n";
        print " |      |  \n";
        print " |        \n";
        print " |         \n";
        print " |         \n";
        print " |         \n";
        print " |         \n";
        print "_|____     \n";
    }
    elsif($guess == 5){
        print "  ______   \n";
        print " |      |  \n";
        print " |      O  \n";
        print " |         \n";
        print " |         \n";
        print " |         \n";
        print " |         \n";
        print "_|____     \n";
    }
    elsif($guess == 4){
        print "  ______   \n";
        print " |      |  \n";
        print " |      O  \n";
        print " |      |  \n";
        print " |      |  \n";
        print " |         \n";
        print " |         \n";
        print "_|____     \n";
    }
    elsif($guess == 3){
        print "  ______   \n";
        print " |      |  \n";
        print " |      O  \n";
        print " |    \\ |  \n";
        print " |      |  \n";
        print " |         \n";
        print " |         \n";
        print "_|____     \n";
    }
    elsif($guess == 2){
        print "  ______   \n";
        print " |      |  \n";
        print " |      O  \n";
        print " |    \\ | / \n";
        print " |      |  \n";
        print " |         \n";
        print " |         \n";
        print "_|____     \n";
    }
    elsif($guess == 1){
        print "  ______   \n";
        print " |      |  \n";
        print " |      O  \n";
        print " |    \\ | / \n";
        print " |      |  \n";
        print " |     /   \n";
        print " |         \n";
        print "_|____     \n";
    }
    elsif($guess == 0){
        print "  ______   \n";
        print " |      |  \n";
        print " |      O  \n";
        print " |    \\ | / \n";
        print " |      |  \n";
        print " |     / \\ \n";
        print " |         \n";
        print "_|____     \n";
    }
}

# Subroutine to print the result of the hangman game
sub printResult{
    my ($word,$guess)=@_;
    # If number of guesses is less than 0, it means the player has lost the game
    if($guess<0){
        print "You Lose!! Better Try Next Time. The word is $word\n\n";
    }
    else{
        print "You Win!! The word is $word\n\n";
    }
}

# Subroutine to check the validity of a single letter
sub check{
    my $letter = @_[0];
    @validletters = (a..z);
    $flag = 0;

    # Checking if the letter belongs to the range a to z
    for($i=0;$i<=$#validletters;$i++){
        if($validletters[$i] eq $letter){
            $flag=1;
            last;
        }
    }
    if($flag==0){
        return 0;
    }

    #Checking if the letter is already present in the guessed letters list
    for($i=0;$i<=$#guessed_letters;$i++){
        if($guessed_letters[$i] eq $letter){
            return 0;
        }
    }
    return 1;
}

# Subroutine to take the letter from the user
sub userWord{
    # Displaying the present state of the word, with dashes replaced by guessed letters
    print "\nHere is your word: $clone\n";
    print "Guess so far: @guessed_letters\n";
    # Taking user input, either a letter or the entire word
    print "Guess a letter or the entire word: ";
    $letter = <STDIN>;
    chomp $letter;
    
    # Taking input from the user, till they enters a valid sequence
    # The letter length should be 1 or equal to the entire word length
    # The letter should be from a to z and should not belong to already guessed letters
    while(length($letter)!=length($curr_word) && (length($letter)!=1 || check($letter)==0)){
        print "Invalid Input. Guess a letter or the entire word: ";
        $letter = <STDIN>;
        chomp $letter; 
    }

    return $letter
}

# Subroutine to use the single length letter
sub useLetter{
    
    # Pushing the letter to the guessed letters list
    push(@guessed_letters,$letter);

    # Removing this letter from the buffer list
    $index=0;
    while($buffer[$index] ne $letter){
        $index++;
    }
    splice(@buffer,$index,1);

    # Using regex to check if this letter appears in the word
    # Depending on the this, displaying result to the user
    if($curr_word =~ m/$letter/){
        gui($guesses);
        print "Good Guess. You still have $guesses body parts left.\n";
    }
    else{
        $guesses--;
        if($guesses<0){
            last;
        }
        gui($guesses);
        print "Bad Guess. You have $guesses body parts left.\n"
    }
    print "\n";
}

# Subroutine for the game loop. This is the subroutine where the game logic takes place
sub gameloop{

# Buffer contains all the unguessed letters. Since the words contain only lowercase letters, it consists from a to z
@buffer=(a..z);
# As the user guesses a letter, we will push it to the guessed letter
@guessed_letters=();
# Using the random word subroutine, we will generate a random word
$currword = random_word();
# The number of guesses are 6 since there are 6 body parts in the hangman figure
$guesses = 6;

# The game continues till there are guesses remaining and user hasn't guessed the right word
while($guesses>=0){
    
    # Using regex, we replace the unguessed letters with dashes
    $clone = $currword;
    for($i = 0; $i<=$#buffer; $i++)
    {  
        while($clone =~ m/$buffer[$i]/){
        $clone =~ s/\Q$buffer[$i]/_/;
        }
    }
    
    # If there are no dashes, it means the word has been guessed and hence we break the while loop
    if($clone eq $currword){
        last;
    }
    
    # We use the userWord subroutine to take the input from the user
    # There are two options for the user: Either enter a single letter or whole word at one time
    $letter = userWord();
    
    if(length($letter)==1){
       # If the length of letter is 1
       useLetter();
    }
    else{
       # Else the length of letter will be equal to word length
        if($curr_word eq $letter){
            gui($guesses);
            print "Good Guess. You have spelled the right word\n";
            last;
        }
        else{
            $guesses--;
            if($guesses<0){
                last;
        }
        gui($guesses);
        print "Bad Guess. You have $guesses body parts left.\n"
        }
        print "\n";
        }
    }
    
    # Using the printResult subroutine to show the result
    printResult($curr_word,$guesses);
}

# Subroutine for the hangman game
sub hangman{
    # This is the main game loop subroutine
    gameloop();

    # Taking input from the user whether they want to continue the game or exist it
    print "Do you want to play again? [1 to continue | -1 for exit]\n";
    $_[0] = <STDIN>;
    while($_[0]!=1 && $_[0]!=-1){
        print "Invalid Input. Enter Again\n";
        $_[0] = <STDIN>;
    }
}

#Subroutine for the welcome screen and instructions display
sub welcome{
    print "Welcome to the Hangman Game\n";
    print "A word will be selected randomly and will be represented by dashes.\n";
    print "You may choose to either guess a letter occuring in it or the entire word.\n";
    print "Each incorrect attempt will decrease your life and you have 6 guesses.\n";
    print "HAVE FUN PLAYING IT AND ENJOY IT.\n";
}

# Variable for the user input of game continuing
$gameon = 1;
# Welcome Screen
welcome();
# Till the gameon variable has value 1, the program will be in an infinite loop
while($gameon==1){
    hangman($gameon);
}