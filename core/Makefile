BUILD_TYPE=Release
VERSION=1.0.0
BUILD_SHARED_LIBS=false
CMAKE_COMMANDS=-DCMAKE_BUILD_TYPE=$(BUILD_TYPE) 
TARGET=--target ggml

NDK :=
ifeq ($(strip $(NDK_PATH)),)
    ifeq ($(shell test -d $(HOME)/Library/Developer/Xamarin/android-sdk-macosx/ndk-bundle && echo -n yes),yes)
        NDK := $(HOME)/Library/Developer/Xamarin/android-sdk-macosx/ndk-bundle
    endif
else
    NDK := $(strip $(NDK_PATH))
endif

ifeq ($(BUILD_SHARED_LIBS), true)
	CMAKE_COMMANDS+=-DBUILD_SHARED_LIBS=ON
else
	CMAKE_COMMANDS+=-DBUILD_SHARED_LIBS=OFF
endif


clean:
	rm -rf nupkgs
	rm -rf build
	rm -rf runtimes

nuget:
	mkdir -p nupkgs
	nuget pack gpt4all.net.Runtime.nuspec -Version $(VERSION) -OutputDirectory ./nupkgs

maccatalyst: maccatalyst_x64 maccatalyst_arm64

apple: macos ios ios_simulator maccatalyst tvos_simulator tvos lipo copy_output

android: android_x86 android_x64 android_arm64-v8a

linux: linux_x64 linux_arm64

linux_x64:
	rm -rf build/linux-x64
	cmake $(CMAKE_COMMANDS) -DCMAKE_TOOLCHAIN_FILE=Toolchain-linux-x64.cmake -S . -B build/linux-x64
	cmake --build build/linux-x64 --config $(BUILD_TYPE)
	mkdir -p gpt4all.net.Runtime/linux-x64
	cp build/linux-x64/gpt4all/libllmodel.so gpt4all.net.Runtime/linux-x64/libllmodel.so
	cp build/linux-x64/gpt4all/libllama*.so gpt4all.net.Runtime/linux-x64/
	cp build/linux-x64/gpt4all/libreplit*.so gpt4all.net.Runtime/linux-x64/
	cp build/linux-x64/gpt4all/libmpt*.so gpt4all.net.Runtime/linux-x64/

linux_arm64:
	rm -rf build/linux-arm64
	cmake $(CMAKE_COMMANDS) -DCMAKE_TOOLCHAIN_FILE=Toolchain-linux-arm64.cmake -S . -B build/linux-arm64
	cmake --build build/linux-arm64 --config $(BUILD_TYPE)
	mkdir -p gpt4all.net.Runtime/linux-arm64
	cp build/linux-arm64/gpt4all/libllmodel.so gpt4all.net.Runtime/linux-arm64/libllmodel.so
	cp build/linux-arm64/gpt4all/libllama*.so gpt4all.net.Runtime/linux-arm64/
	cp build/linux-arm64/gpt4all/libreplit*.so gpt4all.net.Runtime/linux-arm64/
	cp build/linux-arm64/gpt4all/libmpt*.so gpt4all.net.Runtime/linux-arm64/

macos:
	rm -rf build/macos
	cmake $(CMAKE_PARAMETERS) -DCMAKE_OSX_ARCHITECTURES="arm64;x86_64" -S . -B build/macos
	cmake --build build/macos
	mkdir -p runtimes/macos
	cp build/macos/gpt4all/libllmodel.dylib runtimes/macos/libllmodel.dylib
	cp build/macos/gpt4all/libmpt*.dylib runtimes/macos/
	cp build/macos/gpt4all/libgpt*.dylib runtimes/macos/ 
	cp build/macos/gpt4all/libllama*.dylib runtimes/macos/

ios:
	rm -rf build/ios
	cmake $(CMAKE_PARAMETERS) -DBUILD_UNIVERSAL="OFF" -DCMAKE_OSX_ARCHITECTURES="arm64" -DCMAKE_OSX_SYSROOT="iphoneos" -S . -B build/ios
	cmake --build build/ios
	mkdir -p runtimes/ios
	cp build/ios/gpt4all/libllmodel.dylib runtimes/ios/libllmodel.dylib
	cp build/ios/gpt4all/libmpt*.dylib runtimes/ios/
	cp build/ios/gpt4all/libgpt*.dylib runtimes/ios/ 
	cp build/ios/gpt4all/libllama*.dylib runtimes/ios/

