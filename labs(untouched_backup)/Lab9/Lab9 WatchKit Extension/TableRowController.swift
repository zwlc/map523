//
//  TableRowController.swift
//  Lab9 WatchKit Extension
//
//  Created by Anh Tran on 2019-04-02.
//  Copyright © 2019 Anh Tran. All rights reserved.
//

import WatchKit

class TableRowController: NSObject {

    @IBOutlet weak var idLbl: WKInterfaceLabel!
    @IBOutlet weak var minLbl: WKInterfaceLabel!
    @IBOutlet weak var maxLbl: WKInterfaceLabel!
    @IBOutlet weak var avgLbl: WKInterfaceLabel!

    var id: Int?
    var rowData: [Int]? {
        didSet {
            guard let rowData = rowData else { return }
            guard let id = id else { return }

            idLbl.setText(String(id))
            minLbl.setText(String(rowData[0]))
            maxLbl.setText(String(rowData[1]))
            avgLbl.setText(String(rowData[2]))
        }
    }


}
