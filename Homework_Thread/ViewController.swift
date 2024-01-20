//
//  ViewController.swift
//  Homework_Thread
//
//  Created by Vlad on 3.01.24.
//

import UIKit

class BankAccount {
    
    var accountBalance: Float = 0
    
    private let lock = NSLock()
    
    func deposit(ammount: Float) {
        lock.lock()
        accountBalance += ammount
        print("Пополнение: \(ammount), текущий баланс: \(accountBalance)")
        defer {
            lock.unlock()
        }
    }
    
    func withdraw(ammount: Float) {
        lock.lock()
        if accountBalance >= ammount {
            accountBalance -= ammount
            print("Со счета снято: \(ammount), текущий баланс: \(accountBalance)")
        } else {
            print("Операция невозможна: недостаточно средств")
        }
        defer {
            lock.unlock()
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
        
        let serialQueue = DispatchQueue(label: "com.feature.serialQueue", attributes: .concurrent)
        
        serialQueue.async {
            self.account.deposit(ammount: 100)
        }
        
        serialQueue.async {
            self.account.withdraw(ammount: 70)
        }
        
        serialQueue.async {
            self.account.withdraw(ammount: 90)
        }
        
        serialQueue.async {
            self.account.deposit(ammount: 300)
        }
        
        serialQueue.async {
            self.account.deposit(ammount: 50)
        }
    }


}

