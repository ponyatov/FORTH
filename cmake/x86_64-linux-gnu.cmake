set(CMAKE_SYSTEM_NAME       Linux)
set(CMAKE_SYSTEM_PROCESSOR  x86_64)
set(TOOLCHAIN_PREFIX        ${ARCH}-${OS}-gnu)

set(CMAKE_EXECUTABLE_SUFFIX_ASM "")
set(CMAKE_EXECUTABLE_SUFFIX_C   "")
set(CMAKE_EXECUTABLE_SUFFIX_CXX "")

include(any_toolchain)

add_compile_definitions(X86_64 LINUX)
add_compile_options(-mtune=native)
add_link_options()
