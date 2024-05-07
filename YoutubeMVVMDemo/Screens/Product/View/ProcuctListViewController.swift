//
//  ProcuctListViewController.swift
//  YoutubeMVVMDemo
//
//  Created by Siddharth Adhvaryu on 28/04/24.
//

import UIKit

class ProductListViewController: UIViewController {

    private var viewModel = ProductViewModel()
    @IBOutlet weak var productTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
    }
}

extension ProductListViewController:UITableViewDataSource,UITableViewDelegate {
    func configuration() {
        productTableView.dataSource = self
        productTableView.delegate = self
        productTableView.clipsToBounds = false
        productTableView.register(UINib(nibName: "ProcuctCell", bundle: nil), forCellReuseIdentifier: "ProcuctCell")
        initViewModel()
        observeEvent()
    }
    
    func initViewModel() {
        viewModel.fetchProduct()
    }
    
    func observeEvent() {
        viewModel.eventHandler = {[weak self] event in
            guard let self else {
                return
            }
            switch event {  
            case .loading:
                print("Product loading...")
            case .stoploading:
                print("Stop loading...")
            case .dataLoaded:
                print("Data loaded...")
                DispatchQueue.main.async {
                    self.productTableView.reloadData()
                }
            case .error(let error):
                print(error)
            }
        }
    }
    
    
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProcuctCell", for: indexPath) as? ProcuctCell else {
            return UITableViewCell()
        }
        let product = viewModel.products[indexPath.row]
        cell.product = product
        return cell
    }
}
