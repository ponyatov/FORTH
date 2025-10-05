find_package(FLEX              REQUIRED)
find_package(BISON             REQUIRED)
find_program( RAGEL_EXECUTABLE ragel   )
# find_package(Readline REQUIRED)

file(GLOB L
    RELATIVE ${CMAKE_SOURCE_DIR}
    src/*.lex
    lib/src/*.lex lib/*/src/*.lex
)

file(GLOB Y
    RELATIVE ${CMAKE_SOURCE_DIR}
    src/*.yacc
    lib/src/*.yacc lib/*/src/*.yacc
)

file(GLOB R
    RELATIVE ${CMAKE_SOURCE_DIR}
    src/*.ragel
    lib/src/*.ragel lib/*/src/*.ragel
)

foreach(LEX_FILE ${L})
    string(REGEX REPLACE ".+\/(.+)\.lex$" "${CMAKE_BINARY_DIR}/\\1.lex.cpp"
        LEXER_CPP           ${LEX_FILE})
        list(APPEND CP      ${LEXER_CPP})
    string(REGEX REPLACE ".+\/(.+)\.lex$" "${CMAKE_BINARY_DIR}/\\1.lex.hpp"
        LEXER_HPP           ${LEX_FILE})
        list(APPEND HP      ${LEXER_HPP})
    add_custom_command(
        OUTPUT              ${LEXER_CPP} ${LEXER_HPP}
        DEPENDS             ${LEX_FILE}
        WORKING_DIRECTORY   ${CMAKE_SOURCE_DIR}
        COMMAND             ${FLEX_EXECUTABLE}
        ARGS                --header-file=${LEXER_HPP} -o ${LEXER_CPP} ${LEX_FILE}
    )
endforeach()

foreach(YACC_FILE ${Y})
    string(REGEX REPLACE ".+\/(.+)\.yacc$" "${CMAKE_BINARY_DIR}/\\1.yacc.cpp"
        PARSER_CPP          ${YACC_FILE})
    string(REGEX REPLACE ".+\/(.+)\.yacc$" "${CMAKE_BINARY_DIR}/\\1.yacc.hpp"
        PARSER_HPP          ${YACC_FILE})
    list(APPEND CP          ${PARSER_CPP})
    list(APPEND HP          ${PARSER_HPP})
    add_custom_command(
        OUTPUT              ${PARSER_CPP} ${PARSER_HPP}
        DEPENDS             ${YACC_FILE}
        WORKING_DIRECTORY   ${CMAKE_SOURCE_DIR}
        COMMAND             ${BISON_EXECUTABLE}
        ARGS                -o ${PARSER_CPP} ${YACC_FILE}
    )
endforeach()

if(RAGEL_EXECUTABLE)
    foreach(RAGEL_FILE ${R})
        string(REGEX REPLACE ".+\/(.+)\.ragel$" "${CMAKE_BINARY_DIR}/\\1.ragel.cpp"
            RAGEL_CPP           ${RAGEL_FILE})
        list(APPEND CP          ${RAGEL_CPP})
        add_custom_command(
            OUTPUT              ${RAGEL_CPP}
            DEPENDS             ${RAGEL_FILE}
            WORKING_DIRECTORY   ${CMAKE_SOURCE_DIR}
            COMMAND             ${RAGEL_EXECUTABLE}
            ARGS                -C -G2 -o ${RAGEL_CPP} ${RAGEL_FILE}
        )
    endforeach()
endif()
