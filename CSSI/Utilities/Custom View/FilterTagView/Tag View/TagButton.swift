
import UIKit

public class TagButton: UIButton {
  
  var style: ButtonStyles? {
    didSet { oldValue != nil ? setStyle() : nil }
  }
  
  
  convenience init(title: String, style: ButtonStyles) {
    self.init(type: .system)
    self.style = style
    self.setTitle(title, for: .normal)
  }
  
  
  public override func setTitle(_ title: String?, for state: UIControlState) {
    super.setTitle(title, for: state)
    setStyle()
  }
  
  private func setStyle() {
    guard let style = style else { return }
    self.backgroundColor = style.backgroundColor
    self.tintColor = style.tintColor
    self.titleLabel?.font = style.titleFont
    self.sizeToFit()
    self.layer.borderColor = APPColor.MainColours.primary2.cgColor
    self.layer.borderWidth = 1.0
    self.frame.size.height = (self.titleLabel?.font.pointSize)! + style.margin 
    let radius = self.frame.height * 0.5 * style.percentCornerRadius
    self.layer.masksToBounds = true
    self.layer.cornerRadius = radius
    self.frame.size.width += radius + style.margin
  }
  
  
}

