//
//  NotaTableViewCell.swift
//  SBAFiliacion
//
//  Created by Lucas Avellaneda on 17/12/2018.
//  Copyright © 2018 Lucas Avellaneda. All rights reserved.
//

import UIKit

class NotaTableViewCell: UITableViewCell {

    @IBOutlet var notaTextView: UITextView! {
        didSet {
            notaTextView.text = nota
        }
    }
    
    public var nota:String? {
        didSet {
            notaTextView.text = nota
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
