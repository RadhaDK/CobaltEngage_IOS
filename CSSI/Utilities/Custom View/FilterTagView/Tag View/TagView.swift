
import UIKit

@IBDesignable
public class TagView: UIView {
  public var top: CGFloat = 10.0
  public var leading: CGFloat = 10.0
  public var trailing: CGFloat = 10.0
  public var buttom: CGFloat = 10.0
  public var ySpacing: CGFloat = 10.0
  public var xSpacing: CGFloat = 10.0
  public var tagStyles: [ButtonStyles] = [.select, .deselect]
  public var selectedTagTitles: [String] {
    return tagButtons
      .filter { $0.style! == tagStyles[0] }
      .map { $0.titleLabel?.text ?? "No title" }
  }
  private var editTagButton: (TagButton?, top: Bool) = (nil, false) {
    didSet {
      guard let tagButton = oldValue.0 else { return }
      tagButton.removeFromSuperview()
    }
  }
  private lazy var heighConstraint: NSLayoutConstraint = {
    let constraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100)
    constraint.isActive = true
    return constraint }()
  private var tagButtons = [TagButton]() {
    didSet { oldValue.forEach { $0.removeFromSuperview() } }
  }
  
  @objc private func actionSelectTag(_ sender: TagButton) {
    sender.style = sender.style == tagStyles[0] ? tagStyles[1] : tagStyles[0]
  }
  
  
  private func createButtonWithTitle(_ title: String, style: ButtonStyles, target: Any?, action: Selector?) -> TagButton {
    let button = TagButton(title: title, style: style)
    addSubview(button)
    if let action = action {
      button.addTarget(target, action: action, for: .touchUpInside)
    }
    return button
  }
  
  public func createCloudTagsWithTitles(_ titles: [String], target: Any? = nil, action: Selector? = nil) {
    tagButtons = titles.map { createButtonWithTitle($0, style: .select, target: target, action: action) }
    layoutIfNeeded()
  }
  
  public func createCloudTagsWithTitles(_ titles: [(String, Bool)]) {
    tagButtons = titles.map { createButtonWithTitle($0.0,
                                                    style: $0.1 ? tagStyles[0] : tagStyles[1],
                                                    target: self, action: #selector(actionSelectTag)) }
    layoutIfNeeded()
  }
  
  public func addEditButton(title: String, style: ButtonStyles = .action, top: Bool = false, target: Any?, action: Selector?) {
    editTagButton = (createButtonWithTitle(title, style: style, target: target, action: action), top)
  }
  
  // MARK: - Layout tabButtons
  
  public override func layoutSubviews() {
    super.layoutSubviews()
    arrangeTagButton()
  }
  
  private func arrangeTagButton() {
    let maxViewWidth = self.frame.width
    var offset = CGPoint(x: leading, y: top)
    var heightTag: CGFloat = 0
    if let button = editTagButton.0, editTagButton.top {
      layoutButton(button, maxViewWidth, &heightTag, &offset)
    }
    tagButtons.forEach { layoutButton($0, maxViewWidth, &heightTag, &offset) }
    if let button = editTagButton.0, !editTagButton.top {
      layoutButton(button, maxViewWidth, &heightTag, &offset)
    }
    heighConstraint.constant =  offset.y + heightTag + buttom
  }
  
  private func layoutButton(_ button: TagButton, _ maxViewWidth: CGFloat, _ heightTag: inout CGFloat, _ offset: inout CGPoint) {
    heightTag = button.frame.height
    let widthTagButton = button.frame.width
    if (offset.x + widthTagButton + trailing) > maxViewWidth {
      offset.x = leading
      offset.y += heightTag + ySpacing
    }
    button.frame.origin = offset
    offset.x += widthTagButton + xSpacing
  }
  
  
}


// MARK: - Interface Builder
extension TagView {
  public override func prepareForInterfaceBuilder() {
    createCloudTagsWithTitles([("Welcome",false), ("to",false), ("TagView",true)])
  }
  
  
}

