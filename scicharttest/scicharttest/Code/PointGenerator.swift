//
//  PointGenerator.swift
//  scicharttest
//
//  Created by Arkady Smirnov on 7/30/18.
//  Copyright © 2018 Arkady Smirnov. All rights reserved.
//

import Foundation

class PointGenerator: PointGeneratorProtcol {
    
    private static var timeInterval: TimeInterval = 1
    private weak var timer: Timer?
    private var xAxis: Double
    private var yAxis: Double
    
    private var subscriptionHandler: PointGeneratorProtcol.NotificationClosure?
    
    //TODO: не совсем честный сабскипшн, но все же
    func subscribe(updateHandler: @escaping PointGeneratorProtcol.NotificationClosure) {
        subscriptionHandler = updateHandler
    }
    
    init() {
        self.xAxis = -1
        self.yAxis = (Double(arc4random_uniform(100)) - 50)/100
        self.timer = Timer.scheduledTimer(timeInterval: PointGenerator.timeInterval, target: self, selector: #selector(timerTick), userInfo: nil, repeats: true)
        
    }
    
    @objc private func timerTick(timer: Timer) {
        //TODO: не переживаем за OutOfRange
        self.xAxis += 1
        self.yAxis += (Double(arc4random_uniform(200)) - 100)/100
        self.subscriptionHandler?(self.xAxis, self.yAxis)
    }
    
    deinit {
        self.timer?.invalidate()
    }
}
