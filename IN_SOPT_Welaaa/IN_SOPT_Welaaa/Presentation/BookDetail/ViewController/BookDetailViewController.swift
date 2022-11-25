//
//  BookDetailViewController.swift
//  IN_SOPT_Welaaa
//
//  Created by 류희재 on 2022/11/20.
//

import UIKit

final class BookDetailViewController: BaseViewController {
    
    private lazy var bookDetailView = BookDetailView()
    
    override func loadView() {
        self.view = bookDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableView()
        bookDetailView.bookIntroductionView.backButton.addTarget(self, action: #selector(touchupBackButton), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        self.getBookDetail()
    }
    
    @objc
    private func touchupBackButton() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension BookDetailViewController {
    private func registerTableView() {
        
        bookDetailView.bookDetailTableView.delegate = self
        bookDetailView.bookDetailTableView.dataSource = self
        
        bookDetailView.bookDetailTableView.register(SeriesTableViewCell.self, forCellReuseIdentifier: SeriesTableViewCell.identifier)
        
        bookDetailView.bookDetailTableView.register(BookImageTableViewCell.self, forCellReuseIdentifier: BookImageTableViewCell.identifier)
        
        bookDetailView.bookDetailTableView.register(BookInformationView.self, forCellReuseIdentifier: BookInformationView.identifier)
        
        bookDetailView.bookDetailTableView.register(RelatedKeywordTableViewCell.self, forCellReuseIdentifier: RelatedKeywordTableViewCell.identifier)
        
        bookDetailView.bookDetailTableView.register(DetailedInformationView.self, forCellReuseIdentifier: DetailedInformationView.identifier)
        
        bookDetailView.bookDetailTableView.register(RecommandContentTableViewCell.self, forCellReuseIdentifier: RecommandContentTableViewCell.identifier)
    }
}

extension BookDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
            return 245
        case 1:
            return 258
        case 2:
            return 634
        case 3:
            return 146
        case 4:
            return 181
        case 5:
            return 385
        default:
            return 0
        }
    }
}


extension BookDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SeriesTableViewCell.identifier, for: indexPath) as? SeriesTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BookImageTableViewCell.identifier, for: indexPath) as? BookImageTableViewCell else { return UITableViewCell()}
            cell.selectionStyle = .none
            return cell
            //
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BookInformationView.identifier, for: indexPath) as? BookInformationView else { return UITableViewCell()}
            cell.selectionStyle = .none
            return cell
            //
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RelatedKeywordTableViewCell.identifier, for: indexPath) as? RelatedKeywordTableViewCell else { return UITableViewCell()}
            cell.selectionStyle = .none
            return cell
            //
        case 4:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailedInformationView.identifier, for: indexPath) as? DetailedInformationView else { return UITableViewCell()}
            cell.selectionStyle = .none
            return cell
            
        case 5:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RecommandContentTableViewCell.identifier, for: indexPath) as? RecommandContentTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let headerView = BookDetailSectionView()
            headerView.setTitle(text: "[시리즈] 파친코")
            return headerView
        case 3:
            let headerView = BookDetailSectionView()
            headerView.setTitle(text: "관련 키워드")
            return headerView
        case 4:
            let headerView = BookDetailSectionView()
            headerView.setTitle(text: "상세 정보")
            return headerView
        case 5:
            let headerView = BookDetailSectionView()
            headerView.setTitle(text: "김나은이 좋아할 컨텐츠")
            return headerView
        default:
            return UIView()
        }
    }
}

extension BookDetailViewController {
    
    func getBookDetail() {
        
        BookAPI.shared.getBookDetail(bookId: 2) { response in
            print(333, response)
            
            switch response {
            case .success(let data):
                
                if let data = data as? [BookIDData] {
                    print(111, data)

                }
            case .requestErr(let message):
                print("requestErr", message)
            case .pathErr:
                print(".pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }

        }
    }
    
}

