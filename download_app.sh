#!/bin/bash
# download apps from env
function download_package()
{
    RESET='\e[0m'
    RED="\E[31m"
    GREEN='\E[32m'
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
    case ${EXT} in
        *"gz"|*"tgz" )
            cd $BASE/src
            tar xzvf $appsrc &> $extractlog &&
            echo "extracted and log written in $extractlog"
            ;;
        *"zip" )
            cd $BASE/src
            unzip $appsrc &> $extractlog &&
            echo extracted and log written in $extractlog
            ;;
        * )
            echo  "dont know how to extract this one:" ${APP}.${EXT}
            ;;
    esac
}

###########################################################################
# CODE STARTS FORM HERE
if [ $# -lt 1 ]
then
    echo "${#} arguments."
    echo "USAGE: $0 <all|appname>"
    exit 4
fi

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

for  app in $apps; do
    echo $app
done

unset app
#
counter=0
while [ $counter -le $# ]; do
    case $1 in
        all|ALL)
            for app in $apps
            do
                unset URL
                . $appsdir/${app}.env  &>/dev/null
                if [ ! -z $URL ]; then
                    download_package $URL
                fi
                [ $? == 0 ] && extract_package $package
            done
            exit 0
            ;;
        *)
            unset URL
            package="${1%.[^.]*}" # strip out ".env" if available
            . $appsdir/${package}.env  &>/dev/null
            if [ ! -z $URL ]; then
                download_package $URL
            else
                echo unknown app \"$package\"
                exit 64
            fi
            [ $? == 0 ] && extract_package $package
            ;;
    esac

    shift
    let counter=counter+1
done
exit 0
