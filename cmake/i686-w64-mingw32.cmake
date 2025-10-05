set(CMAKE_SYSTEM_NAME       Windows)
set(CMAKE_SYSTEM_PROCESSOR  i686)
set(TOOLCHAIN_PREFIX        i686-w64-mingw32)

set(CMAKE_EXECUTABLE_SUFFIX_ASM ".exe")
set(CMAKE_EXECUTABLE_SUFFIX_C   ".exe")
set(CMAKE_EXECUTABLE_SUFFIX_CXX ".exe")

include(any_toolchain)

add_compile_definitions(I686 WIN32)
add_compile_options(
    "-march=i686 -mtune=i686"
    "-mconsole"
)
add_link_options()
