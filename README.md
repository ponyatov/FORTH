# ![](vscode/FORTH.png) `FORTH/MCU`
## CLI/REPL system for 32bit MCUs

(c) Dmitry Ponyatov <<dponyatov@gmail.com>> 2024 MIT

github: https://github.com/ponyatov/FORTH

- should be as small as possible
    - need ST-Link v2 with `SWO` line enabled
    - requires USB Serial class for native REPL on @ref STM32F4DISCOVERY etc
- bytecode interpreter
    - for easy extending without low-level tricks

## Targets

- @ref STM32
    - @ref STM32F4DISCOVERY
    - @ref STM32F407G-DISC1
- @ref ESP32
    - TODO
