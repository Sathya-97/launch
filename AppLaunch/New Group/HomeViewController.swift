//
//  HomeViewController.swift
//  AppLaunch
//
//  Created by nanonino on 01/12/21.
//

import UIKit
import SDWebImage

class HomeViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate,UITableViewDataSource {
   
    

    @IBOutlet weak var heightTableViewSongs: NSLayoutConstraint!
    @IBOutlet weak var tableViewSongs: UITableView!
    @IBOutlet weak var heightCollectionviewPreview: NSLayoutConstraint!
    @IBOutlet weak var collectionViewPreview: UICollectionView!
    @IBOutlet weak var collectionViewFavourites: UICollectionView!
    @IBOutlet weak var heightCollectionviewFav: NSLayoutConstraint!
    
    @IBOutlet weak var buttonSeeMore: UIButton!
    @IBOutlet weak var labelAlbumTitle: UILabel!
    
    @IBOutlet weak var viewPlayer: UIView!
    @IBOutlet weak var labelPlayerSong: UILabel!
    @IBOutlet weak var imageViewPlayer: UIImageView!
    @IBOutlet weak var labelPlayerAuthor: UILabel!
    @IBOutlet weak var buttonPlayPause: UIButton!
   
    let screenSize = UIScreen.main.bounds.size
    
    var arrayPreviewImages = [] as Array<Dictionary<String,AnyObject>>
    var arrayFav = [] as Array<Dictionary<String,AnyObject>>
    
 var arrayImages = ["https://m.media-amazon.com/images/I/51T74RXSgLS.UX358_FMwebp_QL85.jpg","https://m.media-amazon.com/images/I/4170UqBJ4zL.UX358_FMwebp_QL85.jpg","https://m.media-amazon.com/images/I/51T74RXSgLS.UX358_FMwebp_QL85.jpg",
    "https://m.media-amazon.com/images/I/51bcP8Ub9FL.UX358_FMwebp_QL85.jpg","https://m.media-amazon.com/images/I/41tD6B264iL.UX358_FMwebp_QL85.jpg","https://m.media-amazon.com/images/I/41kzaMdSBPL.UX358_FMwebp_QL85.jpg"]
    
    var arraySongs = [["title":"Endrum punnagai","author":"Srinivas","image":"https://m.media-amazon.com/images/I/51T74RXSgLS.UX358_FMwebp_QL85.jpg"],["title":"Marudhani","author":"D.Imman","image":"https://m.media-amazon.com/images/I/4170UqBJ4zL.UX358_FMwebp_QL85.jpg"],["title":"Thendral Vandhu","author":"Ilayaraja","image":"https://m.media-amazon.com/images/I/51T74RXSgLS.UX358_FMwebp_QL85.jpg"],["title":"Thaniye Thananthaniye","author":"ARR","image":"https://m.media-amazon.com/images/I/51T74RXSgLS.UX358_FMwebp_QL85.jpg"],["title":"Udhaya Udhaya","author":"ARR","image":"https://m.media-amazon.com/images/I/51bcP8Ub9FL.UX358_FMwebp_QL85.jpg"],["title":"Tum Tum Tum","author":"Thaman","image":"https://m.media-amazon.com/images/I/41kzaMdSBPL.UX358_FMwebp_QL85.jpg"],["title":"Endhan Nanbiye","author":"Aniruth Ravichander","image":""],["title":"Idhu varai","author":"Yuvan Shankar Raja","image":"https://m.media-amazon.com/images/I/41tD6B264iL.UX358_FMwebp_QL85.jpg"]] as Array<Dictionary<String,AnyObject>>
    
