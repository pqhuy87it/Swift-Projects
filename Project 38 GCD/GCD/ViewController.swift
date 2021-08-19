//
//  ViewController.swift
//  GCD
//
//  Created by Pham Quang Huy on 2021/08/19.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textView: UITextView!
    
    var items: [String] = []
    var timer: DispatchSourceTimer!
    var signal: DispatchSourceSignal!
    
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        items = ["basicQueue",
                 "basicQueueSync",
                 "concurrentQueue0",
                 "concurrentQueue1",
                 "delayedQueues",
                 "typeOfQueue",
                 "dispatchWorkItem",
                 "barrierInAQueue",
                 "groupsQueue",
                 "groupsQueueNotify",
                 "dispatchForTimer",
                 "dispatchForSignal",
                 "operationQueuesBasic",
                 "operationQueuesMultipleOperations",
                 "operationQueuesDependency",
                 "operationQueuesDynamicBlocks",
                 "operationQueuesCompletionBlocks"
        ]
    }

    // MARK: - Methods
    
    func basicQueue() {
        self.textView.text = ""
        
        let queue = DispatchQueue(label: "pl.fulmanski.concurrencyDispatchQueues.basicQueue")
        
        for i in 100..<105 {
            updateLogs("=\(i)")
        }
        
        queue.async {
            for i in 200..<205 {
                self.updateLogs("==\(i)")
            }
        }
        
        for i in 300..<305 {
            updateLogs("===\(i)")
        }
    }
    
    func basicQueueSync() {
        self.textView.text = ""
        
        let queue = DispatchQueue(label: "pl.fulmanski.concurrencyDispatchQueues.basicQueue")
        
        for i in 100..<105 {
            updateLogs("=\(i)")
        }
        
        queue.sync{
            for i in 200..<205 {
                self.updateLogs("==\(i)")
            }
        }
        
        for i in 300..<305 {
            updateLogs("===\(i)")
        }
    }
    
    func concurrentQueue(){
        self.textView.text = ""
        
        let concurrentQueue = DispatchQueue(label: "pl.fulmanski.concurrencyDispatchQueues.concurrent",
                                            qos: DispatchQoS.utility)
        
        concurrentQueue.async{
            for i in 100..<105 {
                self.updateLogs("=\(i)")
            }
        }
        
        concurrentQueue.async{
            for i in 200..<205 {
                self.updateLogs("==\(i)")
            }
        }
        
        concurrentQueue.async{
            for i in 300..<305 {
                self.updateLogs("===\(i)")
            }
        }
    }
    
    func concurrentQueue1(){
        self.textView.text = ""
        
        let concurrentQueue = DispatchQueue(label: "pl.fulmanski.concurrencyDispatchQueues.concurrent",
                                            qos: DispatchQoS.utility,
                                            attributes: .concurrent)
        
        concurrentQueue.async{
            for i in 100..<105 {
                self.updateLogs("=\(i)")
            }
        }
        
        concurrentQueue.async{
            for i in 200..<205 {
                self.updateLogs("==\(i)")
            }
        }
        
        concurrentQueue.async{
            for i in 300..<305 {
                self.updateLogs("===\(i)")
            }
        }
    }
    
    func delayedQueues() {
        self.textView.text = ""
        
        let delayedQueues = DispatchQueue(label: "pl.fulmanski.concurrencyDispatchQueues.delay",
                                          qos: DispatchQoS.utility,
                                          attributes: .concurrent)
        let delayTime: DispatchTimeInterval = .seconds(5)
        
        printTime(withComment: "1")
        delayedQueues.asyncAfter(deadline: .now() + delayTime) {
            [weak self] in
            self?.printTime(withComment: "3")
        }
        printTime(withComment: "2")
    }
    
    func typeOfQueue() {
        self.textView.text = ""
        
        let globalQueue = DispatchQueue.global()
        let mainQueue = DispatchQueue.main
        
        globalQueue.async {
            for i in 100..<105 {
                self.updateLogs("=\(i)")
            }
        }
        
        globalQueue.async{
            for i in 200..<205 {
                self.updateLogs("=\(i)")
            }
        }
        
        mainQueue.async{
            for i in 300..<305 {
                self.updateLogs("==\(i)")
            }
        }
        
        mainQueue.async{
            for i in 400..<405 {
                self.updateLogs("==\(i)")
            }
        }
    }
    
    func dispatchWorkItem() {
        self.textView.text = ""
        
        // A DispatchWorkItem is a block of code that can be dispatched on any queue
        
        // Create a DispatchWorkItem
        let workItem = DispatchWorkItem {
            [weak self] in
            self?.printTime(withComment: "workItem")
        }
        
        // Dispatch the work item on the main thread
        workItem.perform()
        
        // Dispatch the work item on the other queue
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            workItem.perform()
        }
        // or the same but with more convenient method
        queue.async(execute: workItem)
        
        // Notify other queue when a work item is dispatched
        workItem.notify(queue: DispatchQueue.main) {
            [weak self] in
            self?.printTime(withComment: "Notification from a workItem")
        }
    }
    
    func barrierInAQueue() {
        self.textView.text = ""
        
        let queue = DispatchQueue.global()
        
        queue.async {
            for i in 100..<105 {
                self.updateLogs("=\(i)")
            }
        }
        
        queue.async {
            for i in 200..<205 {
                self.updateLogs("==\(i)")
            }
        }
        
        queue.async(flags: .barrier){
            for i in 300..<305 {
                self.updateLogs("===\(i)")
            }
        }
        
        queue.async {
            for i in 400..<405 {
                self.updateLogs("====\(i)")
            }
        }
        
        queue.async {
            for i in 500..<505 {
                self.updateLogs("=====\(i)")
            }
        }
    }
    
    func groupsQueue() {
        self.textView.text = ""
        
        let group = DispatchGroup()
        
        let queue_01 = DispatchQueue(label: "pl.fulmanski.concurrencyDispatchQueues.groups_01",
                                     attributes: .concurrent)
        let queue_02 = DispatchQueue(label: "pl.fulmanski.concurrencyDispatchQueues.groups_01",
                                     attributes: .concurrent)
        
        queue_01.async {
            group.enter()
            for i in 100..<105 {
                self.updateLogs("=\(i)")
            }
            group.leave()
        }
        
        queue_01.async {
            group.enter()
            for i in 200..<205 {
                self.updateLogs("=\(i)")
            }
            group.leave()
        }
        
        queue_02.async {
            group.enter()
            for i in 300..<305 {
                self.updateLogs("==\(i)")
            }
            group.leave()
        }
        
        queue_02.async {
            group.enter()
            for i in 400..<405 {
                self.updateLogs("==\(i)")
            }
            group.leave()
        }
        
        group.wait()
        self.updateLogs("MAIN THREAD")
    }
    
    func groupsQueueNotify() {
        self.textView.text = ""
        
        let group = DispatchGroup()
        
        let queue_01 = DispatchQueue(label: "pl.fulmanski.concurrencyDispatchQueues.groups_01",
                                     attributes: .concurrent)
        let queue_02 = DispatchQueue(label: "pl.fulmanski.concurrencyDispatchQueues.groups_01",
                                     attributes: .concurrent)
        
        queue_01.async {
            group.enter()
            for i in 100..<105 {
                self.updateLogs("=\(i)")
            }
            group.leave()
        }
        
        queue_01.async {
            group.enter()
            for i in 200..<205 {
                self.updateLogs("=\(i)")
            }
            group.leave()
        }
        
        queue_02.async {
            group.enter()
            for i in 300..<305 {
                self.updateLogs("==\(i)")
            }
            group.leave()
        }
        
        queue_02.async {
            group.enter()
            for i in 400..<405 {
                self.updateLogs("==\(i)")
            }
            group.leave()
        }
        
        group.notify(queue: DispatchQueue.main) {
            self.updateLogs("All the group’s tasks are completed")
        }
        
        self.updateLogs("MAIN THREAD")
    }
    
    func dispatchForTimer(){
        self.textView.text = ""
        
        printTime(withComment: "2")
        timer = DispatchSource.makeTimerSource()
        timer.schedule(deadline: .now() + .seconds(10),
                       repeating: .seconds(5),
                       leeway: .seconds(5))
        timer.setEventHandler {
            self.printTime(withComment: "hello world")
        }
        timer.activate()
        printTime(withComment: "3")
    }
    
    func dispatchForSignal(){
//        print(NSRunningApplication.current.bundleIdentifier!)
//        print(NSRunningApplication.current.processIdentifier)
        self.textView.text = ""
        
        printTime(withComment: "4")
        signal = DispatchSource.makeSignalSource(signal: Int32(SIGSTOP))
        
        signal.setEventHandler {
            self.printTime(withComment: "SIGSTOP")
        }
        signal.activate()
        printTime(withComment: "5")
    }
    
    func operationQueuesBasic() {
        let task = {self.printTime(withComment: "operationQueuesBasic")}
        let operationQueue = OperationQueue()
        operationQueue.addOperation(task)
    }
    
    func operationQueuesMultipleOperations() {
        self.textView.text = ""
        
        let operationQueue = OperationQueue()
        for index in 0..<5
        {
            let task = {self.printTime(withComment: "\(index)")}
            operationQueue.addOperation(task)
        }
    }
    
    func operationQueuesDependency() {
        self.textView.text = ""
        
        let operationQueue = OperationQueue()
        let dependentTask = {self.printTime(withComment: "dependent task")}
        let dependentBlock = BlockOperation(block: dependentTask)
        
        for index in 0..<5
        {
            let task = {self.printTime(withComment: "\(index)")}
            let block = BlockOperation(block: task)
            dependentBlock.addDependency(block)
            operationQueue.addOperation(block)
        }
        
        operationQueue.addOperation(dependentBlock)
    }
    
    func operationQueuesDynamicBlocks() {
        self.textView.text = ""
        
        let operationQueue = OperationQueue()
        
        for index in 0..<5
        {
            let task1 = {self.printTime(withComment: "\(index): 1")}
            let task2 = {self.printTime(withComment: "\(index): 2")}
            let task3 = {self.printTime(withComment: "\(index): 3")}
            
            let block = BlockOperation()
            block.addExecutionBlock(task1)
            block.addExecutionBlock(task2)
            block.addExecutionBlock(task3)
            operationQueue.addOperation(block)
        }
    }
    
    func operationQueuesCompletionBlocks() {
        self.textView.text = ""
        
        let operationQueue = OperationQueue()
        
        for index in 0..<5
        {
            let task1 =
                {
                    Thread.sleep(forTimeInterval: 1.5)
                    self.printTime(withComment: "\(index): sleep")
                }
            let task2 = {self.printTime(withComment: "\(index)")}
            let task3 = {self.printTime(withComment: "\(index): complete")}
            
            let block = BlockOperation()
            // Note that completionBlock is a property
            block.completionBlock = task3
            block.addExecutionBlock(task1)
            block.addExecutionBlock(task2)
            operationQueue.addOperation(block)
        }
    }
    
    // MARK: - Helper
    
    func printTime(withComment comment: String){
        let date = Date()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        updateLogs(comment + ": " + formatter.string(from: date))
    }
    
    func updateLogs(_ text: String) {
        DispatchQueue.main.async {
            self.textView.text = "\n\(text)\n" + self.textView.text
        }
    }
}

//MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        
        return cell
    }
}

//MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
            case 0:
                self.basicQueue()
            case 1:
                self.basicQueueSync()
            case 2:
                self.concurrentQueue()
            case 3:
                self.concurrentQueue1()
            case 4:
                self.delayedQueues()
            case 5:
                self.typeOfQueue()
            case 6:
                self.dispatchWorkItem()
            case 7:
                self.barrierInAQueue()
            case 8:
                self.groupsQueue()
            case 9:
                self.groupsQueueNotify()
            case 10:
                self.dispatchForTimer()
            case 11:
                self.dispatchForSignal()
            case 12:
                self.operationQueuesBasic()
            case 13:
                self.operationQueuesMultipleOperations()
            case 14:
                self.operationQueuesDependency()
            case 15:
                self.operationQueuesDynamicBlocks()
            case 16:
                self.operationQueuesCompletionBlocks()
            default:
                break
        }
    }
}

