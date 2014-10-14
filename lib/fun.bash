# coloring start
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

# coloring end
