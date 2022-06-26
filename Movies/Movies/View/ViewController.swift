//
//  ViewController.swift
//  Movies
//
//  Created by Adem Tarhan on 25.06.2022.
//

import UIKit

protocol ViewControllerImpl: AnyObject {
    var apiCall: APICallImpl? { get }
    // var movie: Movie? {get}
}

class ViewController: UIViewController, APICallable {
    var apiCall: APICallImpl?
    var movies: [Result] = []

    @IBOutlet var labelMovieTitle: UILabel!
    @IBOutlet var cellview: UIView!
    @IBOutlet var cellView: CellView!
    @IBOutlet var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
    }

    func setData() {
        labelMovieTitle.text = "movie"
        print("set data")
        // ..url
        let url = URL(string: "\(BaseURL)\(APIKey)")!
        print(url)

        APICall().getTask(with: url) { movies in

            self.movies = movies
            print("--42View")
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    func navigation() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondCV = storyboard.instantiateViewController(withIdentifier: "DetailViewController")
        secondCV.modalPresentationStyle = .fullScreen
        present(secondCV, animated: true, completion: nil)
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellView", for: indexPath) as! CellView
        let movie = movies[indexPath.row]
        cell.setup(movie)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // ..
        return movies.count
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width - 30) / 2, height: view.frame.height / 3)
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // ..
        let detail = DetailViewController()
        let movie = movies[indexPath.row]
    }
}
