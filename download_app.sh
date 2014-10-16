#!/usr/bin/env bash
# download apps from env

THIS_FILE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_FILE_DIR/lib/fun.bash

# Check for Environmental varables.
sourceme_sourced

# functions
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
    blue_echo "Downloading.... $APP"
    wget -c  $@ -P $BASE/src -O ${APP}.${EXT}
    if [ $? -ne 0 ]; then
        red_echo "FAILED TO DOWNLOAD.. :( $APP"
        return 64
    else
        echo
        green_echo "Finished Downloading... $APP :)"
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
                blue_echo "extraction is done and log is written to \"$logdir/$extractlog\""
            ;;
        *"zip" )
            unzip $appsrc &> $logdir/$extractlog &&
                blue_echo "extraction is done and log is written to \"$logdir/$extractlog\""
            ;;
        *"tar" )
            tar xvf $appsrc &> $logdir/$extractlog &&
                blue_echo "extraction is done and log is written to \"$logdir/$extractlog\""
            ;;
        * )
            blue_echo  "dont know how to extract this one:" ${APP}.${EXT}
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
        red_echo "Unknown app \"$package\" "
        usage $0
        exit 64
    fi
    [ $? == 0 ] && extract_package
    cd -
}

# ------------------------------------------------------
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
