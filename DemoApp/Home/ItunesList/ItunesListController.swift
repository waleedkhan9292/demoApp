//
//  ItunesListController.swift
//  DemoApp
//
//  Created by Macbook Pro on 30/04/2019.
//  Copyright © 2019 Waleed Waheed Khan. All rights reserved.
//

import UIKit
import SDWebImage

class ItunesListController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tvTableView: UITableView!

    private var musicList:[MusicList] = [MusicList]()
    var mediaType = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setViewDidLoad()
    }
    
    // MARK: - Button Actions
    @IBAction func btnBack(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Functions
    private func setViewDidLoad() {
        tvTableView.rowHeight = UITableView.automaticDimension;
        tvTableView.estimatedRowHeight = 44.0;
        getMusicList(subUrl: mediaType)
    }
    
    private func getMusicList(subUrl:String) {
        AppHandler.getMusicList(
            subUrl: "/us/\(subUrl)/all/10/explicit.json",
            view:self) {
                (status:Bool,currentList:[MusicList]) in
                if(status && currentList.count != 0) {
                    self.musicList = currentList
                    self.tvTableView.reloadData()
                }
        }
    }
    
    // MARK: - Table View Delegate
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ItunesListCell
        cell.lblSongName.text = musicList[indexPath.row].name
        cell.lblMediaType.text = musicList[indexPath.row].mediaType
        
        if let image = SDImageCache.shared().imageFromDiskCache(forKey: musicList[indexPath.row].pic?.absoluteString) {
            cell.ivDisplayImage.image = image
        }
        else {
            cell.ivDisplayImage.sd_setImage(with:musicList[indexPath.row].pic, placeholderImage: UIImage(named: placeHolderImage))
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicList.count;
    }
}
