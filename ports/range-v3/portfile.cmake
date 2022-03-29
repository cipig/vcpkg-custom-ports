vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO KomodoPlatform/range-v3
    REF d800a032132512a54c291ce55a2a43e0460591c7 # 0.10.0
    SHA512 20023107d6d94f078bd4660dc223be2e6623dd891cdd7d2b6c861795d495ca50b3e55a2f25f6c8648c11cf0d3695e2ea0603375fef7768e7f5e543f1d8a8f601
    HEAD_REF master
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        -DRANGE_V3_TESTS=OFF
        -DRANGE_V3_EXAMPLES=OFF
        -DRANGE_V3_PERF=OFF
        -DRANGE_V3_HEADER_CHECKS=OFF
)

vcpkg_install_cmake()

vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/range-v3)

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug ${CURRENT_PACKAGES_DIR}/lib)

vcpkg_copy_pdbs()

file(INSTALL ${SOURCE_PATH}/LICENSE.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)