# List directory contents
alias l='eza -lh'
alias la='eza -lah'
alias lu='eza -lruh'
alias llp='eza -lh | less -R --clear-screen --quit-if-one-screen'
alias lap='eza -lAh | less -R --clear-screen --quit-if-one-screen'
alias lup='eza -lruh | less -R --clear-screen --quit-if-one-screen'
alias jtags='find . -type f -iregex ".*\.js$" -not -path "./node_modules/*" -exec jsctags {} -f \; | sed "/^$/d" | sort > tags'
alias uuidgen='uuidgen | tr "[:upper:]" "[:lower:]"'
alias cmadd='chezmoi add'
alias cme='chezmoi edit'
alias cmea='chezmoi edit --apply'
alias cma='chezmoi apply'
alias gupuae="USER_REGION=uae STAGE=prod ENCRYPTION_PASSPHRASE='2ChADVW9451qb/r2Ru9sKP2j3HhKhG/GsD3/nK8TYm8=' tsx user-ops/getUserProfile2.ts --production "
alias gupus="USER_REGION=us STAGE=prod ENCRYPTION_PASSPHRASE='2ChADVW9451qb/r2Ru9sKP2j3HhKhG/GsD3/nK8TYm8=' tsx user-ops/getUserProfile2.ts --production "
alias gupuaedev="USER_REGION=uae STAGE=dev ENCRYPTION_PASSPHRASE='2ChADVW9451qb/r2Ru9sKP2j3HhKhG/GsD3/nK8TYm8=' tsx user-ops/getUserProfile2.ts "
alias gupusdev="USER_REGION=us STAGE=dev ENCRYPTION_PASSPHRASE='2ChADVW9451qb/r2Ru9sKP2j3HhKhG/GsD3/nK8TYm8=' tsx user-ops/getUserProfile2.ts "
