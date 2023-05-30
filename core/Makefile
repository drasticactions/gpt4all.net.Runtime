BUILD_TYPE=Release
VERSION=1.0.0
BUILD_SHARED_LIBS=true
CMAKE_COMMANDS=-DCMAKE_BUILD_TYPE=$(BUILD_TYPE) 
TARGET=--target ggml

NDK :=
ifeq ($(strip $(NDK_PATH)),)
    ifeq ($(shell test -d $(HOME)/Library/Developer/Xamarin/android-sdk-macosx/ndk-bundle && echo -n yes),yes)
        NDK := $(HOME)/Library/Developer/Xamarin/android-sdk-macosx/ndk-bundle
    else
        $(error NDK_PATH not defined and NDK not found at default location on Mac.)
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

apple: macos ios ios_simulator maccatalyst tvos_simulator tvos lipo

android: android_x86 android_x64 android_arm64-v8a

linux: linux_x64 linux_arm64

linux_x64:
	rm -rf build/linux-x64
	cmake $(CMAKE_COMMANDS) -DCMAKE_TOOLCHAIN_FILE=Toolchain-linux-x64-musl.cmake -S . -B build/linux-x64
	cmake --build build/linux-x64 --config $(BUILD_TYPE)
	mkdir -p gpt4all.net.Runtime/linux-x64
	cp build/linux-x64/gpt4all/libllmodel.so gpt4all.net.Runtime/linux-x64/libllmodel.so
	cp build/linux-x64/gpt4all/llama.cpp/libllama.so gpt4all.net.Runtime/linux-x64/libllama.so

linux_arm64:
	rm -rf build/linux-arm64
	cmake $(CMAKE_COMMANDS) -DCMAKE_TOOLCHAIN_FILE=Toolchain-linux-arm64-musl.cmake -S . -B build/linux-arm64
	cmake --build build/linux-arm64 --config $(BUILD_TYPE)
	mkdir -p gpt4all.net.Runtime/linux-arm64
	cp build/linux-arm64/gpt4all/libllmodel.so gpt4all.net.Runtime/linux-arm64/libllmodel.so
	cp build/linux-arm64/gpt4all/llama.cpp/libllama.so gpt4all.net.Runtime/linux-arm64/libllama.so

macos:
	rm -rf build/macos
	cmake $(CMAKE_PARAMETERS) -DCMAKE_OSX_ARCHITECTURES="arm64;x86_64" -S . -B build/macos
	cmake --build build/macos
	mkdir -p runtimes/macos
	cp build/macos/gpt4all/libllmodel.dylib runtimes/macos/libllmodel.dylib
	cp build/macos/gpt4all/llama.cpp/libllama.dylib runtimes/macos/libllama.dylib

ios:
	rm -rf build/ios
	cmake $(CMAKE_PARAMETERS) -DBUILD_UNIVERSAL="OFF" -DCMAKE_OSX_ARCHITECTURES="arm64" -DCMAKE_OSX_SYSROOT="iphoneos" -S . -B build/ios
	cmake --build build/ios
	mkdir -p runtimes/ios
	cp build/ios/gpt4all/libllmodel.dylib runtimes/ios/libllmodel.dylib
	cp build/ios/gpt4all/llama.cpp/libllama.dylib runtimes/ios/libllama.dylib

ios_simulator:
	rm -rf build/ios_simulator
	cmake $(CMAKE_PARAMETERS) -DCMAKE_OSX_SYSROOT="iphonesimulator" -DCMAKE_OSX_ARCHITECTURES="arm64;x86_64" -S . -B build/ios_simulator
	cmake --build build/ios_simulator
	mkdir -p runtimes/ios_simulator
	cp build/ios_simulator/gpt4all/libllmodel.dylib runtimes/ios_simulator/libllmodel.dylib
	cp build/ios_simulator/gpt4all/llama.cpp/libllama.dylib runtimes/ios_simulator/libllama.dylib

maccatalyst:
	rm -rf build/maccatalyst
	cmake $(CMAKE_PARAMETERS) -DCMAKE_OSX_ARCHITECTURES="arm64;x86_64" -DCMAKE_XCODE_ATTRIBUTE_TARGETED_DEVICE_FAMILY="1,2" -S . -B build/maccatalyst
	cmake --build build/maccatalyst
	mkdir -p runtimes/maccatalyst
	cp build/maccatalyst/gpt4all/libllmodel.dylib runtimes/maccatalyst/libllmodel.dylib
	cp build/maccatalyst/gpt4all/llama.cpp/libllama.dylib runtimes/maccatalyst/libllama.dylib

