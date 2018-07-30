//
//  PointGeneratorProtcol.swift
//  scicharttest
//
//  Created by Arkady Smirnov on 7/30/18.
//  Copyright © 2018 Arkady Smirnov. All rights reserved.
//

import Foundation

protocol PointGeneratorProtcol {
    typealias NotificationClosure = (Double, Double) -> Void
    func subscribe(updateHandler: @escaping NotificationClosure)
}
