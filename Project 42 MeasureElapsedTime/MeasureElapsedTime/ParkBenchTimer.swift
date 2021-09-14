//
//  ParkBenchTimer.swift
//  MeasureElapsedTime
//
//  Created by HuyPQ22 on 2021/09/03.
//

import Foundation

class ParkBenchTimer {

    let startTime:CFAbsoluteTime
    var endTime:CFAbsoluteTime?

    init() {
        startTime = CFAbsoluteTimeGetCurrent()
    }

    func stop() -> CFAbsoluteTime {
        endTime = CFAbsoluteTimeGetCurrent()

        return duration!
    }

    var duration:CFAbsoluteTime? {
        if let endTime = endTime {
            return endTime - startTime
        } else {
            return nil
        }
    }
}
