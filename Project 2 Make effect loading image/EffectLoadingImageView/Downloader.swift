//
//  Downloader.swift
//  EffectLoadingImageView
//
//  Created by Pham Quang Huy on 12/10/16.
//  Copyright © 2016 Framgia, Inc. All rights reserved.
//

import Foundation
import ImageIO
import UIKit
import Accelerate

struct ProgressReporter {
    
    struct Task {
        let downloadTask: NSURLSessionDataTask
        
        typealias FinishedAction = NSData -> Void
        let finishedAction: FinishedAction
        
        let progress = NSProgress()
        let tempData = NSMutableData()
        let imageSource = CGImageSourceCreateIncremental(nil)
        let imageTransform: (UIImage -> UIImage)?
    }
    let tasks: [Task]
    var finishedTasksCount = 0
    
    typealias ReportProgress = (progress: Double, image: UIImage?) -> Void
    let reportProgress: ReportProgress?
    
    init(tasks: [Task], reportProgress: ReportProgress?) {
        self.tasks = tasks
        self.reportProgress = reportProgress
    }
    
    var totalProgress: Double {
        
        let completedUnitCount = tasks.map({ $0.progress.completedUnitCount }).reduce(0, combine: +)
        let totalUnitCount = tasks.map({ $0.progress.totalUnitCount }).reduce(0, combine: +)
        
        return Double(completedUnitCount) / Double(totalUnitCount)
    }
}

class Downloader: NSObject {
    static let sharedDownloader = Downloader()
    var progressReporters = [ProgressReporter]()
    
    lazy var session: NSURLSession = {
        let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: sessionConfig, delegate: self, delegateQueue: nil)
        return session
    }()
    
    class func downloadAttachment(item: Item, reportProgress: ProgressReporter.ReportProgress?, imageTransform: (UIImage -> UIImage)?, imageFinished: (UIImage -> Void)?) {
        let attachmentURLString = item.imageURL!
        var attachmentDownloadTask: NSURLSessionDataTask?
        var attachmentFinishedAction: ProgressReporter.Task.FinishedAction?
        
        if !attachmentURLString.isEmpty, let URL = NSURL(string: attachmentURLString) {
            attachmentDownloadTask = sharedDownloader.session.dataTaskWithURL(URL)
            
            attachmentFinishedAction = { data in
                SafeDispatch.async {
                    let fileName = NSUUID().UUIDString
                    
                    if let _ = NSFileManager.saveImageData(data, withName: fileName) {
                        print("save image success!")
                        
                        if let image = UIImage(data: data) {
                            imageFinished?(image)
                        }
                    }
                }
            }
        }
        
        var tasks: [ProgressReporter.Task] = []
        
        if let attachmentDownloadTask = attachmentDownloadTask, attachmentFinishedAction = attachmentFinishedAction {
            tasks.append(ProgressReporter.Task(downloadTask: attachmentDownloadTask, finishedAction: attachmentFinishedAction, imageTransform: imageTransform))
        }
        
        if tasks.count > 0 {
            
            let progressReporter = ProgressReporter(tasks: tasks, reportProgress: reportProgress)
            
            sharedDownloader.progressReporters.append(progressReporter)
            
            tasks.forEach { $0.downloadTask.resume() }
            
        } else {
            print("Can NOT download attachments of message")
        }
    }
}

extension Downloader: NSURLSessionDelegate {
    
}

extension Downloader: NSURLSessionDataDelegate {
    func reportProgressAssociatedWithDownloadTask(downloadTask: NSURLSessionDataTask, totalBytes: Int64) {
        
        for progressReporter in progressReporters {
            
            for i in 0..<progressReporter.tasks.count {
                
                if downloadTask == progressReporter.tasks[i].downloadTask {
                    
                    progressReporter.tasks[i].progress.totalUnitCount = totalBytes
                    
                    progressReporter.reportProgress?(progress: progressReporter.totalProgress, image: nil)
                    
                    return
                }
            }
        }
    }
    
    func reportProgressAssociatedWithDownloadTask(downloadTask: NSURLSessionDataTask, didReceiveData data: NSData) -> Bool {
        
        for progressReporter in progressReporters {
            
            for i in 0..<progressReporter.tasks.count {
                
                if downloadTask == progressReporter.tasks[i].downloadTask {
                    
                    let didReceiveDataBytes = Int64(data.length)
                    progressReporter.tasks[i].progress.completedUnitCount += didReceiveDataBytes
                    progressReporter.tasks[i].tempData.appendData(data)
                    
                    let progress = progressReporter.tasks[i].progress
                    let final = progress.completedUnitCount == progress.totalUnitCount
                    /*
                     progressReporter.reportProgress?(progress: progressReporter.totalProgress, image: nil)
                     */
                    let imageSource = progressReporter.tasks[i].imageSource
                    let data = progressReporter.tasks[i].tempData
                    
                    CGImageSourceUpdateData(imageSource, data, final)
                    
                    var tranformedImage: UIImage?
                    if let cgImage = CGImageSourceCreateImageAtIndex(imageSource, 0, nil) {
                        /*
                         let image = UIImage(CGImage: cgImage)
                         if let imageTransform = progressReporter.tasks[i].imageTransform {
                         tranformedImage = imageTransform(image)
                         }
                         */
                        let image = UIImage(CGImage: cgImage.yep_extendedCanvasCGImage)
                        if progressReporter.totalProgress < 1 {
                            let blurPercent = CGFloat(1 - progressReporter.totalProgress)
                            let radius = 5 * blurPercent
                            let iterations = UInt(10 * blurPercent)
                            //println("radius: \(radius), iterations: \(iterations)")
                            if let blurredImage = image.blurredImageWithRadius(radius, iterations: iterations, tintColor: UIColor.clearColor()) {
                                if let imageTransform = progressReporter.tasks[i].imageTransform {
                                    tranformedImage = imageTransform(blurredImage)
                                }
                            }
                        }
                    }
                    
                    progressReporter.reportProgress?(progress: progressReporter.totalProgress, image: tranformedImage)
                    
                    return final
                }
            }
        }
        
        return false
    }
    
    func finishDownloadTask(downloadTask: NSURLSessionDataTask) {
        
        for i in 0..<progressReporters.count {
            
            for j in 0..<progressReporters[i].tasks.count {
                
                if downloadTask == progressReporters[i].tasks[j].downloadTask {
                    
                    let finishedAction = progressReporters[i].tasks[j].finishedAction
                    let data = progressReporters[i].tasks[j].tempData
                    finishedAction(data)
                    
                    progressReporters[i].finishedTasksCount += 1
                    
                    // 若任务都已完成，移除此 progressReporter
                    if progressReporters[i].finishedTasksCount == progressReporters[i].tasks.count {
                        progressReporters.removeAtIndex(i)
                    }
                    
                    return
                }
            }
        }
    }
    
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveResponse response: NSURLResponse, completionHandler: (NSURLSessionResponseDisposition) -> Void) {
        //println("YepDownloader begin, expectedContentLength:\(response.expectedContentLength)")
        reportProgressAssociatedWithDownloadTask(dataTask, totalBytes: response.expectedContentLength)
        completionHandler(.Allow)
    }
    
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveData data: NSData) {
        //println("YepDownloader data.length: \(data.length)")
        
        let finish = reportProgressAssociatedWithDownloadTask(dataTask, didReceiveData: data)
        
        if finish {
            //println("YepDownloader finish")
            finishDownloadTask(dataTask)
        }
    }
}
