//
//  GuruTableViewController.swift
//  Data_Guru_IDN
//
//  Created by Jun  on 11/10/17.
//  Copyright © 2017 Arjuna. All rights reserved.
//

import UIKit

class GuruTableViewController: UITableViewController {
    
    var nisSelected:String?
    var namaSelected:String?
    var tanggalSelected:String?
    var asalSelected:String?
    var mapelSeleted:String?
    var umurSelected:String?
    
    let GuruURL = "http://localhost/Guruidn/index.php/api/getAllGuru"
    var guruu = [Guru]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //membuat
        getGuru()
        //mengatur tinggi row table menjadi 92
        tableView.estimatedRowHeight = 92.0
        //mengatur tinggi row table menjadi dimensi otomatis
        tableView.rowHeight = UITableViewAutomaticDimension
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
        return guruu.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GuruTableViewCell

        //memasukan nilainya kedalam masing 2 label
        cell.nisdesc.text = guruu[indexPath.row].nis_guru
        cell.namaadesc.text = guruu[indexPath.row].nama_guru
        // Configure the cell...

        let data = guruu[indexPath.row]
        return cell
    }
    // MARK: - JSON PArsing
    // membuat method baru dengan nama: getLstestLoans()
    func getGuru() {
        
        //deklarsi LoanUrl untuk memanggil variable kivaLoanURL yang telah dideklarasikan sebelumnya
        guard let GuruUrl = URL(string: GuruURL) else {
            return //return ini memiliki ffungsi untuk mengembalikan nilai yang sudah di dapat ketika memanggil variable loanUrl
        }
        
        //delarasi request untuk request URL loanUrl
        let request = URLRequest(url: GuruUrl)
        //deklarasi task untuk mengambil data dari variable request diatas
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            
            //mengecek apakah ada error apa tidak
            if let error = error {
                //kondisi ketika ada error
                //mencetak error
                print(error)
                return //mengambil nilai error yang didapat
            }
            //parse JSON data
            //deklarasi variable data untuk mengambil data
            if let data = data {
                //pada bagian ini akan memanggil method parseJsonData yang akan kita buat di bawah
                self.guruu = self.parseJsonData(data: data)
                
                //Reload TAble view
                OperationQueue.main.addOperation ({
                    //reload Data kembali
                    self.tableView.reloadData()
                })
            }
            
        })
        //task akan melakukan resume untuk memanggil data json nya
        task.resume()
    }
    //membuat method baru dengan nama ParseJsonData
    //method ini akan melakukan parsing data Json
    func parseJsonData(data: Data) -> [Guru] {
        //deklarasi variable loans sebagai obejct dari kelas Loan
        var guru = [Guru]()
        //akan melakukan perulangan terhadap data json yang di parsing
        do{
            //deklarasikan jsonResult untuk mengambil data jsonnya
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as?
            NSDictionary
            
            //Parse JSON data
            //deklarasi jsonLoans untuk memanggil data array jsonResults yang bernama Loans
            let jsonLoans = jsonResult?["data"] as! [AnyObject]
            //akan melakukan pemanggilan data berulang2 selama jsonLoan memiliki data json array dari variable jsonLoans
            for jsonLoan in jsonLoans{
                //deklarasi loan sebagai objek dari class Loan
                let loan = Guru()
                
                loan.nis_guru = jsonLoan["nis_guru"] as! String
                loan.nama_guru = jsonLoan["nama_guru"] as! String
                loan.tgl_lahir = jsonLoan["tgl_lahir"] as! String
                loan.asal_guru = jsonLoan["asal_guru"] as! String
                loan.mapel_guru = jsonLoan["mata_pelajaran"] as! String
                loan.umur_guru = jsonLoan["umur"] as! String
                
                guru.append(loan)
            }
        }catch{
            print(error)
        }
        return guru
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        //mengecek data yang dikirim
        print("Row \(indexPath.row)selected")
        
        let task = guruu[indexPath.row]
        
        //memasukan data ke variable namaSelected dan image selected ke masing masing variable nya
        nisSelected = task.nis_guru
        namaSelected = task.nama_guru
        tanggalSelected = task.tgl_lahir
        asalSelected = task.asal_guru
        mapelSeleted = task.mapel_guru
        umurSelected = task.umur_guru
        
        
        //memamnggil segue passDataDetail
        performSegue(withIdentifier: "segue", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //mengecek apakah segue nya ada atau  tidak
        if segue.identifier == "segue"{
            //kondisi ketika segue nya ada
            //mengirimkan data ke detailViewController
            let kirimData = segue.destination as! ViewController
            //mengirimkan data ke masing2 variable
            //mengirimkan nama wisata
            kirimData.passnama = namaSelected
            kirimData.passnis = nisSelected
            kirimData.passasal = asalSelected
            kirimData.passtgl = tanggalSelected
            kirimData.passmapel = mapelSeleted
            kirimData.passumur = umurSelected
            
            
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