ios_simulator:
	rm -rf build/ios_simulator
	cmake $(CMAKE_PARAMETERS) -DCMAKE_OSX_SYSROOT="iphonesimulator" -DCMAKE_OSX_ARCHITECTURES="arm64;x86_64" -S . -B build/ios_simulator
	cmake --build build/ios_simulator
	mkdir -p runtimes/ios_simulator
	cp build/ios_simulator/gpt4all/libllmodel.dylib runtimes/ios_simulator/libllmodel.dylib
	cp build/ios_simulator/gpt4all/libmpt*.dylib runtimes/ios_simulator/
	cp build/ios_simulator/gpt4all/libgpt*.dylib runtimes/ios_simulator/ 
	cp build/ios_simulator/gpt4all/libllama*.dylib runtimes/ios_simulator/

maccatalyst_x64:
	rm -rf build/maccatalyst_x64
	cmake $(CMAKE_PARAMETERS) -DCMAKE_SYSTEM_PROCESSOR=x86_64 -DCMAKE_HOST_SYSTEM_PROCESSOR=x86_64 -DCMAKE_SYSTEM_NAME=Darwin -DBUILD_UNIVERSAL="OFF" -DBUILD_METAL="OFF" -DCMAKE_OSX_ARCHITECTURES="x86_64" -DCMAKE_CXX_FLAGS="-target x86_64-apple-ios13.1-macabi" -DCMAKE_C_FLAGS="-target x86_64-apple-ios13.1-macabi" -S . -B build/maccatalyst_x64
	cmake --build build/maccatalyst_x64
	mkdir -p runtimes/maccatalyst_x64
	cp build/maccatalyst_x64/gpt4all/libllmodel.dylib runtimes/maccatalyst_x64/libllmodel.dylib
	cp build/maccatalyst_x64/gpt4all/libmpt*.dylib runtimes/maccatalyst_x64/
	cp build/maccatalyst_x64/gpt4all/libgpt*.dylib runtimes/maccatalyst_x64/ 
	cp build/maccatalyst_x64/gpt4all/libllama*.dylib runtimes/maccatalyst_x64/

maccatalyst_arm64:
	rm -rf build/maccatalyst_arm64
	cmake $(CMAKE_PARAMETERS) -DCMAKE_SYSTEM_PROCESSOR=arm -DCMAKE_HOST_SYSTEM_PROCESSOR=arm64 -DCMAKE_SYSTEM_NAME=Darwin -DBUILD_UNIVERSAL="OFF" -DBUILD_METAL="OFF" -DCMAKE_OSX_ARCHITECTURES="arm64" -DCMAKE_CXX_FLAGS="-target arm64-apple-ios13.1-macabi" -DCMAKE_C_FLAGS="-target arm64-apple-ios13.1-macabi" -S . -B build/maccatalyst_arm64
	cmake --build build/maccatalyst_arm64
	mkdir -p runtimes/maccatalyst_arm64
	cp build/maccatalyst_arm64/gpt4all/libllmodel.dylib runtimes/maccatalyst_arm64/libllmodel.dylib
	cp build/maccatalyst_arm64/gpt4all/libmpt*.dylib runtimes/maccatalyst_arm64/
	cp build/maccatalyst_arm64/gpt4all/libgpt*.dylib runtimes/maccatalyst_arm64/ 
	cp build/maccatalyst_arm64/gpt4all/libllama*.dylib runtimes/maccatalyst_arm64/

tvos:
	rm -rf build/tvos
	cmake $(CMAKE_PARAMETERS) -DBUILD_UNIVERSAL="OFF" -DCMAKE_OSX_SYSROOT="appletvos" -DCMAKE_OSX_ARCHITECTURES="arm64" -S . -B build/tvos
	cmake --build build/tvos
	mkdir -p runtimes/tvos
	cp build/tvos/gpt4all/libllmodel.dylib runtimes/tvos/libllmodel.dylib
	cp build/tvos/gpt4all/libmpt*.dylib runtimes/tvos/
	cp build/tvos/gpt4all/libgpt*.dylib runtimes/tvos/ 
	cp build/tvos/gpt4all/libllama*.dylib runtimes/tvos/

