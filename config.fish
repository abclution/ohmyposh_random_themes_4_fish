
# This is a very rudimentary addon for the bottom of your config.fish to have random Oh My Posh themes every time you launch your shell. 
# This also assumes a lot about your setup.
# This is my first time writing a fish shell script I am sure there is better ways to do all of this, but it works well enough for the moment, I will polish it up later.


####### Assume we can write to /tmp and try and generate a temp file without clobbering anything. #######

# Surely there has to be a way to do this without writing to disk but I wanted to finish
# Good boy points for avoiding smashing any files, however slim in the tmp folder.

set filename (string join '_' $USER (date +%Y%M%d%S%s) (random) (date +%s))
while test -e "/tmp/$filename"
    echo "Filename collision! Avoiding..."
    set filename (string join '_' $USER (date +%Y%M%d%S%s) (random) (date +%s))
end

####### Assume your themes are in the standard issue place as shown in the installation and config tutorial #######
####### Grab all theme full names and put them into a list on disk. 

for theme in ~/.cache/oh-my-posh/themes/*.json
    echo $theme >> "/tmp/$filename"
end


####### Use fish built in to make a random choice and set it to a variable to use in the Oh My Posh setting below. #######

set randomTheme (random choice (cat "/tmp/$filename"))

####### Clean up.. or not. Maybe we leave the temp files to slowly rotate through and use as a timer and keep 
####### a style for some time before switching out.

# rm -f "/tmp/$filename"

####### Standard Oh My Posh config lines below on how to use it.

# oh-my-posh init fish --config 'https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/jandedobbeleer.omp.json' | source
# oh-my-posh init fish --config '.cache/oh-my-posh/themes/hotstick.minimal.omp.json' | source
oh-my-posh init fish --config "$randomTheme" | source













