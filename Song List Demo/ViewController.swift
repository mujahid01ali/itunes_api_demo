//
//  ViewController.swift
//  Song List Demo
//
//  Created by Mujahid on 09/09/20.
//  Copyright © 2020 Mujahid. All rights reserved.
//

import UIKit

class ViewController: BaseVC,SongListCellDelegate {

    
    @IBOutlet weak var tfArtistName: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var songData = SongListModel()
    var songList = [Result]()
    var rowInfo = [ViewTypeModel]()
    var baseUrl = "https://itunes.apple.com/search"
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func onClick(id:Int) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
        vc.result = songList[id]
        navigationController?.pushViewController(vc, animated: true)
    }
    func setupTable() {
        tableView.register(UINib(nibName: "SongListCell", bundle: nil), forCellReuseIdentifier: "SongListCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    @IBAction func onClickSearch(_ sender: Any) {
        guard let text = tfArtistName.text,text.count > 0 else {
            showToast(message: "Enter artist name here!")
            return
        }
        getData(text: text)
    }
    func getData(text:String) {
        DispatchQueue.global().async {
            self.apiCall(url: self.baseUrl, param: ["term":text], className: SongListModel.self)
        }
        
    }
    override func onSuccessResponse(response: Any) {
        songData = SongListModel()
        songData = response as! SongListModel
        if let result = songData.results,result.count > 0{
            songList = result
        }else{
            showToast(message: "No Song Found!")
        }
        
        setDataToTableView()
        
    }
    override func onFailResponse(response: Error) {
        showToast(message: response.localizedDescription)
    }
    func setDataToTableView() {
        rowInfo = [ViewTypeModel]()
        for item in songList{
            rowInfo.append(ViewTypeModel(type: "SongListCell", model: item))
        }
        DispatchQueue.main.async {
            self.setupTable()
        }
        
    }


}
extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowInfo.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let info = rowInfo[indexPath.row]
        switch info.type {
        case "SongListCell":
            let cell = tableView.dequeueReusableCell(withIdentifier: "SongListCell", for: indexPath) as! SongListCell
            cell.delegate = self
            cell.setData(res: songList[indexPath.row],index:indexPath.row)
            
            return cell
        default:
            return UITableViewCell()
        }
    }
}


