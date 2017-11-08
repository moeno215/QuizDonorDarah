//
//  donTableViewController.swift
//  QuizDonorDarah
//
//  Created by Maulana Hasbi on 11/8/17.
//  Copyright © 2017 SMK IDN. All rights reserved.
//

import UIKit

class donTableViewController: UITableViewController {

    var instanSelected:String?
    var alamatSelected:String?
    var jamSelected:String?
    var donSelected:String?
    
    let kivaLoanURL = "https://script.googleusercontent.com/macros/echo?user_content_key=J9tohYhExTWARm7kbeVcibnfLpV5eH7HnVyVMJovBskbQkAF7XKFChV-5F8fSJQPaAdywPKi5h2wgSrBHxvmrXiriw76lS3xOJmA1Yb3SEsKFZqtv3DaNYcMrmhZHmUMWojr9NvTBuB6lHT6qnqYcmFWggwoSVQQXTsQ1HqKa1CgDXQROm1OeNR5ibYVAaRxAeOtzLmbRZcVjrce7Uveb8iU1s-L39A_CLDTUaq6azCNVhRMhi1rsPEMUK-CH6pys1RvMr_dgaGkoVsMt9XllB7kFByHUCzY&lib=M-tpZm-Fm1QX9Yr80nZn_p-WXe3zpGnIr"
    
    var loans = [Loans]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        getLatestLoans()
        
        //self sizing cells
        //mengatur tinggi row table menjadi 92
        tableView.estimatedRowHeight = 92.0
        //mengatur tinggi row Table menjadi dimensi otomatis
        tableView.rowHeight = UITableViewAutomaticDimension
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return loans.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! donTableViewCell

        // Configure the cell...
        cell.instansi.text = loans[indexPath.row].Instansi
        cell.alamat.text = loans[indexPath.row].Alamat
        cell.jam.text = loans[indexPath.row].Jam
        cell.donor.text = loans[indexPath.row].Rencana

        return cell
    }
    
    func getLatestLoans() {
        guard let loanUrl = URL(string: kivaLoanURL) else {
            return
        }
        let request = URLRequest(url: loanUrl)
         let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            if let error = error {
                //kondisi ketika ada error
                //mencetak error
                print(error)
    }
            if let data = data {
                //pada bagian ini kita akan memanggil method parseJsonData yang akan kita buat dibawah
                self.loans = self.parseJsonData(data: data)
                
                //reload tableView
                OperationQueue.main.addOperation ({
                    //reloadData kembali
                    self.tableView.reloadData()
                })
            }
         })
        //task akan melakukan resume untuk memanggil data json nya
        task.resume()
    }
    
    func parseJsonData(data: Data) -> [Loans] {
        //deklarasi variable loans sebagai objek dari class Loan
        var loans = [Loans]()
        //akan melakukkan perulangan terhadap data json yang d parsing
        do {
            //deklarasi jsonResult untuk mengambil data dari jsonnya
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
            
            //parse JSON data
            //deklarasi jsonLoans untuk memanggil data array jsonResult yang bernama Loans
            
            let jsonLoans = jsonResult?["data"] as! [AnyObject]
            for jsonLoan in jsonLoans {
                //deklarasi loan sebagai objek dari class Loan
                let loan = Loans()
                //memasukkan nilai kedalam masing2 objek dari class Loan
                //memasukkan nilai jsonLoan dengan nama object sebagai String
                //                loan.ranks = jsonLoans["rank"] as!
                
                loan.Instansi = jsonLoan["instansi"] as! String
                //memasukkan nilai jsonLoan dengan nama objek loan_amount sebagai integer
                loan.Alamat = jsonLoan["alamat"] as! String
                //memasukkan nilai jsonLoan dengan nama object use sebagai String
                loan.Jam = jsonLoan["jam"] as! String
                //memasukkan nilai jsonLoan dengan nama object location sebagai String
                loan.Rencana = jsonLoan["rencana_donor"] as! String
            }
        }catch{
            print(error)
        }
        return loans
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        //mengecek data yang dikirim
        print("Row \(indexPath.row)selected")
        
        let dataTask = loans[indexPath.row]
        instanSelected = dataTask.Instansi
        alamatSelected = dataTask.Alamat
        jamSelected = dataTask.Jam
        donSelected = dataTask.Rencana
      
        performSegue(withIdentifier: "cellData", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //mengecek apakah segue nya ada atau  tidak
        if segue.identifier == "cellData"{
            //kondisi ketika segue nya ada
            //mengirimkan data ke detailViewController
            let kirimData = segue.destination as! ViewController
            
            kirimData.Instan = instanSelected
            kirimData.Alamat = alamatSelected
            kirimData.Jam =  jamSelected
            kirimData.Don = donSelected
        }
    }
                /*
                 
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
