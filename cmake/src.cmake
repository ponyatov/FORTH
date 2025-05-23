# scan project for source code files

file(GLOB LD
    RELATIVE ${CMAKE_SOURCE_DIR}
    hw/${HW}/*.ld
)

file(GLOB S
    RELATIVE ${CMAKE_SOURCE_DIR}
    hw/${HW}/*.s
)

file(GLOB C
    RELATIVE ${CMAKE_SOURCE_DIR}
    src/*.c*
    # cross
      hw/src/*.c*   hw/${HW}/src/*.c*
     cpu/src/*.c*  cpu/${CPU}/src/*.c*
    arch/src/*.c* arch/${ARCH}/src/*.c*
      os/src/*.c*   os/${OS}/src/*.c*
    # libs
    lib/src/*.c* lib/*/src/*.c*
    # CortexM/CubeMX
    hw/${HW}/Core/Src/*.c*
    hw/${HW}/Drivers/CMSIS/Device/ST/${SERIES}xx/Source/*.c*
    hw/${HW}/Drivers/${SERIES}xx_HAL_Driver/Src/*.c*
    hw/${HW}/USB_DEVICE/App/*.c* hw/${HW}/USB_DEVICE/Target/*.c*
    hw/${HW}/Middlewares/ST/STM32_USB_Device_Library/Core/Src/*.c*
    hw/${HW}/Middlewares/ST/STM32_USB_Device_Library/Class/CDC/Src/*.c*
)

file(GLOB H
    RELATIVE ${CMAKE_SOURCE_DIR}
    inc/*.h*
    # cross
      hw/inc/*.h*   hw/${HW}/inc/*.h*
     cpu/inc/*.h*  cpu/${CPU}/inc/*.h*
    arch/inc/*.h* arch/${ARCH}/inc/*.h*
      os/inc/*.h*   os/${OS}/inc/*.h*
    # libs
    lib/inc/*.h* lib/*/inc/*.h*
    # CortexM/CubeMX
    hw/${HW}/Core/Inc/*.h*
    hw/${HW}/Drivers/CMSIS/Include/*.h*
    hw/${HW}/Drivers/CMSIS/Core/Include/*.h*
    hw/${HW}/Drivers/${SERIES}xx_HAL_Driver/Inc/*.h*
    hw/${HW}/Drivers/CMSIS/Device/ST/${SERIES}xx/Include/*.h*
    hw/${HW}/USB_DEVICE/App/*.h* hw/${HW}/USB_DEVICE/Target/*.h*
    hw/${HW}/Middlewares/ST/STM32_USB_Device_Library/Core/Inc/*.h*
    hw/${HW}/Middlewares/ST/STM32_USB_Device_Library/Class/CDC/Inc/*.h*
)

file(GLOB INC
    RELATIVE ${CMAKE_SOURCE_DIR}
    ${CMAKE_BINARY_DIR}
    inc
    # cross
      hw/inc   hw/${HW}/inc
     cpu/inc  cpu/${CPU}/inc
    arch/inc arch/${ARCH}/inc
      os/inc   os/${OS}/inc
    # libs
    lib/inc lib/*/inc
    # CortexM/CubeMX
    hw/${HW}/Core/Inc
    hw/${HW}/Drivers/CMSIS/Include
    hw/${HW}/Drivers/CMSIS/Core/Include
    hw/${HW}/Drivers/${SERIES}xx_HAL_Driver/Inc
    hw/${HW}/Drivers/CMSIS/Device/ST/${SERIES}xx/Include
    hw/${HW}/USB_DEVICE/App hw/${HW}/USB_DEVICE/Target
    hw/${HW}/Middlewares/ST/STM32_USB_Device_Library/Core/Inc
    hw/${HW}/Middlewares/ST/STM32_USB_Device_Library/Class/CDC/Inc
)
include_directories(${INC})
