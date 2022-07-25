vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO KomodoPlatform/range-v3
    REF 8c88f7174bcc71e525015430282cd7b984f8be47 # 0.12.0
    SHA512 deebc59d05313069a00cae27fa1b761d414b58507f362e0a263e570a950e069f31195fccc0364e835c3a2ac91e17c16fa537e124b1b389aeaa340f8198282c10
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