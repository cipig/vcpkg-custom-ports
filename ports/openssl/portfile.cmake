if(EXISTS "${CURRENT_INSTALLED_DIR}/include/openssl/ssl.h")
  message(FATAL_ERROR "Can't build openssl if libressl/boringssl is installed. Please remove libressl/boringssl, and try install openssl again if you need it.")
endif()

set(OPENSSL_VERSION 1.1.1w)
vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/openssl/openssl/releases/download/OpenSSL_1_1_1w/openssl-${OPENSSL_VERSION}.tar.gz"
    FILENAME "openssl-${OPENSSL_VERSION}.tar.gz"
    SHA512 b4c625fe56a4e690b57b6a011a225ad0cb3af54bd8fb67af77b5eceac55cc7191291d96a660c5b568a08a2fbf62b4612818e7cca1bb95b2b6b4fc649b0552b6d
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
