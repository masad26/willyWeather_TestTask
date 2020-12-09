//
//  ViewController.swift
//  Test_Task

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class BookListVC: UIViewController {
    
    //
    // MARK: - IBOutlet
    //
    @IBOutlet weak var bookTblView: UITableView!
    
    //
    // MARK: - variable
    //
    var bookarr:[Book]?
    let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if Connectivity.isConnectedToInternet() {
            showLoader()
            LoadBooks()
        }else{
            
            let jsonData = UserDefaults.standard.object(forKey: "bookarrJson")
            let bookarrJson = NSKeyedUnarchiver.unarchiveObject(with: jsonData as? Data ?? Data())
            bookarr = Mapper<Book>().mapArray(JSONString: bookarrJson as? String ?? "")
            self.bookTblView.reloadData()
            
        }
    }
    
    func showLoader(){
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }

    func LoadBooks()
    {
        Alamofire.request(BookDATAURL).responseArray { (response: DataResponse<[Book]>) in
            self.bookarr = response.result.value
           
            let bookarrJson = Mapper().toJSONString(self.bookarr ?? [], prettyPrint: true)
            let bookData = NSKeyedArchiver.archivedData(withRootObject: bookarrJson as Any)
            UserDefaults.standard.set(bookData, forKey: "bookarrJson")
            self.bookTblView.reloadData()
            self.alert.dismiss(animated: false, completion: nil)
        }
    }

}

//
// MARK: - TableView Delegate
//

extension BookListVC:  UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
             if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BookDetailsVC") as? BookDetailsVC
               {
                   vc.book = bookarr?[indexPath.row]
                   self.navigationController?.pushViewController(vc, animated: true)
               }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookarr?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookcell", for: indexPath as IndexPath) as! BookTableCell
        cell.lblBookTitle.text = "Book Name: \(bookarr?[indexPath.row].title ?? "")"
        cell.lblBookAuthor.text = "Book Author: \(bookarr?[indexPath.row].author ?? "")"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

//
// MARK: - CELL
//
class BookTableCell: UITableViewCell {
    @IBOutlet weak var lblBookTitle: UILabel!
    @IBOutlet weak var lblBookAuthor: UILabel!
    
}
