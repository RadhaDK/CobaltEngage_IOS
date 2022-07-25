
import UIKit


public struct ButtonStyles {
  var backgroundColor: UIColor = UIColor.white
    var tintColor: UIColor = APPColor.MainColours.primary2
    var titleFont: UIFont = SFont.SourceSansPro_Regular16!
  var percentCornerRadius: CGFloat = 1
  var margin: CGFloat = 10
  
  public static let deselect = ButtonStyles()
    public static let select = ButtonStyles(backgroundColor: APPColor.MainColours.primary2,tintColor: APPColor.navigationColor.tintBGColor )
  public static let action = ButtonStyles(backgroundColor: APPColor.loginBackgroundButtonColor.loginfgColor)
  
  public init(backgroundColor: UIColor, tintColor: UIColor, titleFont: UIFont, percentCornerRadius: CGFloat, margin: CGFloat) {
    self.init(backgroundColor: backgroundColor, tintColor: tintColor)
    self.titleFont = titleFont
    self.percentCornerRadius = percentCornerRadius
    self.margin = margin
  }
  
  
    
    
    
  public init(backgroundColor: UIColor, tintColor: UIColor) {
    self.init(backgroundColor: backgroundColor)
    self.tintColor = tintColor
  }
  
  public init(backgroundColor: UIColor) {
    self.backgroundColor = backgroundColor
  }
  
  public init() {}
  
  
}

//MARK: Equatable
extension ButtonStyles: Equatable {
  public static func ==(lhs: ButtonStyles, rhs: ButtonStyles) -> Bool {
    return lhs.hashValue == rhs.hashValue
  }
  
}

//MARK: Hashable
extension ButtonStyles: Hashable {
  public var hashValue: Int {
    return backgroundColor.hashValue ^ tintColor.hashValue ^ titleFont.hashValue ^ percentCornerRadius.hashValue ^ margin.hashValue
  }
  
}
