//
//  AppContainer.swift
//  CarrotSearchBook
//
//  Created by 김윤석 on 2023/11/10.
//

import Foundation

protocol AppContainer: AnyObject {
    var network: NetworkManageable { get }
}

final class AppContainerImplementation: AppContainer {
    let network: NetworkManageable = NetworkManager()
}
