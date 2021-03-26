import UIKit

struct Segment {
    
    let color: UIColor
    let value: CGFloat
    let name: String
    
    init(color: UIColor, value: CGFloat, name: String) {
        self.color = color
        self.value = value
        self.name = name
    }
    
}

extension Collection where Element : Numeric {
    func sum() -> Element {
        return reduce(0, +)
    }
}

extension CGRect {
    init(centeredOn center: CGPoint, size: CGSize) {
        self.init(origin: CGPoint(x: center.x - size.width * 0.5, y: center.y - size.height * 0.5), size: size)
    }

    var center: CGPoint {
        return CGPoint(x: origin.x + size.width * 0.5, y: origin.y + size.height * 0.5)
    }
}

extension CGPoint {
    func projected(by value: CGFloat, angle: CGFloat) -> CGPoint {
        return CGPoint(x: x + value * cos(angle), y: y + value * sin(angle))
    }
}

class PieChartView: UIView {

    var segments = [Segment]() {
        didSet {
            setNeedsDisplay()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        isOpaque = false
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func forEachSegment(_ body: (Segment, _ startAngle: CGFloat, _ endAngle: CGFloat) -> Void) {
        let valueCount = segments.lazy.map { $0.value }.sum()
        var startAngle: CGFloat = 0.0
        for segment in segments {
            let endAngle = startAngle + .pi * 2 * (segment.value / valueCount)
            defer {
                startAngle = endAngle
            }
            body(segment, startAngle, endAngle)
        }
    }

    override func draw(_ rect: CGRect) {
        
        guard let ctx = UIGraphicsGetCurrentContext() else { return }
        let radius = min(frame.size.width, frame.size.height) * 0.5
        let viewCenter = bounds.center
        
        forEachSegment { segment, startAngle, endAngle in
            ctx.setFillColor(segment.color.cgColor)
            ctx.move(to: viewCenter)
            ctx.addArc(center: viewCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
            ctx.fillPath()
            
            //escribe texto
            let halfAngle = startAngle + (endAngle - startAngle) * 0.5
            var segmentCenter = CGPoint(x: bounds.size.width * 0.44, y: bounds.size.height * 0.45)
            let textPositionOffset: CGFloat = 0.67
            if segments.count > 1 {
              segmentCenter = segmentCenter.projected(by: radius * textPositionOffset, angle: halfAngle)
            }
            let string = segment.name.isEmpty ? segment.value.description : segment.name
            string.draw(with: CGRect(origin: segmentCenter, size: CGSize(width: 40, height: 20)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13),
                             NSAttributedString.Key.foregroundColor: UIColor.black], context: nil)
        }
        
    }
}
