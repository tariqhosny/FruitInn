//
//  OrderListCell.swift
//  FruitInn
//
//  Created by Tariq on 1/14/20.
//  Copyright © 2020 Tariq. All rights reserved.
//

import UIKit

class OrderListCell: UITableViewCell {

    @IBOutlet weak var orderDataLb: UILabel!
    @IBOutlet weak var orderId: UILabel!
    @IBOutlet weak var orderStateLb: UILabel!
    
    func configureation(orders: orderData){
        orderDataLb.text = "Date: ".localized + (orders.created_at ?? "")
        orderId.text = "Order Code: ".localized + "\(orders.order_id ?? 0)"
        if Int(orders.order_stat ?? "") == 0{
            orderStateLb.text = "Order in Progress".localized
        }
        if Int(orders.order_stat ?? "") == 1{
            orderStateLb.text = "Order Delivered".localized
        }
        if Int(orders.order_stat ?? "") == 2{
            orderStateLb.text = "Order Canceled".localized
        }
    }

}
