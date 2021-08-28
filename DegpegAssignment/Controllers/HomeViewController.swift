//
//  HomeViewController.swift
//  DegpegAssignment
//
//  Created by Suraj Singh on 13/08/21.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let imageUrlArray = ["https://picsum.photos/150/150", "https://picsum.photos/160/160", "https://picsum.photos/170/170", "https://picsum.photos/180/180", "https://picsum.photos/190/190", "https://picsum.photos/200/200", "https://picsum.photos/205/205", "https://picsum.photos/206/206","https://picsum.photos/207/207","https://picsum.photos/208/208","https://picsum.photos/209/209","https://picsum.photos/210/210","https://picsum.photos/211/211","https://picsum.photos/212/212","https://picsum.photos/207/207"]
    
    let videoUrlArray = ["https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8", "https://bitdash-a.akamaihd.net/content/MI201109210084_1/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8","http://qthttp.apple.com.edgesuite.net/1010qwoeiuryfg/sl.m3u8","https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8", "https://bitdash-a.akamaihd.net/content/MI201109210084_1/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8","http://qthttp.apple.com.edgesuite.net/1010qwoeiuryfg/sl.m3u8","https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8", "https://bitdash-a.akamaihd.net/content/MI201109210084_1/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8","http://qthttp.apple.com.edgesuite.net/1010qwoeiuryfg/sl.m3u8","https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8", "https://bitdash-a.akamaihd.net/content/MI201109210084_1/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8","http://qthttp.apple.com.edgesuite.net/1010qwoeiuryfg/sl.m3u8","https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8", "https://bitdash-a.akamaihd.net/content/MI201109210084_1/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8","http://qthttp.apple.com.edgesuite.net/1010qwoeiuryfg/sl.m3u8"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
                
        // Force the device in portrait mode when the view controller gets loaded
        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Force the device in portrait mode when the view controller gets loaded
        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
    }
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageUrlArray.count
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        cell.imageView.downloaded(from: self.imageUrlArray[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.view.frame.size.width - 15 * 3) / 3
        return CGSize(width: width, height: width)
    }
    
    // MARK: - UICollectionViewDelegate protocol
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        
        self.openPlayerPage(self.videoUrlArray[indexPath.item])
        
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        // Force the device in portrait mode when the view controller gets loaded
        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
    }
    
    //Summery//
    //Player page function to open Player page Screen//
    //Video player screen//
    func openPlayerPage(_ url:String){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let destination = self.storyboard?.instantiateViewController(identifier: "PlayerViewController") as! PlayerViewController
        destination.modalPresentationStyle = .fullScreen
        destination.urlM3u8 = URL(string: url)
        self.present(destination, animated: false, completion: nil)
    }
    
    //Summery//
    //Logout from The Degpeg Application//
    //Open Login anf Singup Screen//
    //Remove userdefaults value from the local database//
    @IBAction func logoutButtonFunc(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "LoggedIn")
        defaults.synchronize()
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let destination = self.storyboard?.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
        destination.modalPresentationStyle = .fullScreen
        self.present(destination, animated: false, completion: nil)
    }
    
}
