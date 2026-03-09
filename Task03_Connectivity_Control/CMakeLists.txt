cmake_minimum_required(VERSION 3.16)

project(Task03_Connectivity_Control VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)


# ADD THIS LINE before find_package
list(APPEND CMAKE_PREFIX_PATH "/home/abdo/Qt/6.10.2/gcc_64")


find_package(Qt6 REQUIRED COMPONENTS Quick QuickControls2 DBus)

qt_standard_project_setup(REQUIRES 6.8)

qt_add_executable(appTask03_Connectivity_Control
    main.cpp
    wifimanager.hpp
    wifimanager.cpp
    bluetoothmanager.h
    bluetoothmanager.cpp
)

qt_add_qml_module(appTask03_Connectivity_Control
    URI ConnectivityControl
    VERSION 1.0
    QML_FILES
        Main.qml
    RESOURCES
        icons/wifi.svg
        icons/bluetooth.svg
        RESOURCES README.md
)

set_target_properties(appTask03_Connectivity_Control PROPERTIES
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appTask03_Connectivity_Control
    PRIVATE Qt6::Quick
            Qt6::QuickControls2
            Qt6::DBus
)

include(GNUInstallDirs)
install(TARGETS appTask03_Connectivity_Control
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
