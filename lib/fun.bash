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
    echo -e ${RED}$@${RESET}
}

function green_echo()
{
    echo -e ${GREEN}$@${RESET}
}

function blue_echo()
{
    echo -e ${BLUE}$@${RESET}
}

#

function sourceme_sourced()
{
    if [ -z $BASE ] || [ -z $SCRIPTS_DIR ]; then
        red_echo "Environmental variables is not set. \
please run \"source SOURCEME\" in root directory"
        exit $ecode_fatal
    fi
}
