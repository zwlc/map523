//
//  DataTableController.swift
//  Lab9 WatchKit Extension
//
//  Created by Anh Tran on 2019-04-02.
//  Copyright © 2019 Anh Tran. All rights reserved.
//

import Foundation
import WatchKit

class DataTableController: WKInterfaceController {
    @IBOutlet weak var dataTable: WKInterfaceTable!

    var hrData = [[Int]]()

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        hrData = context as! [[Int]]
        dataTable.setNumberOfRows(hrData.count, withRowType: "dataRow")

        for index in 0..<dataTable.numberOfRows {
            guard let controller = dataTable.rowController(at: index) as? TableRowController else { continue }
            controller.id = index + 1
            controller.rowData = hrData[index]
        }
    }
}
