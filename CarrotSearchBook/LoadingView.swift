//
//  LoadingView.swift
//  CarrotSearchBook
//
//  Created by 김윤석 on 2023/11/11.
//

import UIKit

protocol LoadingShowable { }

extension LoadingShowable {
    func showLoadingView() {
        let windowView = UIApplication.shared.windows.first(where: { $0.isKeyWindow })
        if let loadingView = windowView?.viewWithTag(LoadingView.tagValue) as? LoadingView {
            loadingView.isLoading = true
        } else {
            let loadingView = LoadingView(frame: UIScreen.main.bounds)
            windowView?.addSubview(loadingView)
            loadingView.isLoading = true
        }
    }

    func hideLoadingView() {
        let windowView = UIApplication.shared.windows.first(where: { $0.isKeyWindow })
        windowView?.viewWithTag(LoadingView.tagValue)?.removeFromSuperview()
    }
}

final class LoadingView: UIView {
    static let tagValue: Int = 1234123

    var isLoading: Bool = false {
        didSet { isLoading ? start() : stop() }
    }

    private let indicator = UIActivityIndicatorView(style: .large)

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initialSetup() {
        tag = LoadingView.tagValue
        backgroundColor = UIColor.black.withAlphaComponent(0.5)
        indicator.color = .white
        indicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(indicator)
        indicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }

    func start() {
        indicator.startAnimating()
    }

    func stop() {
        indicator.stopAnimating()
    }
}
