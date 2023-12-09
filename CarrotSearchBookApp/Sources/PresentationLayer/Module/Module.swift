//
//  Module.swift
//  CarrotSearchBook
//
//  Created by 김윤석 on 2023/11/10.
//

import UIKit
import Combine

protocol Transition {}

struct Module<T: Transition, V: UIViewController> {
    let viewController: V
    let transitionPublisher: AnyPublisher<T, Never>
}
