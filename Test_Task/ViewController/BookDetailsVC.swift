//
//  BookDetailsVC.swift
//  Test_Task
//
//  Created by Sajid Nawaz on 09/12/2020.
//


import UIKit

class BookDetailsVC: UIViewController {

    //
    // MARK: - IBOutlet
    //
    @IBOutlet weak var lblBookTitle: UILabel!
    @IBOutlet weak var lblBookAuthor: UILabel!
    @IBOutlet weak var lblBookPublisher: UILabel!
    @IBOutlet weak var lblBookLanguage: UILabel!
    @IBOutlet weak var lblBookPages: UILabel!
    @IBOutlet weak var lblBookIdentifier: UILabel!
    @IBOutlet weak var lblBookEdition: UILabel!
    @IBOutlet weak var lblBookLibrary: UILabel!
    @IBOutlet weak var lblBookYear: UILabel!
    @IBOutlet weak var lblBookMarked: UILabel!
    
    //
    // MARK: - variable
    //
    var book:Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblBookTitle.text = "Name: \(book?.title ?? "")"
        lblBookAuthor.text = "Author: \(book?.author ?? "")"
        lblBookPublisher.text = "Publisher: \(book?.publisher ?? "")"
        lblBookLanguage.text = "Language: \(book?.language ?? "")"
        lblBookPages.text = "Pages: \(book?.pages ?? 0)"
        lblBookIdentifier.text = "Identifier: \(book?.identifier ?? "")"
        lblBookEdition.text = "Edition: \(book?.edition ?? 1)"
        lblBookLibrary.text = "Library: \(book?.library ?? "")"
        lblBookYear.text = "Published Year: \(book?.year ?? 2000)"
        if((book?.bookmarked ?? "") == "1")
        {
            lblBookMarked.text = "BookMarked: Yes"
        }else{
            lblBookMarked.text = "BookMarked: No"
        }
    }
    
    @IBAction func backbtntpd(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
