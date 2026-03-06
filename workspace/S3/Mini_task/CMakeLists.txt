cmake_minimum_required(VERSION 3.16)

project(Mini_task VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.8)

qt_add_executable(appMini_task
    main.cpp
)

qt_add_qml_module(appMini_task
    URI Mini_task
    QML_FILES
        Main.qml
        QML_FILES MCard.qml
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appMini_task PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appMini_task
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appMini_task
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appMini_task
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
