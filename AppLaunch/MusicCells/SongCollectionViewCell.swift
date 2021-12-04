//
//  SongCollectionViewCell.swift
//  AppLaunch
//
//  Created by nanonino on 02/12/21.
//

import UIKit

class SongCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var buttonMore: UIButton!
    @IBOutlet weak var buttonAdd: UIButton!
    @IBOutlet weak var labelAuthor: UILabel!
    @IBOutlet weak var labelSong: UILabel!
    @IBOutlet weak var imageSong: UIImageView!
    
    var dicSongs = [:] as Dictionary<String,AnyObject>
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageSong.layer.cornerRadius = 5
        imageSong.clipsToBounds = true
        
        labelSong.text = dicSongs["title"] as? String
        labelAuthor.text = dicSongs["author"] as? String
        imageSong.sd_setImage(with:URL(string:dicSongs["image"] as? String ?? "") , placeholderImage:UIImage(named: ""))
       
    }

}
