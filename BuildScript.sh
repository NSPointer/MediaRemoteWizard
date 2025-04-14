project_path=$(cd `dirname $0`; pwd)

project_name="MediaRemoteWizard"

scheme_name="MediaRemoteWizard"

development_mode="Debug"

build_path=${project_path}/build

xcodebuild -scheme ${scheme_name} -arch arm64e -configuration ${development_mode} CONFIGURATION_BUILD_DIR=build

#xcodebuild -scheme ${scheme_name} -arch arm64e -configuration ${development_mode} CONFIGURATION_BUILD_DIR=build/arm64e

exit 0


