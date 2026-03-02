import QtQuick

Window {
    id: mainWindow
    width: 900
    height: 650
    visible: true
    title: "Premier League Gallery"

    // ===== CURRENT SCREEN STATE =====
    property string currentScreen: "splash"  // splash, home, gallery, about
    property var clubs: [
        {
            name: "Liverpool",
            logo: "images/liverpool.png",
            founded: 1892,
            stadium: "Anfield",
            capacity: 61276,
            manager: "Arne Slot",
            color: "#C8102E",
            position: 1,
            titles: 19,
            cups: 8,
            foreigners: 17
        },
        {
            name: "Manchester City",
            logo: "images/mancity.png",
            founded: 1880,
            stadium: "Etihad Stadium",
            capacity: 53400,
            manager: "Pep Guardiola",
            color: "#6CABDD",
            position: 2,
            titles: 9,
            cups: 7,
            foreigners: 18
        },
        {
            name: "Arsenal",
            logo: "images/arsenal.png",
            founded: 1886,
            stadium: "Emirates Stadium",
            capacity: 60704,
            manager: "Mikel Arteta",
            color: "#EF0107",
            position: 3,
            titles: 13,
            cups: 14,
            foreigners: 16
        },
        {
            name: "Chelsea",
            logo: "images/chelsea.png",
            founded: 1905,
            stadium: "Stamford Bridge",
            capacity: 40343,
            manager: "Enzo Maresca",
            color: "#034694",
            position: 4,
            titles: 6,
            cups: 8,
            foreigners: 19
        },
        {
            name: "Tottenham",
            logo: "images/tottenham.png",
            founded: 1882,
            stadium: "Tottenham Stadium",
            capacity: 62850,
            manager: "Ange Postecoglou",
            color: "#132257",
            position: 5,
            titles: 2,
            cups: 8,
            foreigners: 15
        },
        {
            name: "Newcastle United",
            logo: "images/newcastle.png",
            founded: 1892,
            stadium: "St James Park",
            capacity: 52305,
            manager: "Eddie Howe",
            color: "#241F20",
            position: 6,
            titles: 4,
            cups: 6,
            foreigners: 14
        },
        {
            name: "Manchester United",
            logo: "images/manutd.png",
            founded: 1878,
            stadium: "Old Trafford",
            capacity: 74310,
            manager: "Erik ten Hag",
            color: "#DA291C",
            position: 7,
            titles: 20,
            cups: 12,
            foreigners: 16
        },
        {
            name: "Aston Villa",
            logo: "images/astonvilla.png",
            founded: 1874,
            stadium: "Villa Park",
            capacity: 42657,
            manager: "Unai Emery",
            color: "#95BFE5",
            position: 8,
            titles: 7,
            cups: 7,
            foreigners: 13
        },
        {
            name: "West Ham",
            logo: "images/westham.png",
            founded: 1895,
            stadium: "London Stadium",
            capacity: 62500,
            manager: "Julen Lopetegui",
            color: "#7A263A",
            position: 9,
            titles: 0,
            cups: 3,
            foreigners: 17
        },
        {
            name: "Crystal Palace",
            logo: "images/crystalpalace.png",
            founded: 1905,
            stadium: "Selhurst Park",
            capacity: 25486,
            manager: "Oliver Glasner",
            color: "#1B458F",
            position: 10,
            titles: 0,
            cups: 0,
            foreigners: 12
        },
        {
            name: "Leicester City",
            logo: "images/leicester.png",
            founded: 1884,
            stadium: "King Power Stadium",
            capacity: 32312,
            manager: "Steve Cooper",
            color: "#003090",
            position: 11,
            titles: 1,
            cups: 1,
            foreigners: 14
        },
        {
            name: "Bournemouth",
            logo: "images/bournemouth.png",
            founded: 1899,
            stadium: "Vitality Stadium",
            capacity: 11307,
            manager: "Andoni Iraola",
            color: "#DA291C",
            position: 12,
            titles: 0,
            cups: 0,
            foreigners: 15
        },
        {
            name: "Fulham",
            logo: "images/fulham.png",
            founded: 1879,
            stadium: "Craven Cottage",
            capacity: 25700,
            manager: "Marco Silva",
            color: "#000000",
            position: 13,
            titles: 0,
            cups: 0,
            foreigners: 16
        },
        {
            name: "Southampton",
            logo: "images/southampton.png",
            founded: 1885,
            stadium: "St Marys Stadium",
            capacity: 32384,
            manager: "Russell Martin",
            color: "#D71920",
            position: 14,
            titles: 0,
            cups: 1,
            foreigners: 13
        }
    ]    // ===== SCREENS =====
    SplashScreen {
        id: splashScreen
        visible: currentScreen === "splash"
        onFinished: currentScreen = "home"
    }

    HomeScreen {
        id: homeScreen
        visible: currentScreen === "home"
        onGoToGallery: currentScreen = "gallery"
        onGoToAbout: currentScreen = "about"
    }

    GalleryScreen {
        id: galleryScreen
        visible: currentScreen === "gallery"
        clubs: mainWindow.clubs
        onGoBack: currentScreen = "home"
    }

    AboutScreen {
        id: aboutScreen
        visible: currentScreen === "about"
        onGoBack: currentScreen = "home"
    }
}
