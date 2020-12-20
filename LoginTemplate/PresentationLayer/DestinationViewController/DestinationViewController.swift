//
//  DestinationViewController.swift
//  LoginTemplate
//
//  Created by Ацкий Станислав on 20.12.2020.
//

import UIKit

class DestinationViewController: UIViewController {
    
    // MARK: - UI
    
    private lazy var destinationView: DestinationView = {
        let destView = DestinationView()
        return destView
    }()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = destinationView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }


}
