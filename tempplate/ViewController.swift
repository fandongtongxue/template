//
//  ViewController.swift
//  tempplate
//
//  Created by isoftstone on 2023/5/19.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func searchBtnAction(_ sender: UIButton) {
        let searchVC = SearchViewController()
        present(searchVC, animated: true, completion: nil)
    }
    
}

