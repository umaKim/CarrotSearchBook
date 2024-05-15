//
//  AppContainer.swift
//  CarrotSearchBook
//
//  Created by 김윤석 on 2023/11/10.
//

//import DataLayer
import Infrastructure
import Foundation

public protocol AppContainer {
    var network: NetworkManageable { get }
}

public struct AppContainerImplementation: AppContainer {
    public let network: NetworkManageable = NetworkManager()
    
    public init() { }
}
