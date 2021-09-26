//
//  .swift
//  Lesson3
//
//  Created by Владимир Рузавин on 9/21/21.
//

import UIKit

class CVViewController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private let layout = CollectionViewCustomLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureCollectionView()
    }
    
    private func configureCollectionView() {
        self.collectionView.collectionViewLayout = self.layout
    }
}

extension CVViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
}




