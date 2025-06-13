if(EXISTS "${CURRENT_INSTALLED_DIR}/include/openssl/ssl.h")
  message(FATAL_ERROR "Can't build openssl if libressl/boringssl is installed. Please remove libressl/boringssl, and try install openssl again if you need it.")
endif()

set(OPENSSL_VERSION 3.0.16)
vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/openssl/openssl/releases/download/openssl-${OPENSSL_VERSION}/openssl-${OPENSSL_VERSION}.tar.gz"
    FILENAME "openssl-${OPENSSL_VERSION}.tar.gz"
    SHA512 5eea2b0c60d870549fc2b8755f1220a57f870d95fbc8d5cc5abb9589f212d10945f355c3e88ff48540a7ee1c4db774b936023ca33d7c799ea82d91eef9c1c16d
)

vcpkg_find_acquire_program(PERL)
get_filename_component(PERL_EXE_PATH ${PERL} DIRECTORY)
vcpkg_add_to_path("${PERL_EXE_PATH}")

if(VCPKG_TARGET_IS_UWP)
    include("${CMAKE_CURRENT_LIST_DIR}/uwp/portfile.cmake")
elseif(VCPKG_TARGET_IS_WINDOWS AND NOT VCPKG_TARGET_IS_MINGW)
    include("${CMAKE_CURRENT_LIST_DIR}/windows/portfile.cmake")
else()
    include("${CMAKE_CURRENT_LIST_DIR}/unix/portfile.cmake")
endif()


file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/usage" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}/")
