#!/bin/sh
#
# JBoss, Home of Professional Open Source
# Copyright Red Hat, Inc., and individual contributors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

BUILD_DIR="build"

## clean up the previous builds...
echo "Clean up (rm -rf $BUILD_DIR/)"
rm -rf $BUILD_DIR/

## build for the ARM arch:
echo "Building for the iOS SDK (ARM arch.)"
xcodebuild -scheme AeroGearOTP -sdk iphoneos -workspace AeroGearOTP.xcworkspace -configuration Release clean build

## Simulator: this matches what we have in Jenkins as well (currently only local, on matzew's machine)
echo "Building for the iphonesimulator SDK and executing tests"
xcodebuild -scheme AeroGearOTPTests -sdk iphonesimulator -workspace AeroGearOTP.xcworkspace -configuration Release clean build TEST_AFTER_BUILD=YES


## Generate universal binary for the device and simulator
mkdir -p $BUILD_DIR/universal
mkdir -p $BUILD_DIR/universal/Headers
SIMULATOR_LIB="$BUILD_DIR/AeroGearOTP/Build/Products/Release-iphonesimulator/libAeroGearOTP.a"
DEVICE_LIB="$BUILD_DIR/AeroGearOTP/Build/Products/Release-iphoneos/libAeroGearOTP.a"
lipo ${SIMULATOR_LIB} ${DEVICE_LIB} -create -output $BUILD_DIR/universal/libAeroGearOTP.a

## copy header files
cp -r $BUILD_DIR/AeroGearOTP/Build/Products/Release-iphoneos/include/AeroGearOTP/ $BUILD_DIR/universal/Headers

## creating a 'simple' dist file (tarball)
pushd $BUILD_DIR/universal
tar cfvz ../../AeroGear-OTP.iOS.tgz *

popd

## Clean old appledoc
echo "Generating the API doc"
rm -rf ./Docset
## Run appledoc
appledoc --project-name "AeroGear-OTP" --project-company "Red Hat" --company-id org.jboss.aerogear --output ~/help --docset-install-path ./Docset --index-desc ./index.appledoc.md ./AeroGearOTP/ 