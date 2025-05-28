force_root=0

while [ True ]; do
if [ "$1" = "--force-root" ]; then
    force_root=1
    shift 1
else
    break
fi
done

if [ "$HOME" = "/root" ] && [ $force_root = 0 ]
then
    echo "You MUST NOT run this script with sudo or as root"
    echo "you can bypass this restriction with --force-root. Use at your own risk"
else
    export "ACTUAL_HOME=$HOME"
    ./cobol_p4_install.sh
fi