//
//  MovieDetailViewController.swift
//  Movies
//
//  Created by Abdul Qadar on 20/12/2024.
//

import UIKit
import SDWebImage

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var backdropImage: UIImageView!
    @IBOutlet weak var genreTableView: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tagLine: UILabel!
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genreTableViewHeight: NSLayoutConstraint!

    var viewModel: MovieDetailViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    // MARK: - Custom Functions

    func setupUI() {
        navigationItem.title = "Movie Detail"
        // Set images using a helper function
        setImage(for: posterImage, urlString: viewModel.posterImageURL)
        setImage(for: backdropImage, urlString: viewModel.backdropImageURL)
        // Set text fields
        titleLabel.text = viewModel.title
        tagLine.text = viewModel.tagline
        overview.text = viewModel.overview
    }

    func getInstance(model:MovieDetails) -> MovieDetailViewController {
        let vc = MovieDetailViewController()
        vc.viewModel = MovieDetailViewModel()
        vc.viewModel.movieDetails = model
        return vc
    }

    private func setImage(for imageView: UIImageView, urlString: String) {
        if let imageUrl = URL(string: urlString) {
            imageView.sd_setImage(with: imageUrl, completed: nil)
        } else {
            imageView.image = UIImage(named: "movieIcon")
        }
    }

    private func configureTableView() {
        self.genreTableView.register((UINib(nibName: "GeneralLabelTableViewCell", bundle: nil)), forCellReuseIdentifier: "GeneralLabelTableViewCell")
        self.genreTableView.delegate = self
        self.genreTableView.dataSource = self
    }
}

extension MovieDetailViewController: UITableViewDelegate,UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        genreTableViewHeight.constant = CGFloat(viewModel.getGenres().count)*40
        return viewModel.getGenres().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GeneralLabelTableViewCell.nibName, for: indexPath) as! GeneralLabelTableViewCell
        cell.configureCell( name: viewModel.getGenres()[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
}
