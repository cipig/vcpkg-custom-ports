# header-only library
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO taskflow/taskflow
    REF v3.5.0
    SHA512 0e80a96eacce05cb09eb3e75634ba9f27c86d84b56903897e954e04fa68cadc3c2fe69857f8dc60da330c9abd5e4c7e1164f3c5f695ad8bb38a1ccbc001f8652
    HEAD_REF master
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        -DTF_BUILD_BENCHMARKS=OFF
        -DTF_BUILD_CUDA=OFF
        -DTF_BUILD_TESTS=OFF
        -DTF_BUILD_EXAMPLES=OFF
        -DBUILD_TESTING=OFF
        -DCMAKE_CUDA_COMPILER=OFF
)

vcpkg_install_cmake()

vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/Taskflow)

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug ${CURRENT_PACKAGES_DIR}/lib)

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