    var arrayAlbum = [["title":"Endrum punnagai","author":"Srinivas","image":"https://m.media-amazon.com/images/I/51T74RXSgLS.UX358_FMwebp_QL85.jpg"],["title":"Marudhani","author":"D.Imman","image":"https://m.media-amazon.com/images/I/4170UqBJ4zL.UX358_FMwebp_QL85.jpg"],["title":"Thendral Vandhu","author":"Ilayaraja","image":"https://m.media-amazon.com/images/I/51T74RXSgLS.UX358_FMwebp_QL85.jpg"],["title":"Thaniye Thananthaniye","author":"ARR","image":"https://m.media-amazon.com/images/I/51T74RXSgLS.UX358_FMwebp_QL85.jpg"],["title":"Udhaya Udhaya","author":"ARR","image":"https://m.media-amazon.com/images/I/51bcP8Ub9FL.UX358_FMwebp_QL85.jpg"],["title":"Tum Tum Tum","author":"Thaman","image":"https://m.media-amazon.com/images/I/41kzaMdSBPL.UX358_FMwebp_QL85.jpg"],["title":"Endhan Nanbiye","author":"Aniruth Ravichander","image":""],["title":"Idhu varai","author":"Yuvan Shankar Raja","image":"https://m.media-amazon.com/images/I/41tD6B264iL.UX358_FMwebp_QL85.jpg"]] as Array<Dictionary<String,AnyObject>>
   
    override func viewDidLoad() {
        super.viewDidLoad()
        UINavigationBar.appearance().barTintColor = .black
        self.createUserImage()
        self.buttonSeeMore.layer.cornerRadius = 10
        self.buttonSeeMore.clipsToBounds = true
        self.labelAlbumTitle.text = "Favorites"
        self.viewPlayer.isHidden = true
        collectionViewFavourites.collectionViewLayout = createCompositionalLayout()
//        collectionViewFavourites.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        let nibSong = UINib(nibName: "SongCollectionViewCell", bundle: nil)
        collectionViewFavourites.register(nibSong, forCellWithReuseIdentifier: "song")
        
        let nibAlbum = UINib(nibName: "AlbumCollectionViewCell", bundle: nil)
        collectionViewFavourites.register(nibAlbum, forCellWithReuseIdentifier: "album")
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.heightCollectionviewFav.constant = self.collectionViewFavourites.contentSize.height + 30.0
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.updateTableViewHeight()
    }
        
    }
    
    
   //MARK:- CollectionView methods
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewPreview{
            if arrayImages.count > 0 {
                return arrayImages.count
            } else {
                return 1
            }
        }
        else if collectionView == self.collectionViewFavourites{
            return  arrayAlbum.count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionViewPreview{
            let cellperview = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            let imagePreview = cellperview.viewWithTag(1) as! UIImageView
            let dicImage = arrayImages[indexPath.item]
            imagePreview.sd_setImage(with:URL(string:dicImage) , placeholderImage:UIImage(named: "disk"))
            return cellperview
        } else if collectionView == self.collectionViewFavourites{
            
            if indexPath.section == 0{
                let cellalbum = collectionViewFavourites.dequeueReusableCell(withReuseIdentifier: "cellAlbum", for: indexPath)
                let imageAlbum = cellalbum.viewWithTag(1) as! UIImageView
                let labelTitle: UILabel = cellalbum.viewWithTag(2) as! UILabel
                let labelAuthor:UILabel = cellalbum.viewWithTag(3) as! UILabel
                
                let dic =  arrayAlbum[indexPath.item]
                imageAlbum.layer.cornerRadius = imageAlbum.frame.size.width/2
                imageAlbum.clipsToBounds = true
                imageAlbum.sd_setImage(with:URL(string:dic["image"] as? String ?? "") , placeholderImage:UIImage(named: "disk"))
                labelTitle.text = dic["title"] as? String
                labelAuthor.text = dic["author"] as? String
                return cellalbum
            }
            
            
        }
        
        return UICollectionViewCell()
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.collectionViewPreview{
            return CGSize(width: screenSize.width , height: collectionViewPreview.frame.size.height)
        }
        if collectionView == collectionViewFavourites{
            if indexPath.section == 0{
                return CGSize(width: 150.0 , height: collectionViewFavourites.frame.size.height)
            }
        }
        return CGSize(width: screenSize.width , height: collectionViewPreview.frame.size.height)
        
    }
    
    
