//
//  BookTableViewCell.swift
//  CarrotSearchBook
//
//  Created by 김윤석 on 2023/11/11.
//

import UIKit

final class BookTableViewCell: UITableViewCell {
    static let identifier = String(describing: BookTableViewCell.self)
    
    private lazy var bookImageView: UIImageView = {
        let uv = UIImageView()
        uv.backgroundColor = .red
        uv.widthAnchor.constraint(equalToConstant: 60).isActive = true
        uv.heightAnchor.constraint(equalToConstant: 60).isActive = true
        return uv
    }()
    private lazy var titleLabel: UILabel = {
        let lb = UILabel()
        lb.font = .boldSystemFont(ofSize: 12)
        lb.minimumScaleFactor = 0.5
        lb.numberOfLines = 2
        return lb
    }()
    private lazy var subtitleLabel: UILabel = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 8)
        lb.minimumScaleFactor = 0.5
        lb.numberOfLines = 0
        return lb
    }()
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .gray
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BookTableViewCell {
    func configure(with book: Book) {
        bookImageView.downloaded(from: book.image, contentMode: .scaleToFill)
        titleLabel.text = book.title
        subtitleLabel.text = book.subtitle
        priceLabel.text = book.price
    }
}

extension BookTableViewCell {
    private func setupUI() {
        let titlesStackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        titlesStackView.axis = .vertical
        titlesStackView.alignment = .leading
        titlesStackView.distribution = .fillProportionally
        
        let imageTitlesStackView = UIStackView(arrangedSubviews: [bookImageView, titlesStackView])
        imageTitlesStackView.axis = .horizontal
        imageTitlesStackView.alignment = .fill
        imageTitlesStackView.distribution = .fill
        imageTitlesStackView.spacing = 8
        
        let totalStackView = UIStackView(arrangedSubviews: [imageTitlesStackView, priceLabel])
        totalStackView.axis = .horizontal
        totalStackView.alignment = .center
        totalStackView.distribution = .fill
        totalStackView.spacing = 8
        
        [totalStackView].forEach { uv in
            addSubview(uv)
            uv.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            totalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            totalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            totalStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            totalStackView.topAnchor.constraint(equalTo: topAnchor)
        ])
    }
}
