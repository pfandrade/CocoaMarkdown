#!/bin/bash

SCRIPTS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
PROJ_DIR="$SCRIPTS_DIR/.."

XCBUILD="xcrun xcodebuild"
#
$XCBUILD build -project "$PROJ_DIR/CocoaMarkdown.xcodeproj" -scheme 'CocoaMarkdown' -configuration Release -destination 'generic/platform=iOS' SYMROOT='build'
$XCBUILD build -project "$PROJ_DIR/CocoaMarkdown.xcodeproj" -scheme 'CocoaMarkdown' -configuration Release -destination 'generic/platform=iOS Simulator' SYMROOT='build'
$XCBUILD build -project "$PROJ_DIR/CocoaMarkdown.xcodeproj" -scheme 'CocoaMarkdown' -configuration Release -destination 'generic/platform=macOS' SYMROOT='build'

pushd build
find . -type d -name Frameworks -exec rm -rf {} \;
popd

$XCBUILD -create-xcframework \
	-framework "$PROJ_DIR/build/Release/CocoaMarkdown.framework"\
	-debug-symbols "$PROJ_DIR/build/Release/CocoaMarkdown.framework.dSYM"\
	-framework "$PROJ_DIR/build/Release-iphoneos/CocoaMarkdown.framework"\
	-debug-symbols "$PROJ_DIR/build/Release-iphoneos/CocoaMarkdown.framework.dSYM"\
	-framework "$PROJ_DIR/build/Release-iphonesimulator/CocoaMarkdown.framework"\
	-debug-symbols "$PROJ_DIR/build/Release-iphonesimulator/CocoaMarkdown.framework.dSYM" \
	-output "$PROJ_DIR/build/CocoaMarkdown.xcframework"
