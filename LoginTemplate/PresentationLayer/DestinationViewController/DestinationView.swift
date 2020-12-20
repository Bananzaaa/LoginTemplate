//
//  DestinationView.swift
//  LoginTemplate
//
//  Created by Ацкий Станислав on 20.12.2020.
//

import UIKit
import SnapKit

final class DestinationView: UIView {
    
    // MARK: - UI
    
    private lazy var greetingLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome!"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 25, weight: .bold)
        addSubview(label)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        greetingLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
