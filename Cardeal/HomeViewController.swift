//
//  ViewController.swift
//  Cardeal
//
//  Created by りゅひかる on 2021/03/26.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var cars = [Car]()
    var selectedModel: Car?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Models"
        cars = demoData
        
        let loginViewController = LoginViewController()
        
        loginViewController.modalPresentationStyle = .fullScreen
        
        present(loginViewController, animated: true)
        
        setupTableView()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.contentInset.top = 5
        tableView.register(UINib(nibName: "CarCell", bundle: nil), forCellReuseIdentifier: "CarCell")
    }
    @IBAction func profileClicked(_ sender: Any) {
        
        let profileSheet = UIAlertController (title: nil, message: nil, preferredStyle: .actionSheet)
    
        let logout = UIAlertAction (title: "Logout", style: .default) { (UIAlertAction) in
            // logout
            let loginViewController = LoginViewController()
            
            loginViewController.modalPresentationStyle = .fullScreen
            
            self.present(loginViewController, animated: true)
        }
        
        let manageAccounts = UIAlertAction(title: "Manage Accounts", style: .default) { (UIAlertAction) in
            //
        }
        
        let manageCards = UIAlertAction(title: "Manage Cards", style: .default) { (UIAlertAction) in
            //
        }
        
        let close = UIAlertAction(title: "Close", style: .cancel)
        
        profileSheet.addAction(manageCards)
        profileSheet.addAction(manageAccounts)
        profileSheet.addAction(logout)
        profileSheet.addAction(close)
        
        present(profileSheet, animated: true)
    }


}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarCell", for: indexPath) as! CarCell
        
        cell.displayCarCell(car: cars[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedModel = cars[indexPath.row]
        performSegue(withIdentifier: "ToCarDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! CarDetailViewController
        destination.car = selectedModel
    }
}
