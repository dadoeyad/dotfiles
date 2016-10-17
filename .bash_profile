for file in ~/.{path,bash_prompt,exports,aliases,functions,extra,work}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;

# bash_completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
	. $(brew --prefix)/etc/bash_completion
fi

# virtualenvwrapper
export WORKON_HOME=~/Envs
mkdir -p $WORKON_HOME
source /usr/local/bin/virtualenvwrapper.sh

# Fab auto complete
_fab()
{
    local cur
    COMPREPLY=()
    # Variable to hold the current word
    cur="${COMP_WORDS[COMP_CWORD]}"

    # Build a list of the available tasks using the command 'fab -l'
    local tags=$(fab -l 2>/dev/null | grep "^    " | awk '{print $1;}')

    # Generate possible matches and store them in the
    # array variable COMPREPLY
    COMPREPLY=($(compgen -W "${tags}" $cur))
}

# Assign the auto-completion function _fab for our command fab.
complete -F _fab fab
