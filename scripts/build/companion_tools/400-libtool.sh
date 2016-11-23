# Build script for libtool

do_companion_tools_libtool_get() {
    CT_GetFile "libtool-${CT_LIBTOOL_VERSION}"     \
        {http,ftp,https}://ftp.gnu.org/gnu/libtool
}

do_companion_tools_libtool_extract() {
    CT_Extract "libtool-${CT_LIBTOOL_VERSION}"
    CT_DoExecLog ALL chmod -R u+w "${CT_SRC_DIR}/libtool-${CT_LIBTOOL_VERSION}"
    CT_Patch "libtool" "${CT_LIBTOOL_VERSION}"
}

do_companion_tools_libtool_for_build() {
    CT_DoStep EXTRA "Installing libtool"
    mkdir -p "${CT_BUILD_DIR}/build-libtool"
    CT_Pushd "${CT_BUILD_DIR}/build-libtool"
    
    CT_DoLog EXTRA "Configuring libtool"
    CT_DoExecLog CFG \
    "${CT_SRC_DIR}/libtool-${CT_LIBTOOL_VERSION}/configure" \
        --prefix="${CT_BUILDTOOLS_PREFIX_DIR}"

    CT_DoLog EXTRA "Building libtool"
    CT_DoExecLog ALL make

    CT_DoLog EXTRA "Installing libtool"
    CT_DoExecLog ALL make install
    CT_Popd
    CT_EndStep
}
