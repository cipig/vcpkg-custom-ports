include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO jedisct1/libsodium
    REF fd8c876bb5ad9d5ad79074ccd6b509f845631807
    SHA512 b66bfc387303d97597fde6c5490b60b70849cf6bdaa479658c916248c159a1c8cf5f237995f132b13557332e920a5314f18edca8f64da8b9f33f0707cf9ce9bf
    HEAD_REF master
)

configure_file(
    ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt
    ${SOURCE_PATH}/CMakeLists.txt
    COPYONLY
)

configure_file(
    ${CMAKE_CURRENT_LIST_DIR}/sodiumConfig.cmake.in
    ${SOURCE_PATH}/sodiumConfig.cmake.in
    COPYONLY
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        -DBUILD_TESTING=OFF
)

vcpkg_install_cmake()

vcpkg_copy_pdbs()

vcpkg_fixup_cmake_targets(
    CONFIG_PATH lib/cmake/unofficial-sodium
    TARGET_PATH share/unofficial-sodium
)

file(REMOVE_RECURSE
    ${CURRENT_PACKAGES_DIR}/debug/include
)

file(REMOVE ${CURRENT_PACKAGES_DIR}/include/Makefile.am)

if (VCPKG_LIBRARY_LINKAGE STREQUAL "static")
    vcpkg_replace_string(
        ${CURRENT_PACKAGES_DIR}/include/sodium/export.h
        "#ifdef SODIUM_STATIC"
        "#if 1 //#ifdef SODIUM_STATIC"
    )
endif ()

configure_file(
    ${SOURCE_PATH}/LICENSE
    ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright
    COPYONLY
)

#vcpkg_test_cmake(PACKAGE_NAME unofficial-sodium)
