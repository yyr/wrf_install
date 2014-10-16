# Error number
ecode_fatal=2
ecode_warning=64

# coloring
RESET='\e[0m'
RED="\e[31m"
BLUE="\e[34m"
GREEN='\e[32m'

function red_echo()
{
    printf "${RED}$@${RESET}\n"
}

function green_echo()
{
    printf "${GREEN}$@${RESET}\n"
}

function blue_echo()
{
    printf "${BLUE}$@${RESET}\n"
}

#

function sourceme_sourced()
{
    if [ -z $BASE ] || [ -z $SCRIPTS_DIR ]; then
        red_echo "Environmental variables is not set. \
please run \"source SOURCEME\" in 'wrf_install' directory."
        exit $ecode_fatal
    fi
}


# runners
function command_runner()
{
    cmd=${@:1:$(($#-1))}
    logfile=${@: -1}

    blue_echo "Running: $cmd"
    blue_echo "To moniter log file run: tail -f $(pwd)/$logfile"

    if [[ "$teeing" = "true" ]]; then
        eval $cmd 2>&1 | tee $logfile
    else
        eval $cmd > $logfile 2>&1
    fi
    if [ $? != 0 ]; then
        red_echo "Failed"
        # red_echo Some thig is wrong.. Trying to continue..
        exit $?
    else
        green_echo "Done"
    fi
}
