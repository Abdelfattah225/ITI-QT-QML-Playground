cmake_minimum_required(VERSION 3.16)

project(App4_Animation VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.8)

qt_add_executable(appApp4_Animation
    main.cpp
)

qt_add_qml_module(appApp4_Animation
    URI App4_Animation
    QML_FILES
        Main.qml
        QML_FILES AbdoRectangle.qml
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appApp4_Animation PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appApp4_Animation
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appApp4_Animation
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appApp4_Animation
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
