//
//  Alertable.swift
//  CarrotSearchBook
//
//  Created by 김윤석 on 2023/11/11.
//

import UIKit

public protocol Alertable {}
public extension Alertable where Self: UIViewController {
    func showDefaultAlert(
        title: String,
        message: String? = nil,
        isCancelActionIncluded: Bool = false,
        actionDoneButtonTitle: String? = "Ok",
        actionCancelButtonTitle: String = "Cancel",
        preferredStyle style: UIAlertController.Style = .alert,
        handler: ((UIAlertAction) -> Void)? = nil
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        let actionDone = UIAlertAction(title: actionDoneButtonTitle, style: .default, handler: handler)
        alert.addAction(actionDone)
        
        if isCancelActionIncluded {
            let actionCancel = UIAlertAction(title: actionCancelButtonTitle, style: .cancel, handler: nil)
            alert.addAction(actionCancel)
        }
        
        self.present(alert, animated: true, completion: nil)
    }
}
