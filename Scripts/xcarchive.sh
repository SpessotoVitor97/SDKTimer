UNIVERSAL_OUTPUTFOLDER=${BUILD_DIR}/${CONFIGURATION}-universal

exec > /tmp/${PRODUCT_NAME}_archive.log 2>&1

rm -r "${PROJECT_DIR}/${FULL_PRODUCT_NAME}"

if [ "true" == ${ALREADYINVOKED:-false} ]
then
    echo "RECURSION: Detected, stopping"
else
    export ALREADYINVOKED="true"

    #Make sure the output directory exists
    mkdir -p "${UNIVERSAL_OUTPUTFOLDER}"

    ARCHIVE_DEVICE_PATH="${PROJECT_DIR}"/"${TARGET_NAME}"-iphoneos.xcarchive
    ARCHIVE_SIMULATOR_PATH="${PROJECT_DIR}"/"${TARGET_NAME}"-iphonesimulator.xcarchive
    ARCHIVE_CATALYST_PATH="${PROJECT_DIR}"/"${TARGET_NAME}"-catalyst.xcarchive
    XC_OUTPUT_PATH="${PROJECT_DIR}"/"${TARGET_NAME}".xcframework

    echo "Device path: ${ARCHIVE_DEVICE_PATH}"
    echo "Simulator path: ${ARCHIVE_SIMULATOR_PATH}"
    echo "Catalyst path: ${ARCHIVE_CATALYST_PATH}"
    echo "XCFramework path: ${XC_OUTPUT_PATH}"

    rm -r "${ARCHIVE_DEVICE_PATH}"
    rm -r "${ARCHIVE_SIMULATOR_PATH}"
    rm -r "${ARCHIVE_CATALYST_PATH}"
    rm -r "${XC_OUTPUT_PATH}"

    echo "Archive for iphone device"
    xcodebuild archive -workspace "${WORKSPACE_PATH}" -scheme "${PROJECT_NAME}" \
    -destination "generic/platform=iOS" \
    -archivePath "${ARCHIVE_DEVICE_PATH}" \
    SKIP_INSTALL=NO BUILD_LIBRARIES_FOR_DISTRIBUTION=YES

    echo "Archive for iphone simulator"
    xcodebuild archive -workspace "${WORKSPACE_PATH}" -scheme "${PROJECT_NAME}" \
    -destination "generic/platform=iOS Simulator" \
    -archivePath "${ARCHIVE_SIMULATOR_PATH}" \
    SKIP_INSTALL=NO BUILD_LIBRARIES_FOR_DISTRIBUTION=YES

    echo "Archive for Mac Catalyst"
    xcodebuild archive -workspace "${WORKSPACE_PATH}" -scheme "${PROJECT_NAME}" \
    -destination "platform=macOS,arch=x86_64,variant=Mac Catalyst" \
    -archivePath "${ARCHIVE_CATALYST_PATH}" \
    SKIP_INSTALL=NO BUILD_LIBRARIES_FOR_DISTRIBUTION=YES

    echo "Create xcframework"
    xcodebuild -create-xcframework \
    -framework "${ARCHIVE_DEVICE_PATH}"/Products/Library/Frameworks/"${TARGET_NAME}".framework \
    -framework "${ARCHIVE_SIMULATOR_PATH}"/Products/Library/Frameworks/"${TARGET_NAME}".framework \
    -framework "${ARCHIVE_CATALYST_PATH}"/Products/;Library/Frameworks/"${TARGET_NAME}".framework \
    -output "${XC_OUTPUT_PATH}"

    #Open the directory
    open "${PROJECT_DIR}"
fi