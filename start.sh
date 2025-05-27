if [ "$HOME" = "/root" ]
then
    echo "You MUST NOT run this script with sudo or as root"
else
    export "ACTUAL_HOME=$HOME"
    sudo -E ./test.sh
fi