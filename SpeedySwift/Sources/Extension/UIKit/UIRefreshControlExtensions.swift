//
//  UIRefreshControlExtensions.swift
//  SpeedySwift
//
//  Created by Quinn Von on 7/24/18.
//  Copyright © 2018 SpeedySwift
//

#if os(iOS)
import UIKit

// MARK: - Methods
public extension UIRefreshControl {

    /// 在UITableView内开始刷新控件。
    ///
    /// - Parameters:
    ///   - tableView: UITableView instance, inside which the refresh control is contained.
    ///   - animated: Boolean, indicates that is the content offset changing should be animated or not.
    ///   - sendAction: Boolean, indicates that should it fire sendActions method for valueChanged UIControlEvents
    public func beginRefreshing(in tableView: UITableView, animated: Bool, sendAction: Bool = false) {
        //https://stackoverflow.com/questions/14718850/uirefreshcontrol-beginrefreshing-not-working-when-uitableviewcontroller-is-ins/14719658#14719658
        assert(superview == tableView, "Refresh control does not belong to the receiving table view")

        beginRefreshing()
        let offsetPoint = CGPoint(x: 0, y: -frame.height)
        tableView.setContentOffset(offsetPoint, animated: animated)

        if sendAction {
            sendActions(for: .valueChanged)
        }
    }

}
#endif
