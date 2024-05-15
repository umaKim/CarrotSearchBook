// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CarrotSearchBookApp",
    platforms: [.iOS(.v16)],
    products: [
        //이렇게??
//        .library(name: "BookListPresentationLayer", targets: ["BookListPresentationLayer"])
        
        .library(name: "DIManager", targets: ["DIManager"]),
        .library(name: "PresentationLayer",  targets: ["PresentationLayer"]),
        .library(name: "DomainLayer", targets: ["DomainLayer"]),
        .library(name: "DataLayer", targets: ["DataLayer"]),
        .library(name: "Infrastructure", targets: ["Infrastructure"])
    ],
    dependencies: [
        .package(path: "../Platform"),
//        .package(url: "https://github.com/Swinject/Swinject.git", from: "2.8.0")
    ],
    targets: [
        
//        // presentation -> Domain <- Data
//        .target(name: "DIManager", dependencies: [
////            "PresentationLayer",
//            "DomainLayer",
//            "DataLayer",
//            "Infrastructure"
//        ]),
        
        //Presentation -> Domain
        .target(name: "PresentationLayer", dependencies: [
            "DomainLayer"
        ]),
        
        .target(name: "DomainLayer", dependencies: [
//            "DIManager"
        ]),
        
        // Data -> Domain
        .target(name: "DataLayer", dependencies: [
            "DomainLayer",
            "Infrastructure",
            .product(name: "Common", package: "Platform")
        ]),
        
        .target(name: "Infrastructure", dependencies: [])
    ]
)


