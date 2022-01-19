# Path to your oh-my-fish.
# Theme
set fish_theme robbyrussell

set -x EDITOR vim

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-fish/plugins/*)
# Custom plugins may be added to ~/.oh-my-fish/custom/plugins/
# Example format: set fish_plugins autojump bundler

# Path to your custom folder (default path is $FISH/custom)
#set fish_custom $HOME/dotfiles/oh-my-fish

alias be 'bundle exec'
alias bi 'bundle install'
alias bu 'bundle update'
alias rgs 'rvm --force gemset empty'

alias nix-fshell "nix-shell --run fish"

if status is-interactive
    # Commands to run in interactive sessions can go here
end
