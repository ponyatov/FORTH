set(CMAKE_SYSTEM_NAME       Generic)
set(CMAKE_SYSTEM_PROCESSOR  arm)
set(TOOLCHAIN_PREFIX        arm-none-eabi)
set(CMAKE_CROSS_COMPILING   true)
set(CMAKE_EXECUTABLE_SUFFIX ".elf")

include(any_toolchain)

add_compile_definitions(CORTEX)

add_compile_options(
    -mthumb
    -ffunction-sections -fdata-sections
    $<$<COMPILE_LANGUAGE:CXX>:-nostdinc++>
    $<$<COMPILE_LANGUAGE:CXX>:-fno-rtti>
    $<$<COMPILE_LANGUAGE:CXX>:-fno-exceptions>
    $<$<COMPILE_LANGUAGE:CXX>:-fno-threadsafe-statics>
    $<$<COMPILE_LANGUAGE:ASM>:-x$<SEMICOLON>assembler-with-cpp>
    $<$<COMPILE_LANGUAGE:ASM>:-MMD>
    $<$<COMPILE_LANGUAGE:ASM>:-MP>
)

# set(LD ${CMAKE_BINARY_DIR}/${HW}.ld)
# set(LD ${CMAKE_SOURCE_DIR}/get/linker.ld) # Espruino
# set(LD ${CMAKE_SOURCE_DIR}/hw/${HW}/${CPU_}x_FLASH.ld)

set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)
add_link_options(
    -mthumb
    -T ${LD}
    --specs=nano.specs -Wl,--start-group -lc -lm -lnosys  -Wl,--end-group
    # --specs=rdimon.specs -Wl,--start-group -lc -lm -lrdimon -Wl,--end-group
    -Wl,--start-group -lstdc++ -lsupc++ -Wl,--end-group
    -Wl,-Map=${CMAKE_PROJECT_NAME}.map -Wl,--gc-sections
)
