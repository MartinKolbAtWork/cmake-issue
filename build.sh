# Make script directory the current directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd $SCRIPT_DIR

# Download wasmer lib if necessary
if [ ! -d "wasmer" ]; then
    echo "*************************"
    echo Installing Wasmer libs
    echo "*************************"
    mkdir wasmer
    cd wasmer
    curl -s -L -O https://github.com/wasmerio/wasmer/releases/download/2.0.0-rc2/wasmer-linux-amd64.tar.gz
    tar -xzf wasmer-linux-amd64.tar.gz
    rm wasmer-linux-amd64.tar.gz
    cd $SCRIPT_DIR
fi

echo
echo "*************************"
echo build with "Unix Makefiles"
echo "*************************"
cmake --no-warn-unused-cli -DCMAKE_EXPORT_COMPILE_COMMANDS:BOOL=TRUE -DCMAKE_BUILD_TYPE:STRING=Debug -H. -B./build_make -G "Unix Makefiles"
cmake --build ./build_make --config Debug --target all -j 10 --

echo
echo "*************************"
echo build with "Ninja"
echo "*************************"
cmake --no-warn-unused-cli -DCMAKE_EXPORT_COMPILE_COMMANDS:BOOL=TRUE -DCMAKE_BUILD_TYPE:STRING=Debug -H. -B./build_ninja -G "Ninja"
cmake --build ./build_ninja --config Debug --target all -j 10 --

echo
echo "*************************"
echo Show NEEDED path with  "Unix Makefiles"
echo "*************************"
cd build_make/so_test_exe/
objdump -x so_test_exe  | grep libwasmer.so

echo
echo "*************************"
echo Execute with "Unix Makefiles"
echo "*************************"
./so_test_exe
cd $SCRIPT_DIR

echo
echo "*************************"
echo Show NEEDED path with  "Ninja"
echo "*************************"
cd build_ninja/so_test_exe/
objdump -x so_test_exe  | grep libwasmer.so

echo
echo "*************************"
echo Execute with "Ninja" - WILL FAIL - SHARED LIB NOT FOUND
echo "*************************"
./so_test_exe
cd $SCRIPT_DIR

