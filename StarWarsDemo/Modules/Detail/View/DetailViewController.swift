//
//  DetailViewController.swift
//  StarWarsDemo
//
//  Created by Nikita Korolev on 23/07/2019.
//  Copyright © 2019 Никита Королев. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var person: Person!
    var viewModel: DetailViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = viewModel.person.name
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
