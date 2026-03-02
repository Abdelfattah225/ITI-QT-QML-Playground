cmake_minimum_required(VERSION 3.16)

project(Task1 VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)
find_package(Qt6 REQUIRED COMPONENTS Quick Multimedia)


qt_standard_project_setup(REQUIRES 6.8)

qt_add_executable(appTask1
    main.cpp
)
qt_add_qml_module(appTask1
    URI Task1
    QML_FILES
        Main.qml
        SplashScreen.qml
        HomeScreen.qml
        GalleryScreen.qml
        AboutScreen.qml
    RESOURCES
        splash.jpg
        splash_new.mp4
        premierleague.jpeg
        premierleague1.jpeg
        images/arsenal.png
        images/astonvilla.png
        images/bournemouth.png
        images/chelsea.png
        images/crystalpalace.png
        images/fulham.png
        images/leicester.png
        images/liverpool.png
        images/mancity.png
        images/manutd.png
        images/newcastle.png
        images/norwich.png
        images/southampton.png
        images/tottenham.png
        images/watford.png
        images/westbrom.png
        images/westham.png
)
set_target_properties(appTask1 PROPERTIES
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)


target_link_libraries(appTask1
    PRIVATE Qt6::Quick Qt6::Multimedia
)
include(GNUInstallDirs)
install(TARGETS appTask1
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
