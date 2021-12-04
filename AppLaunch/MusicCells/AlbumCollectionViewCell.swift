//
//  AlbumCollectionViewCell.swift
//  AppLaunch
//
//  Created by nanonino on 02/12/21.
//

import UIKit

class AlbumCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var labelAuthor: UILabel!
    @IBOutlet weak var labelSong: UILabel!
    @IBOutlet weak var imageViewAlbum: UIImageView!
    
    var dicAlbum = [:] as [String:AnyObject]
    var type:String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if dicAlbum["section"] as? String == "Album"{
            imageViewAlbum.layer.cornerRadius = imageViewAlbum.frame.size.width/2
            imageViewAlbum.clipsToBounds = true
        } else{
            imageViewAlbum.layer.cornerRadius = 10
            imageViewAlbum.clipsToBounds = true
        }
        imageViewAlbum.sd_setImage(with:URL(string:dicAlbum["image"] as? String ?? "") , placeholderImage:UIImage(named: ""))
        labelSong.text = dicAlbum["title"] as? String
        labelAuthor.text = dicAlbum["author"] as? String
    }

}
