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
    wget -c $@ -P $BASE/src
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
    pack=$1
    appsrc=${APP}.${EXT}
    extractlog=${APP}.${EXT}.extraction.log
    logdir=$BASE/src/log
    cd $BASE/src
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

###########################################################################
# CODE STARTS FORM HERE
export BASE=${BASE:-$WRF_BASE}

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
while [ $counter -le $# ]; do
    case $1 in
        -e)

            shift
            ;;

        * )
            case $1 in
                all|ALL)
                    for app in ${apps[@]};
                    do
                        unset URL
                        . $appsdir/${app}.env  &>/dev/null
                        if [ ! -z $URL ]; then
                            download_package $URL
                        fi
                        [ $? == 0 ] && extract_package $package
                    done
                    ;;

                -e )
                    shift
                    for app in ${apps[@]};
                    do
                        unset URL
                        . $appsdir/${app}.env  &>/dev/null
                        extract_package $package
                    done
                    ;;

                *)
                    unset URL
                    package="${1%.[^.]*}" # strip out ".env" if available
                    . $appsdir/${package}.env  &>/dev/null
                    if [ ! -z $URL ]; then
                        download_package $URL
                    else
                        echo -e "$RED unknown app \"$package\" $RESET"
                        usage $0
                        exit 64
                    fi
                    [ $? == 0 ] && extract_package $package
                    ;;

            esac
            shift
            ;;
    esac
    let counter=counter+1
done
exit 0
