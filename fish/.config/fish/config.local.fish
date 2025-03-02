# bun :: js runtime / package manager
set -Ux BUN_INSTALL "$HOME/.bun"
fish_add_path $BUN_INSTALL/bin

# rust :: cargo
fish_add_path $HOME/.cargo/bin
#set PATH $PATH ~/.cargo/bin;


# conda :: environment manager (should be last or could cause issues)
#if test -f /Users/armeetjatyani/anaconda3/bin/conda
#    eval /Users/armeetjatyani/anaconda3/bin/conda "shell.fish" "hook" $argv | source
#end
