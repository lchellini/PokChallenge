//
//  UITableView_ext.swift
//  PokChallenge
//
//  Created by Lorenzo Chellini on 02/08/21.
//

import UIKit


extension UITableView {
    func loadingView(p_color:UIColor) -> UIActivityIndicatorView{
        var activityIndicatorView = UIActivityIndicatorView()
        if self.tableFooterView == nil {
            let indicatorFrame = CGRect(x: 0, y: 0, width: self.bounds.width, height: 80)
            activityIndicatorView = UIActivityIndicatorView(frame: indicatorFrame)
            activityIndicatorView.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin]
            
            if #available(iOS 13.0, *) {
                activityIndicatorView.style = .large
            } else {
                activityIndicatorView.style = .whiteLarge
            }
            
            activityIndicatorView.color = p_color
            activityIndicatorView.hidesWhenStopped = true

            self.tableFooterView = activityIndicatorView
            return activityIndicatorView
        }
        else {
            return activityIndicatorView
        }
    }

    func addLoading(_ p_indexPath:IndexPath, p_closure: @escaping (() -> Void)){
        loadingView(p_color: UIColor.gray).startAnimating()
        if let lastVisibleIndexPath = self.indexPathsForVisibleRows?.last {
            if p_indexPath == lastVisibleIndexPath && p_indexPath.row == self.numberOfRows(inSection: 0) - 1 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    p_closure()
                }
            }
        }
    }

    func stopLoading() {
        if self.tableFooterView != nil {
            self.tableFooterView = nil
        }
        else {
            self.tableFooterView = nil
        }
    }
}
