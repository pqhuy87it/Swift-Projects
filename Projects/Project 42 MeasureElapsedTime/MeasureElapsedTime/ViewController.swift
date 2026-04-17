//
//  ViewController.swift
//  MeasureElapsedTime
//
//  Created by HuyPQ22 on 2021/09/03.
//
// https://stackoverflow.com/questions/24755558/measure-elapsed-time-in-swift

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        evaluateProblem()
//        mesuareTime()
//        mesuareTime1()
//        mesuareTime2()
        mesuareTime3()
    }

    func evaluateProblem() {
        let start = DispatchTime.now() // <<<<<<<<<< Start time
        
        for i in 0...1000000 {
            print(i)
        }
        
        let end = DispatchTime.now()   // <<<<<<<<<<   end time
        let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds // <<<<< Difference in nano seconds (UInt64)
            let timeInterval = Double(nanoTime) / 1_000_000_000 // Technically could overflow for long running tests

            print("Time to evaluate : \(timeInterval) seconds")
    }

    func mesuareTime() {
        let timer = ParkBenchTimer()
        
        for i in 0...1000000 {
            print(i)
        }
        
        print("The task took \(timer.stop()) seconds.")
    }
    
    func mesuareTime1() {
        do {
            let begin = clock()
            
            // do something
            for i in 0...1000000 {
                print(i)
            }
            
            let diff = Double(clock() - begin) / Double(CLOCKS_PER_SEC)
            print("The task took \(diff) seconds.")
        }
    }
    
    func mesuareTime2() {
        do {
            var info = mach_timebase_info(numer: 0, denom: 0)
            mach_timebase_info(&info)
            let begin = mach_absolute_time()
            // do something
            for i in 0...1000000 {
                print(i)
            }
            let diff = Double(mach_absolute_time() - begin) * Double(info.numer) / Double(info.denom)
            print("The task took \(diff / 1_000_000_000) seconds.")
        }
    }
    
    func mesuareTime3() {
        do {
            let info = ProcessInfo.processInfo
            let begin = info.systemUptime
            // do something
            for i in 0...1000000 {
                print(i)
            }
            let diff = (info.systemUptime - begin) / 1_000_000_000
            print("The task took \(diff) seconds.")
        }
    }
}

