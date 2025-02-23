import Foundation
import UIKit

// MARK: - TableView Data Source

extension MovieDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            if self.movieDetailViewModel.getMovieDetailCreditIsError {
                return 1
            } else {
                return self.movieDetailViewModel.getMovieCreditCount()
            }
        case 1:
            if self.movieDetailViewModel.getMovieDetailReviewIsError {
                return 1
            } else {
                return self.movieDetailViewModel.getMovieReviewCount()
            }
            
           default: return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return CellType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            if self.movieDetailViewModel.getMovieDetailCreditIsError,
               let cell = detailTableView.dequeueReusableCell(withIdentifier: "MovieCastErrorCell", for: indexPath) as? MovieCastErrorCell {
                cell.configWith(self.movieDetailViewModel.movieDetailCreditError)
                
                return cell
            } else if let cell = detailTableView.dequeueReusableCell(withIdentifier: "MovieCastCell", for: indexPath) as? MovieCastCell {
                cell.creditCellConfiguration(cast: self.movieDetailViewModel.getMovieCreditAt(indexPath.row))
                
                return cell
            }
        }
        else {
            if self.movieDetailViewModel.getMovieDetailReviewIsError,
               let cell = detailTableView.dequeueReusableCell(withIdentifier: "MovieCastErrorCell", for: indexPath) as? MovieCastErrorCell {
                cell.configWith(self.movieDetailViewModel.movieDetailReviewError)
                
                return cell
            } else if let cell = detailTableView.dequeueReusableCell(withIdentifier: "MovieReviewCell", for: indexPath) as? MovieReviewCell {
                cell.reviewCellConfiguration(review: self.movieDetailViewModel.getMovieReviewAt(indexPath.row))
                return cell
            }
        }
        
        return UITableViewCell()
    }
}

// MARK: - TableView Delegate

extension MovieDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.getTitleForHeader(section).0
    }
    
    func getTitleForHeader(_ section: Int) -> (String?, String?) {
        switch section {
           case 0: return ("Cast and Crew", "person-cast")
        case 1: return ("Reviews (\(self.movieDetailViewModel.getMovieReviewCount()))" , "Rreviews")
           default: return ("", "")
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let sectionHeaderLabelView = UIView()
            sectionHeaderLabelView.backgroundColor = .lightGray

            let sectionHeaderImage = UIImage(named: self.getTitleForHeader(section).1 ?? "")
            let sectionHeaderImageView = UIImageView(image: sectionHeaderImage)
            sectionHeaderImageView.frame = CGRect(x: 13, y: 10, width: 30, height: 30)
            sectionHeaderLabelView.addSubview(sectionHeaderImageView)

            let sectionHeaderLabel = UILabel()
            sectionHeaderLabel.text = getTitleForHeader(section).0
            sectionHeaderLabel.textColor = .white
            sectionHeaderLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
            sectionHeaderLabel.frame = CGRect(x: 56, y: 5, width: 250, height: 40)
            sectionHeaderLabelView.addSubview(sectionHeaderLabel)
            return sectionHeaderLabelView
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNonzeroMagnitude
    }
}
