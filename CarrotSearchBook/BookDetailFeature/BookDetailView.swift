//
//  BookDetailView.swift
//  CarrotSearchBook
//
//  Created by 김윤석 on 2023/11/11.
//

import UIKit

enum BookDetailViewAction {
    case pop
}

final class BookDetailView: UIView {
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
