//
//  OrderList.swift
//  FruitInn
//
//  Created by Tariq on 1/14/20.
//  Copyright © 2020 Tariq. All rights reserved.
//

import UIKit

class OrderList: UIViewController {

    @IBOutlet weak var ordersTableView: UITableView!
    @IBOutlet weak var ordersCountLb: UILabel!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var orders = [orderData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setMenuBtn(menuButton: menuButton)
        addTitleImage()
        ordersTableView.delegate = self
        ordersTableView.dataSource = self
        
        ordersHandelRefresh()
        // Do any additional setup after loading the view.
    }
    
    func ordersHandelRefresh(){
        ordersApi.orderListApi { (orders) in
            if let orders = orders.data{
                self.orders = orders
                self.ordersCountLb.text = "\(self.orders.count)"
                self.ordersTableView.reloadData()
            }
        }
    }

}
extension OrderList: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderListCell", for: indexPath) as! OrderListCell
        cell.configureation(orders: orders[indexPath.item])
        cell.selectionStyle = .none
        return cell
    }
    
    
}
