set(CMAKE_C_STANDARD   17)
set(CMAKE_CXX_STANDARD 17)

set(CMAKE_C_COMPILER_FORCED   TRUE)
set(CMAKE_CXX_COMPILER_FORCED TRUE)
set(CMAKE_C_COMPILER_ID       GNU)
set(CMAKE_CXX_COMPILER_ID     GNU)

set(CMAKE_C_COMPILER   ${TOOLCHAIN_PREFIX}-gcc)
set(CMAKE_ASM_COMPILER ${CMAKE_C_COMPILER})
set(CMAKE_CXX_COMPILER ${TOOLCHAIN_PREFIX}-g++)
set(CMAKE_LINKER       ${CMAKE_C_COMPILER})
set(CMAKE_OBJCOPY      ${TOOLCHAIN_PREFIX}-objcopy)
set(CMAKE_SIZE         ${TOOLCHAIN_PREFIX}-size)
set(CMAKE_RC_COMPILER  ${TOOLCHAIN_PREFIX}-windres)

# include(  os/${OS}/${OS}.cmake    )
# include(arch/${ARCH}/${ARCH}.cmake)
# include( cpu/${CPU}/${CPU}.cmake  )
# include(  hw/${HW}/${HW}.cmake    )

string(TOUPPER ${HW}   HW_  )
string(TOUPPER ${CPU}  CPU_ )
string(TOUPPER ${ARCH} ARCH_)
string(TOUPPER ${OS}   OS_  )

add_compile_options(
    -Wall -Wextra               # -Wpedantic
    -Wno-implicit-fallthrough   # ragel
    -Wno-unused-function        # flex
    -Wno-write-strings          # yacc
    -Wno-unused-parameter       # stm32
    $<$<CONFIG:Debug>:-DDEBUG>
)

add_compile_definitions(
    ${HW_} ${CPU_} ${ARCH_} ${OS_}
)

add_link_options(
    -Wl,--print-memory-usage
)

if(CMAKE_BUILD_TYPE MATCHES Debug)
    add_compile_options(-O0 -g3)
endif()
if(CMAKE_BUILD_TYPE MATCHES Release)
    add_compile_options(-Os -g0)
endif()

set(CMAKE_EXECUTABLE_SUFFIX_ASM ${CMAKE_EXECUTABLE_SUFFIX})
set(CMAKE_EXECUTABLE_SUFFIX_C   ${CMAKE_EXECUTABLE_SUFFIX})
set(CMAKE_EXECUTABLE_SUFFIX_CXX ${CMAKE_EXECUTABLE_SUFFIX})
