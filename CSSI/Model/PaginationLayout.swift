
import UIKit

class PaginationLayout: UICollectionViewFlowLayout {

    override func awakeFromNib() {
        self.itemSize = CGSize.init(width: UIScreen.main.bounds.width * 0.92, height: self.collectionView!.frame.height)
        self.minimumInteritemSpacing = 0
        self.minimumLineSpacing = 0
        self.scrollDirection = UICollectionView.ScrollDirection.horizontal
        self.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    private func pageWidth() -> CGFloat
    {
        return self.itemSize.width + self.minimumLineSpacing
    }
    
    private func flickVelocity() -> CGFloat
    {
        return 0.8
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint
    {
        var proposedOffset = proposedContentOffset
        let rawPageValue : CGFloat = self.collectionView!.contentOffset.x / self.pageWidth()
        let currentPage = (velocity.x > 0.0) ? floor(rawPageValue) : ceil(rawPageValue)
        let nextPage = (velocity.x > 0.0) ? ceil(rawPageValue) : floor(rawPageValue)
        
        let pannedLessThanAPage = abs(1 + currentPage - rawPageValue) > 0.35
        let flicked = abs(velocity.x) > self.flickVelocity()
        
        if pannedLessThanAPage && flicked
        {
            proposedOffset.x = nextPage * self.pageWidth()
        }
        else
        {
            proposedOffset.x = round(rawPageValue) * self.pageWidth()
        }
        return proposedOffset
    }
}
