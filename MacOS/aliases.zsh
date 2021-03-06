# List directory contents
alias l='CLICOLOR_FORCE=1 ls -lh'
alias la='CLICOLOR_FORCE=1 ls -lah'
alias lu='CLICOLOR_FORCE=1 ls -lruh'
alias llp='CLICOLOR_FORCE=1 ls -lh | less -R --clear-screen --quit-if-one-screen'
alias lap='CLICOLOR_FORCE=1 ls -lAh | less -R --clear-screen --quit-if-one-screen'
alias lup='CLICOLOR_FORCE=1 ls -lruh | less -R --clear-screen --quit-if-one-screen'
alias jtags='find . -type f -iregex ".*\.js$" -not -path "./node_modules/*" -exec jsctags {} -f \; | sed "/^$/d" | sort > tags'
alias uploaddir='pushd /Users/clinton/pcode/repos/EasyDeploy'
alias upbase='node upload.js base=/Users/clinton/pcode/repos/Frontend target=test'
alias upbasemeta='node upload.js base=/Users/clinton/pcode/repos/Frontend meta=/Users/clinton/pcode/repos/ContentMeta target=test'

