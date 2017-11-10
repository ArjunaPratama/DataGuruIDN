//
//  ViewController.swift
//  Data_Guru_IDN
//
//  Created by Jun  on 11/10/17.
//  Copyright © 2017 Arjuna. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    
    
    @IBOutlet weak var umur: UILabel!
    @IBOutlet weak var mata: UILabel!
    @IBOutlet weak var asal: UILabel!
    @IBOutlet weak var tgl: UILabel!
    @IBOutlet weak var nis_guru: UILabel!
    @IBOutlet weak var nama_guru: UILabel!
    var passnama:String?
    var passmapel:String?
    var passasal:String?
    var passtgl:String?
    var passnis:String?
    var passumur:String?
    
    override func viewDidLoad() {
        
        umur.text = passumur
        mata.text = passmapel
        asal.text = passasal
        tgl.text = passtgl
        nis_guru.text = passnis
        nama_guru.text = passnama
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        umur.text = passumur
        mata.text = passmapel
        asal.text = passasal
        tgl.text = passtgl
        nis_guru.text = passnis
        nama_guru.text = passnama
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

