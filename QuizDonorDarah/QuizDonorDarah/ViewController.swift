//
//  ViewController.swift
//  QuizDonorDarah
//
//  Created by Maulana Hasbi on 11/8/17.
//  Copyright © 2017 SMK IDN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var instan: UILabel!
    @IBOutlet weak var alamat: UILabel!
    @IBOutlet weak var jam: UILabel!
    @IBOutlet weak var don: UILabel!
    
    var Instan: String?
    var Alamat: String?
    var Jam: String?
    var Don: String?
    
    override func viewDidLoad() {
        instan.text = "Instansi:" + Instan!
        alamat.text = "Alamat:" + Alamat!
        jam.text = "Jam:" + Jam!
        don.text = "Rencana Donor:" + Don!
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

