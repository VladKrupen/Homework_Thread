//
//  ViewController.swift
//  Homework_Thread
//
//  Created by Vlad on 3.01.24.
//

import UIKit

class BankAccount {
    
    var accountBalance: Float = 0
    let synchronizationQueue = DispatchQueue(label: "com.feature.synchronizationQueue")
    
    func deposit(ammount: Float) {
        synchronizationQueue.async(flags: .barrier) {
            self.accountBalance += ammount
            print("Пополнение: \(ammount), текущий баланс: \(self.accountBalance)")
        }
    }
    
    func withdraw(ammount: Float) {
        synchronizationQueue.async(flags: .barrier) {
            if self.accountBalance >= ammount {
                self.accountBalance -= ammount
                print("Со счета снято: \(ammount), текущий баланс: \(self.accountBalance)")
            } else {
                print("Операция невозможна: недостаточно средств")
            }
        }
    }
    
    
}

class ViewController: UIViewController {
    
    let account = BankAccount()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: - Thread
        
//        let firstThread = Thread {
//            self.account.deposit(ammount: 100)
////            print("Баланс: \(self.account.accountBalance)")
//        }
//        
//        let secondThread = Thread {
//            self.account.withdraw(ammount: 70)
//        }
//        
//        let thirdThread = Thread {
//            self.account.withdraw(ammount: 90)
//        }
//        
//        let fourthThread = Thread {
//            self.account.deposit(ammount: 300)
//        }
//        
//        let fifthThread = Thread {
//            self.account.deposit(ammount: 50)
//        }
//        
//        
//        firstThread.start()
//        secondThread.start()
//        thirdThread.start()
//        fourthThread.start()
//        fifthThread.start()
        
        //MARK: - GCD
        
        let concurrentlQueue = DispatchQueue(label: "com.feature.concurrentlQueue", attributes: .concurrent)
        
        concurrentlQueue.async {
            self.account.deposit(ammount: 100)
        }
        
        concurrentlQueue.async {
            self.account.withdraw(ammount: 70)
        }
        
        concurrentlQueue.async {
            self.account.withdraw(ammount: 90)
        }
        
        concurrentlQueue.async {
            self.account.deposit(ammount: 300)
        }
        
        concurrentlQueue.async {
            self.account.deposit(ammount: 50)
        }
    }


}

