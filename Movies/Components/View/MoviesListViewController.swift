//
//  MoviesListViewController.swift
//  Movies
//
//  Created by Abdul Qadar on 20/12/2024.
//

import UIKit

class MoviesListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    //MARK: Properties
    let viewModel = MoviesListViewModel()
    private let headerHeight: CGFloat = 50.0
    private var headerView: UIView!
    private var headerHeightConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Configure the Table View
        configureTableView()
        // Configure the Header View
        configureHeaderView()
        // Fetch movies data
        viewModel.fetchPopularMovies() { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInsetAdjustmentBehavior = .never // Prevents extra insets
        tableView.contentInset = .zero
        tableView.register(UINib(nibName: "MovieDataTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieDataTableViewCell")
        tableView.tableFooterView = UIView() // Avoid empty cells
    }
    
    private func configureHeaderView() {
        // Create the header view
        headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: headerHeight))
        headerView.backgroundColor = .clear

        // Create the label for the header view
        let label = UILabel()
        label.text = "Popular Movies"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(label)

        // Set the constraints for the label inside the header view
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 15),
            label.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])

        // Add the header view to the main view
        view.addSubview(headerView)

        // Set constraints for headerView
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerHeightConstraint = headerView.heightAnchor.constraint(equalToConstant: headerHeight)
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor), // Directly below the safe area
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerHeightConstraint // Reference to height constraint
        ])
        
        // Adjust tableView to start directly below the header view
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor), // Table starts right below header
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    // Default scrolling function to handle the hiding and showing of headerView and Title.
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        let alpha = max(0, min(1, offset / headerHeight)) // Calculate alpha for animation
        // Animate header view fading and navigation title appearing
        navigationItem.title = alpha >= 1 ? "Popular Movies" : ""
        headerView.alpha = 1 - alpha
        // Adjust header view height based on scroll
        let newHeight = max(0, headerHeight - offset) // Make sure height doesn't go negative
        headerHeightConstraint.constant = newHeight // Update the height constraint
    }
}

extension MoviesListViewController: UITableViewDelegate,UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieDataTableViewCell.nibName, for: indexPath) as! MovieDataTableViewCell
        let movie = viewModel.getResult(ind: indexPath.row)
        cell.configureCell(
            name: movie.original_title ?? "",
            icon: movie.backdrop_path ?? "",
            lang: movie.original_language ?? "",
            rating: movie.vote_average ?? 0.0,
            releaseDate: movie.release_date ?? ""
        )
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieObj = viewModel.getResult(ind: indexPath.row)
        viewModel.fetchMovieDetail(id: movieObj.id ?? 0) {
            DispatchQueue.main.async  {
                [weak self] in
                guard let model = self?.viewModel.movieDetails else {return}
                let viewController = MovieDetailViewController().getInstance(model: model)
                self?.navigationController?.pushViewController(viewController, animated: true)
            }
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }

    /// TableView Section header with a bold title
/*
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .systemBackground
        let label = UILabel()
        label.text = "Popular Movies"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 15),
            label.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
*/
}
