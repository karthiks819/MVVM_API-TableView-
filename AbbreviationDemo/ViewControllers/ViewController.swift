//
//  ViewController.swift
//  AbbreviationDemo
//
//  Created by Karthik on 09/06/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var emptyMessageLabel: UILabel!
    
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet var doneLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchTextfield: UITextField!
    @IBOutlet weak var tableView: UITableView!
    private var acronymViewModel: AcronymViewModel!
    private var acronymDataSource: AcronymTableViewDatasource<AcronymTableViewCell, LF>!
    let cellIdentifier = "AcronymCell"
    let errMessage = "Search field should not be empty"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = 50.0
        self.tableView.rowHeight = UITableView.automaticDimension
        self.callToViewModelForUIUpdate()
    }
    
    func callToViewModelForUIUpdate(){
        
        self.acronymViewModel =  AcronymViewModel()
        self.acronymViewModel.AcronymViewModelToController = {
            DispatchQueue.main.async {
                self.hideLoader()
                if self.acronymViewModel.AcronymModelData == nil {
                    
                    self.tableView.isHidden = true
                    self.emptyMessageLabel.isHidden = !self.tableView.isHidden
                }else {
                    
                    self.tableView.isHidden = false
                    self.emptyMessageLabel.isHidden = !self.tableView.isHidden
                }
                self.updateDataSource()
            }
        }
    }
    
    func updateDataSource() {
        guard let data = self.acronymViewModel.AcronymModelData, let lfs = data.lfs
        else {return}
        hideLoader()
        self.acronymDataSource = AcronymTableViewDatasource(cellIdentifier: cellIdentifier, items: lfs, configureCell: { cell, data in
            cell.titleLabel.text = self.acronymViewModel.AcronymModelData.sf + ": "+(data?.lf ?? "")
            cell.descriptionLabel.text = "\(data?.freq ?? 0)"
        })
        
        DispatchQueue.main.async {
            self.tableView.dataSource = self.acronymDataSource
            self.tableView.reloadData()
        }
    }
    
    func showLoader() {
        self.spinner.startAnimating()
        self.view.isUserInteractionEnabled = false
    }
    
    func hideLoader() {
        self.spinner.stopAnimating()
        self.view.isUserInteractionEnabled = true
    }
    //Uncomment this for dynamic results by the search string
    @IBAction func searchTextField(_ sender: UITextField) {
        //        if let text = sender.text {
        //            self.acronymViewModel.callFuncToGetAPIData(searchText: text)
        //        }
    }
    
    
    @IBAction func searchButtonAction(_ sender: UIButton) {
        if let text = self.searchTextfield.text, text != "" {
            showLoader()
            self.errorMessageLabel.text = ""
            self.acronymViewModel.callFuncToGetAPIData(searchText: text)
            self.tableView.isHidden = false
        }else {
            hideLoader()
            self.errorMessageLabel.text = self.errMessage
            self.tableView.isHidden = true
        }
    }
    
}


extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
