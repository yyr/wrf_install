#!/bin/bash
# download apps from env

function download_package()
{
    echo "Downloading.... $APP"
    echo
    wget -c $@ -P $BASE/src
    if [ $? -ne 0 ]; then
        echo "FAILED TO DOWNLOAD.. $APP ;("
        return 64
    else
        echo
        echo "Finished Downloading... $APP :)"
    fi
    return 0
}

function shebang ()
{
    file=$1
    if [ ! -f $file ]; then
        echo '#!/bin/bash' > $file
        chmod +x $file
        echo '#' >> $file       # just an extra comment line
    fi
}

function clean_line ()
{
    perl -i -ne "print unless m!$1!" $2
}

function update_util_files()
{
    echo arg: $1
    pack=$1
   # update generated scripts
    for x in $util_scr; do
        echo clean_line $1 $x
    done

    echo rm ${APP}.${EXT} \# $pack >> $CLEAN_DOWN
    echo rm -rf ${DIR} \# $pack >> $CLEAN_SRC
    case ${EXT} in
        *".gz"|*"tgz" )
            echo tar xzvf ${APP}.${EXT} \# $pack >> $EXTRACT_SRC ;;
        *"zip" )
            echo unzip ${APP}.${EXT} \# $pack >> $EXTRACT_SRC ;;
        * )
            echo echo "dont know how to extract this one:" ${APP}.${EXT} >> $EXTRACT_SRC ;;
    esac
}

###########################################################################
# CODE STARTS FORM HERE
if [ $# -lt 1 ]
then
    echo "${#} arguments."
    echo "USAGE: $0 <all|app>"
    exit 4
fi

export BASE=$WRF_BASE
SCRIPTS_DIR=${SCRIPTS_DIR:-$(pwd)}

# check needed environment variables are present or not
env_error=24
if [ -z $BASE ]; then
    echo BASE variable is empty
    echo please set that to know where to download files
    exit $env_error
elif [ -z $SCRIPTS_DIR ]; then
    echo SCRIPTS_DIR variable is empty
    echo please set that to know where the env files located
    exit $env_error
fi

mkdir -p $BASE/src      # Setup source directory

# prepare utilitly scripts
CLEAN_DOWN=$BASE/src/clean_downloads.sh
CLEAN_SRC=$BASE/src/clean_source.sh
EXTRACT_SRC=$BASE/src/extract_source.sh

util_scr="$CLEAN_SRC $CLEAN_DOWN $EXTRACT_SRC"
for f in $util_scr ; do
    shebang $f
done

#
counter=0
while [ $counter -le $# ]; do
    case $1 in
        all|ALL)
            for envfile in `find $SCRIPTS_DIR/ -maxdepth 1 -type f  -name "*.env"`
            do
                unset URL
                envfile="${envfile##*/}" # strip out path name
                package="${envfile%.[^.]*}" # strip out ".env"
                . $SCRIPTS_DIR/${envfile} &>/dev/null
                if [ ! -z $URL ]; then
                    download_package $URL
                fi
                [ $? == 0 ] && update_util_files $package
            done
            exit 0
            ;;
        *)
            unset URL
            package="${1%.[^.]*}" # strip out ".env" if available
            . $SCRIPTS_DIR/${package}.env  &>/dev/null
            if [ ! -z $URL ]; then
                download_package $URL
            fi
            [ $? == 0 ] && update_util_files $package
            ;;
    esac

    shift
    let counter=counter+1
done

exit 0
