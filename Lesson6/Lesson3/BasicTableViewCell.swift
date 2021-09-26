//
//  BasicTableViewCell.swift
//  Lesson3
//
//  Created by Владимир Рузавин on 9/14/21.
//

import UIKit

class BasicTableViewCell: UITableViewCell {

    @IBOutlet private weak var basicLabel: UILabel!
    func configure(text: String) {
        self.basicLabel.text = text
    }
}
