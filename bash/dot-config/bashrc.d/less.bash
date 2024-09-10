# Configure less
export LESS='--raw-control-chars --clear-screen --tabs=4 --use-color -Ps%lt-%lb/%L%t$ -Pm%T %F lines %lt-%lb/%L%t$ -PM%T %F (%i/%m) lines %lt-%lb/%L bytes %bt-%bb/%B%t$ --long-prompt'
export LESSHISTFILE='/dev/null'
export LESSOPEN='|lesspipe.sh %s'
export LESSQUIET=1

# Use less as the default pager
export PAGER='less'
