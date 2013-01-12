#!/bin/bash
# download apps from env

RESET='\e[0m'
RED="\E[31m"
GREEN='\E[32m'

function usage()
{
    cat <<EOF
USAGE:
       $0 -options <all|appname>
Options:
          -e extract only (do not download)

where 'appname' is one of the following
=========================================
EOF
    for app in ${apps[@]}; do
        echo $app
    done
    exit 4
}

function download_package()
{
    echo "Downloading.... $APP"
    echo wget -c $@ -P $BASE/src -O ${APP}.${EXT}
    wget -c $@ -P $BASE/src -O ${APP}.${EXT}
    if [ $? -ne 0 ]; then
        echo -e "$RED FAILED TO DOWNLOAD.. $APP ;($RESET"
        return 64
    else
        echo
        echo -e "$GREEN Finished Downloading... $APP :)$RESET"
    fi
    return 0
}

function extract_package()
{
    appsrc=${APP}.${EXT}
    extractlog=${APP}.${EXT}.extraction.log
    logdir=$BASE/src/log

    if [ -d ${DIR} ]; then
        rm -r ${DIR}        # remove previouly extracted things
    fi
    mkdir -p $logdir

    case ${EXT} in
        *"gz"|*"tgz" )
            tar xzvf $appsrc &> $logdir/$extractlog &&
            echo "extraction is done and log is written to \"$logdir/$extractlog\""
            ;;
        *"zip" )
            unzip $appsrc &> $logdir/$extractlog &&
            echo "extraction is done and log is written to \"$logdir/$extractlog\""
            ;;
        *"tar" )
            tar xvf $appsrc &> $logdir/$extractlog &&
            echo "extraction is done and log is written to \"$logdir/$extractlog\""
            ;;
        * )
            echo  "dont know how to extract this one:" ${APP}.${EXT}
            ;;
    esac
}

function download_extract()
{
    # download_extract <appname>
    unset URL
    . $appsdir/${app}.env  &>/dev/null
    cd $BASE/src

    if [ ! -z $URL ]; then
        download_package $URL
    else
        echo -e "$RED unknown app \"$package\" $RESET"
        usage $0
        exit 64
    fi
    [ $? == 0 ] && extract_package
    cd -
}

# ------------------------------------------------------
export BASE=${BASE:-$WRF_BASE}
echo $BASE

# check needed environment variables are present or not
env_error=24
if [ -z $BASE ]; then
    echo BASE variable is empty
    echo did you source the SOURCEME file.?
    echo run \"source SOURCEME\"
    exit $env_error
elif [ -z $SCRIPTS_DIR ]; then
    echo SCRIPTS_DIR variable is empty
    echo did you source the SOURCEME file.?
    echo run \"source SOURCEME\"
    exit $env_error
fi

mkdir -p $BASE/src      # Setup source directory

apps=()
for envfile in `find $appsdir -maxdepth 1 -type f  -name "*.env"` ; do
    temp="${envfile##*/}" # strip out path name
    app="${temp%.[^.]*}" # strip out ".env"
    apps=(${apps[@]} ${app})
done

if [ $# -lt 1 ]
then
    echo "${#} arguments."
    usage $0
fi


unset app
#
counter=0
nofargs=$#
while [ $counter -lt $nofargs ]; do
    case $1 in
        all|ALL)
            for app in ${apps[@]};
            do
                download_extract ${app}
            done
            ;;

        *)
            app="${1%.[^.]*}" # strip out ".env" if available
            app=$(echo $app | tr '[:lower:]' '[:upper:]')
            download_extract ${app}
            ;;

    esac
    shift
    let counter=counter+1
done
exit 0