tvos_simulator:
	rm -rf build/tvos_simulator
	cmake $(CMAKE_PARAMETERS) -DCMAKE_OSX_SYSROOT="appletvsimulator" -DCMAKE_OSX_ARCHITECTURES="arm64;x86_64" -S . -B build/tvos_simulator
	cmake --build build/tvos_simulator
	mkdir -p runtimes/tvos_simulator
	cp build/tvos_simulator/gpt4all/libllmodel.dylib runtimes/tvos_simulator/libllmodel.dylib
	cp build/tvos_simulator/gpt4all/libmpt*.dylib runtimes/tvos_simulator/
	cp build/tvos_simulator/gpt4all/libgpt*.dylib runtimes/tvos_simulator/ 
	cp build/tvos_simulator/gpt4all/libllama*.dylib runtimes/tvos_simulator/

lipo:
	chmod +x lipo_setup.zsh
	rm -rf runtimes/maccatalyst
	mkdir -p runtimes/maccatalyst
	./lipo_setup.zsh runtimes/maccatalyst_x64 runtimes/maccatalyst_arm64 runtimes/maccatalyst

copy_output:
	chmod +x rpath_setup.zsh
	rm -rf gpt4all.net.Runtime/tvos-simulator
	mkdir -p gpt4all.net.Runtime/tvos-simulator
	cp runtimes/tvos_simulator/libllmodel.dylib gpt4all.net.Runtime/tvos-simulator/libllmodel.dylib
	cp runtimes/tvos_simulator/libmpt*.dylib gpt4all.net.Runtime/tvos-simulator/
	cp runtimes/tvos_simulator/libgpt*.dylib gpt4all.net.Runtime/tvos-simulator/
	cp runtimes/tvos_simulator/libllama*.dylib gpt4all.net.Runtime/tvos-simulator/
	./rpath_setup.zsh gpt4all.net.Runtime/tvos-simulator "@executable_path/../Frameworks"
	rm -rf gpt4all.net.Runtime/tvos-device
	mkdir -p gpt4all.net.Runtime/tvos-device
	cp runtimes/tvos/libllmodel.dylib gpt4all.net.Runtime/tvos-device/libllmodel.dylib
	cp runtimes/tvos/libmpt*.dylib gpt4all.net.Runtime/tvos-device/
	cp runtimes/tvos/libgpt*.dylib gpt4all.net.Runtime/tvos-device/
	cp runtimes/tvos/libllama*.dylib gpt4all.net.Runtime/tvos-device/
	./rpath_setup.zsh gpt4all.net.Runtime/tvos-device "@executable_path/../Frameworks"
	rm -rf gpt4all.net.Runtime/ios-simulator
	mkdir -p gpt4all.net.Runtime/ios-simulator
	cp runtimes/ios_simulator/libllmodel.dylib gpt4all.net.Runtime/ios-simulator/libllmodel.dylib
	cp runtimes/ios_simulator/libmpt*.dylib gpt4all.net.Runtime/ios-simulator/
	cp runtimes/ios_simulator/libgpt*.dylib gpt4all.net.Runtime/ios-simulator/
	cp runtimes/ios_simulator/libllama*.dylib gpt4all.net.Runtime/ios-simulator/
	./rpath_setup.zsh gpt4all.net.Runtime/ios-simulator "@executable_path/../Frameworks"
	rm -rf gpt4all.net.Runtime/ios-device
	mkdir -p gpt4all.net.Runtime/ios-device
	cp runtimes/ios/libllmodel.dylib gpt4all.net.Runtime/ios-device/libllmodel.dylib
	cp runtimes/ios/libmpt*.dylib gpt4all.net.Runtime/ios-device/
	cp runtimes/ios/libgpt*.dylib gpt4all.net.Runtime/ios-device/
	cp runtimes/ios/libllama*.dylib gpt4all.net.Runtime/ios-device/
	./rpath_setup.zsh gpt4all.net.Runtime/ios-device "@executable_path/../Frameworks"
	rm -rf gpt4all.net.Runtime/macos
	mkdir -p gpt4all.net.Runtime/macos
	cp runtimes/macos/libllmodel.dylib gpt4all.net.Runtime/macos/libllmodel.dylib
	cp runtimes/macos/libmpt*.dylib gpt4all.net.Runtime/macos/
	cp runtimes/macos/libgpt*.dylib gpt4all.net.Runtime/macos/
	cp runtimes/macos/libllama*.dylib gpt4all.net.Runtime/macos/
	./rpath_setup.zsh gpt4all.net.Runtime/macos "@executable_path/../MonoBundle"
	rm -rf gpt4all.net.Runtime/maccatalyst
	mkdir -p gpt4all.net.Runtime/maccatalyst
	cp runtimes/maccatalyst/libllmodel.dylib gpt4all.net.Runtime/maccatalyst/libllmodel.dylib
	cp runtimes/maccatalyst/libmpt*.dylib gpt4all.net.Runtime/maccatalyst/
	cp runtimes/maccatalyst/libgpt*.dylib gpt4all.net.Runtime/maccatalyst/
	cp runtimes/maccatalyst/libllama*.dylib gpt4all.net.Runtime/maccatalyst/
	./rpath_setup.zsh gpt4all.net.Runtime/maccatalyst "@executable_path/../MonoBundle"

