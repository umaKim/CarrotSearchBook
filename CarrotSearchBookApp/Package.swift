// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CarrotSearchBookApp",
    platforms: [.iOS(.v16)],
    products: [
        //이렇게??
//        .library(name: "BookListPresentationLayer", targets: ["BookListPresentationLayer"])
            .library(name: "PresentationLayer", targets: ["PresentationLayer"]),
            .library(name: "DomainLayer", targets: ["DomainLayer"]),
            .library(name: "DataLayer", targets: ["DataLayer"]),
            .library(name: "Infrastructure", targets: ["Infrastructure"])
    ],
    dependencies: [.package(path: "../Platform")],
    targets: [
        
        //dependency를 ca dependency로 만들어야하는가?
        // presentation -> Domain <- Data 이렇게??
        .target(name: "PresentationLayer", dependencies: []),
        .target(name: "DomainLayer", dependencies: []),
        .target(name: "DataLayer", dependencies: []),
        .target(name: "Infrastructure", dependencies: [
            .product(name: "Common", package: "Platform")
        ])
    ]
)
