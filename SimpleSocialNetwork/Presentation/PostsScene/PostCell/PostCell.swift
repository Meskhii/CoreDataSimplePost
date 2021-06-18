//
//  PostCell.swift
//  SimpleSocialNetwork
//
//  Created by Admin on 17.06.2021.
//

import UIKit

class PostCell: UITableViewCell {
    
    
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postDescription: UILabel!
    @IBOutlet weak var editButton: UIButton!
    
    private var postIndex = Int()
    weak var delegate: PostsViewControllerProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with post: [Post], and postIndex: Int, user: User) {
        
        self.postIndex = postIndex
        
        postTitleLabel.text = post[postIndex].title
        postDescription.text = post[postIndex].postDescription
        postImageView.image = post[postIndex].image?.uiImage
        
        if post[postIndex].user == user {
            editButton.isHidden = false
        } else {
            editButton.isHidden = true
        }
    }
    
    @IBAction func editTapped(_ sender: Any) {
        delegate?.editTapped(index: postIndex)
    }
}