tvos:
	rm -rf build/tvos
	cmake $(CMAKE_PARAMETERS) -DBUILD_UNIVERSAL="OFF" -DCMAKE_OSX_SYSROOT="appletvos" -DCMAKE_OSX_ARCHITECTURES="arm64" -S . -B build/tvos
	cmake --build build/tvos
	mkdir -p runtimes/tvos
	cp build/tvos/gpt4all/libllmodel.dylib runtimes/tvos/libllmodel.dylib
	cp build/tvos/gpt4all/llama.cpp/libllama.dylib runtimes/tvos/libllama.dylib

tvos_simulator:
	rm -rf build/tvos_simulator
	cmake $(CMAKE_PARAMETERS) -DCMAKE_OSX_SYSROOT="appletvsimulator" -DCMAKE_OSX_ARCHITECTURES="arm64;x86_64" -S . -B build/tvos_simulator
	cmake --build build/tvos_simulator
	mkdir -p runtimes/tvos_simulator
	cp build/tvos_simulator/gpt4all/libllmodel.dylib runtimes/tvos_simulator/libllmodel.dylib
	cp build/tvos_simulator/gpt4all/llama.cpp/libllama.dylib runtimes/tvos_simulator/libllama.dylib

lipo:
	mkdir -p gpt4all.net.Runtime/tvos-simulator
	cp runtimes/tvos_simulator/libllmodel.dylib gpt4all.net.Runtime/tvos-simulator/libllmodel.dylib
	cp runtimes/tvos_simulator/libllama.dylib gpt4all.net.Runtime/tvos-simulator/libllama.dylib
	mkdir -p gpt4all.net.Runtime/tvos-device
	cp runtimes/tvos/libllmodel.dylib gpt4all.net.Runtime/tvos-device/libllmodel.dylib
	cp runtimes/tvos/libllama.dylib gpt4all.net.Runtime/tvos-device/libllama.dylib
	mkdir -p gpt4all.net.Runtime/ios-simulator
	cp runtimes/ios_simulator/libllmodel.dylib gpt4all.net.Runtime/ios-simulator/libllmodel.dylib
	cp runtimes/ios_simulator/libllama.dylib gpt4all.net.Runtime/ios-simulator/libllama.dylib
	mkdir -p gpt4all.net.Runtime/ios-device
	cp runtimes/ios/libllmodel.dylib gpt4all.net.Runtime/ios-device/libllmodel.dylib
	cp runtimes/ios/libllama.dylib gpt4all.net.Runtime/ios-device/libllama.dylib
	mkdir -p gpt4all.net.Runtime/macos
	cp runtimes/macos/libllmodel.dylib gpt4all.net.Runtime/macos/libllmodel.dylib
	cp runtimes/macos/libllama.dylib gpt4all.net.Runtime/macos/libllama.dylib
	mkdir -p gpt4all.net.Runtime/maccatalyst
	cp runtimes/maccatalyst/libllmodel.dylib gpt4all.net.Runtime/maccatalyst/libllmodel.dylib
	cp runtimes/maccatalyst/libllama.dylib gpt4all.net.Runtime/maccatalyst/libllama.dylib

android_arm64-v8a:
	rm -rf build/android-arm64-v8a
	cmake -DCMAKE_ANDROID_ARCH_ABI=arm64-v8a $(CMAKE_COMMANDS) -DCMAKE_SYSTEM_NAME=Android -DCMAKE_ANDROID_API=21 -DCMAKE_ANDROID_NDK=$(NDK) -S . -B build/android-arm64-v8a
	cmake --build build/android-arm64-v8a
	mkdir -p gpt4all.net.Runtime/android-arm64-v8a
	cp build/android-arm64-v8a/gpt4all/libllmodel.so gpt4all.net.Runtime/android-arm64-v8a/libllmodel.so

android_x86:
	rm -rf build/android-x86
	cmake -DCMAKE_ANDROID_ARCH_ABI=x86 $(CMAKE_COMMANDS) -DCMAKE_SYSTEM_NAME=Android -DCMAKE_ANDROID_API=21 -DCMAKE_ANDROID_NDK=$(NDK) -S . -B build/android-x86
	cmake --build build/android-x86
	mkdir -p gpt4all.net.Runtime/android-x86
	cp build/android-x86/gpt4all/libllmodel.so gpt4all.net.Runtime/android-x86/libllmodel.so

android_x64:
	rm -rf build/android-x86_64
	cmake -DCMAKE_ANDROID_ARCH_ABI=x86_64 $(CMAKE_COMMANDS) -DCMAKE_SYSTEM_NAME=Android -DCMAKE_ANDROID_API=21 -DCMAKE_ANDROID_NDK=$(NDK) -S . -B build/android-x86_64
	cmake --build build/android-x86_64
	mkdir -p gpt4all.net.Runtime/android-x86_64
	cp build/android-x86_64/gpt4all/libllmodel.so gpt4all.net.Runtime/android-x86_64/libllmodel.so