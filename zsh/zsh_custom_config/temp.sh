alias mqp='cd ~/personal_dev/advanced_gen_modeling_mqp_2022_2023'
alias zon='cd ~/workplace'

export PATH=$PATH:/Users/sbuasai/.toolbox/bin
source /Users/sbuasai/.brazil_completion/zsh_completion

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/sbuasai/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/sbuasai/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/sbuasai/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/sbuasai/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

complete -d cd
