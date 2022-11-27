#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/heverton/ur5_ri/src/universal_robot/ur_kinematics"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/heverton/ur5_ri/install/lib/python2.7/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/heverton/ur5_ri/install/lib/python2.7/dist-packages:/home/heverton/ur5_ri/build/lib/python2.7/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/heverton/ur5_ri/build" \
    "/usr/bin/python2" \
    "/home/heverton/ur5_ri/src/universal_robot/ur_kinematics/setup.py" \
     \
    build --build-base "/home/heverton/ur5_ri/build/universal_robot/ur_kinematics" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/heverton/ur5_ri/install" --install-scripts="/home/heverton/ur5_ri/install/bin"
