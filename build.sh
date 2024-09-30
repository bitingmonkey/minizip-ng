rm -rf build-macos
mkdir build-macos && cd build-macos
cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_OSX_ARCHITECTURES="x86_64;arm64"  -DCMAKE_OSX_DEPLOYMENT_TARGET=14.0
make
cd ..


rm -rf build-ios
mkdir build-ios && cd build-ios
cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_SYSTEM_NAME=iOS -DCMAKE_OSX_ARCHITECTURES="arm64"  -DCMAKE_OSX_DEPLOYMENT_TARGET=16.0
make
cd ..

rm -rf build-ios-sim
mkdir build-ios-sim && cd build-ios-sim
cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_SYSTEM_NAME=iOS -DCMAKE_OSX_SYSROOT=iphonesimulator -DCMAKE_OSX_ARCHITECTURES="arm64" -DCMAKE_OSX_DEPLOYMENT_TARGET=16.0
make
cd ..


rm -rf build-xcframework
mkdir build-xcframework



rm -rf build-xcframework/include
mkdir build-xcframework/include
cp mz.h build-xcframework/include
cp mz_compat.h build-xcframework/include


xcodebuild -create-xcframework \
  -library build-macos/libminizip.a -headers build-xcframework/include \
  -library build-ios/libminizip.a -headers build-xcframework/include \
  -library build-ios-sim/libminizip.a -headers build-xcframework/include \
  -output build-xcframework/minizip.xcframework