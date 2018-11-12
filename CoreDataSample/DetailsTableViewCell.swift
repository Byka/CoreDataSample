//
//  DetailsTableViewCell.swift
//  CoreDataSample
//
//  Created by sbyka on 05/11/18.
//  Copyright © 2018 sbyka. All rights reserved.
//

import UIKit
import CoreData

class DetailsTableViewCell: UITableViewCell, ManagedObjectContextDependentType {
    
    var managedObjectContext: NSManagedObjectContext!

    @IBOutlet weak var titleCellLabel: UILabel!
    @IBOutlet weak var subTitleCellLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