//    func collectionView(_ collectionView: UICollectionView,
//    viewForSupplementaryElementOfKind kind: String, at indexPath:
//    IndexPath) -> UICollectionReusableView {
//        let header =
//          collectionViewFavourites.dequeueReusableSupplementaryView(ofKind: kind,
//          withReuseIdentifier: "header", for: indexPath)
//
//
//        return header
//    }
//
    //MARK:- Tableview methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arraySongs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableViewSongs.dequeueReusableCell(withIdentifier: "cellSong", for: indexPath)
        let imageAlbum: UIImageView = cell.viewWithTag(1) as! UIImageView
        let labelTitle: UILabel = cell.viewWithTag(2) as! UILabel
        let labelAuthor:UILabel = cell.viewWithTag(3) as! UILabel
        let buttonMore:UIButton = cell.viewWithTag(4) as! UIButton
        let buttonAdd:UIButton = cell.viewWithTag(5) as! UIButton
        let dic = arraySongs[indexPath.row]
        
        imageAlbum.layer.cornerRadius = 5
        imageAlbum.clipsToBounds = true
        imageAlbum.contentMode = .scaleAspectFill
        
        
        
        imageAlbum.sd_setImage(with:URL(string:dic["image"] as? String ?? "") , placeholderImage:UIImage(named: "microphone"))
        labelTitle.text = dic["title"] as? String
        labelAuthor.text = dic["author"] as? String
        
        buttonAdd.addTarget(self, action: #selector(Addsongs(_:)), for: .touchUpInside)
        buttonMore.addTarget(self, action: #selector(moreOption(_:)), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dic = arraySongs[indexPath.item]
        self.viewPlayer.isHidden = false
        self.labelPlayerSong.text = dic["title"] as? String
        self.labelPlayerAuthor.text =  dic["author"] as? String
        self.imageViewPlayer.sd_setImage(with:URL(string:dic["image"] as? String ?? "") , placeholderImage:UIImage(named: "microphone"))
        
    }
    
    func updateTableViewHeight(){
        self.heightTableViewSongs.constant = self.tableViewSongs.contentSize.height + 120.0
    }
    
    //MARK:- Button Actions
    
    @objc func Addsongs(_ sender: UIButton){
        let buttonPosition = sender.convert(CGPoint.zero, to: self.tableViewSongs)
        let indexPath = self.tableViewSongs.indexPathForRow(at: buttonPosition)
        let dicSong = arraySongs[indexPath!.item]
        print("Add song \(String(describing: dicSong["title"] as? String))")
    }
    
    @objc func moreOption(_ sender: UIButton){
        let buttonPosition = sender.convert(CGPoint.zero, to: self.tableViewSongs)
        let dicCrew = [:] as [String:AnyObject]
        let indexPath = self.tableViewSongs.indexPathForRow(at: buttonPosition)
        let dicSong = arraySongs[indexPath!.item]
        print("More about the song \(dicSong["title"] as? String ?? "")")
    }
    

    @IBAction func buttonSeemore(_ sender: Any) {
    }
    
    @IBAction func buttonPlayPause(_ sender: Any) {
        buttonPlayPause.isSelected = !buttonPlayPause.isSelected
        if buttonPlayPause.isSelected{
            buttonPlayPause.setImage(UIImage(systemName: "pause"), for: .normal)
        } else{
            buttonPlayPause.setImage(UIImage(named: "chat_play"), for: .normal)
        }
    }
    
    
    @IBAction func buttonForward(_ sender: Any) {
        print("forward")
    }
    
    func playerViewAttributes(){
        self.imageViewPlayer.layer.cornerRadius = 5
        self.imageViewPlayer.clipsToBounds = true
        
    }
    
    func createUserImage(){
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = imageView.frame.size.width/2
        imageView.clipsToBounds = true
        imageView.sd_setImage(with: URL(string:"https://m.media-amazon.com/images/I/41tD6B264iL.UX358_FMwebp_QL85.jpg") , placeholderImage: nil)
        let barButton = UIBarButtonItem(customView: imageView)
       navigationItem.rightBarButtonItem = barButton
    }
}