android_arm64-v8a:
	rm -rf build/android-arm64-v8a
	cmake -DCMAKE_ANDROID_ARCH_ABI=arm64-v8a $(CMAKE_COMMANDS) -DCMAKE_SYSTEM_NAME=Android -DCMAKE_ANDROID_API=21 -DCMAKE_ANDROID_NDK=$(NDK) -S . -B build/android-arm64-v8a
	cmake --build build/android-arm64-v8a
	mkdir -p gpt4all.net.Runtime/android-arm64-v8a
	cp build/android-arm64-v8a/gpt4all/libllmodel.so gpt4all.net.Runtime/android-arm64-v8a/libllmodel.so
	cp build/android-arm64-v8a/gpt4all/libllama*.so gpt4all.net.Runtime/android-arm64-v8a/
	cp build/android-arm64-v8a/gpt4all/libreplit*.so gpt4all.net.Runtime/android-arm64-v8a/
	cp build/android-arm64-v8a/gpt4all/libmpt*.so gpt4all.net.Runtime/android-arm64-v8a/

android_x86:
	rm -rf build/android-x86
	cmake -DCMAKE_ANDROID_ARCH_ABI=x86 $(CMAKE_COMMANDS) -DCMAKE_SYSTEM_NAME=Android -DCMAKE_ANDROID_API=21 -DCMAKE_ANDROID_NDK=$(NDK) -S . -B build/android-x86
	cmake --build build/android-x86
	mkdir -p gpt4all.net.Runtime/android-x86
	cp build/android-x86/gpt4all/libllmodel.so gpt4all.net.Runtime/android-x86/libllmodel.so
	cp build/android-x86/gpt4all/libllama*.so gpt4all.net.Runtime/android-x86/
	cp build/android-x86/gpt4all/libreplit*.so gpt4all.net.Runtime/android-x86/
	cp build/android-x86/gpt4all/libmpt*.so gpt4all.net.Runtime/android-x86/

android_x64:
	rm -rf build/android-x86_64
	cmake -DCMAKE_ANDROID_ARCH_ABI=x86_64 $(CMAKE_COMMANDS) -DCMAKE_SYSTEM_NAME=Android -DCMAKE_ANDROID_API=21 -DCMAKE_ANDROID_NDK=$(NDK) -S . -B build/android-x86_64
	cmake --build build/android-x86_64
	mkdir -p gpt4all.net.Runtime/android-x86_64
	cp build/android-x86_64/gpt4all/libllmodel.so gpt4all.net.Runtime/android-x86_64/libllmodel.so
	cp build/android-x86_64/gpt4all/libllama*.so gpt4all.net.Runtime/android-x86_64/
	cp build/android-x86_64/gpt4all/libreplit*.so gpt4all.net.Runtime/android-x86_64/
	cp build/android-x86_64/gpt4all/libmpt*.so gpt4all.net.Runtime/android-x86_64/

xcframework_libllama:
	mkdir -p output/lib
	xcrun xcodebuild -create-xcframework -library gpt4all.net.Runtime/ios-device/libllama.dylib  -library gpt4all.net.Runtime/ios-simulator/libllama.dylib -library gpt4all.net.Runtime/tvos-device/libllama.dylib -library gpt4all.net.Runtime/tvos-simulator/libllama.dylib -library gpt4all.net.Runtime/macos/libllama.dylib -output output/lib/libllama.xcframework

xcframework_libllmodel:
	mkdir -p output/lib
	xcrun xcodebuild -create-xcframework -library gpt4all.net.Runtime/ios-device/libllmodel.dylib -library gpt4all.net.Runtime/ios-simulator/libllmodel.dylib -library gpt4all.net.Runtime/tvos-device/libllmodel.dylib -library gpt4all.net.Runtime/tvos-simulator/libllmodel.dylib -library gpt4all.net.Runtime/macos/libllmodel.dylib -output output/lib/libllmodel.xcframework