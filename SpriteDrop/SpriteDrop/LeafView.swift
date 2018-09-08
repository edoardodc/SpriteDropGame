import QuartzCore
import UIKit

public class LeafView: UIView {
    var emitter: CAEmitterLayer = CAEmitterLayer()
    public var intensity: Float!
    private var active: Bool!
    private var imageLeaf: UIImage?
    public var direction: LeafDirection = .top
    var shapes = [#imageLiteral(resourceName: "EmptyOvalFall"), #imageLiteral(resourceName: "FullOvalFall2"), #imageLiteral(resourceName: "EmptyTriangleFall2"), #imageLiteral(resourceName: "EmptySquareFall-1")]
    
    var birthRates = [1.4, 0.6, 1.2, 1.4, 1.5]
    var xs = [1, 2, 3, 4, 5]
    var x: CGFloat?
    
    public enum LeafDirection {
        case top
        case bottom
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupLeaf()
    }
    
    func setupLeaf() {
        intensity = 0.4
        active = false
        direction = .top
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLeaf()
    }
    

    
    public func startLeaf(duration: TimeInterval = 0) {
        guard let _ = imageLeaf else {
            return
        }
        let y = direction == .top ? 0 : frame.size.height

        x = frame.size.width / 2
            
        emitter.emitterPosition = CGPoint(x: x!, y: y)


        emitter.emitterShape = CAEmitterLayerEmitterShape.line
        emitter.emitterSize = CGSize(width: frame.size.width, height: 1)
        emitter.birthRate = Float(CGFloat(birthRates.randomElement()!))
        
        var cells = [CAEmitterCell]()

        for shape in shapes {
            cells.append(leafWithColor(shape: shape))
        }
        
        emitter.emitterCells = cells
        layer.addSublayer(emitter)
        
        active = true
        if duration != 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + duration, execute: {
                self.stopLeaf()
            })
        }
    }
    
    func leafWithColor(shape: UIImage) -> CAEmitterCell {
        let leaf = CAEmitterCell()
        leaf.birthRate = Float.random(in: 0 ..< 0.1)
        leaf.lifetime = 80
        leaf.scale = 1
        leaf.velocityRange = CGFloat(80.0 * intensity)
        leaf.velocity = CGFloat(360 * intensity)
        leaf.emissionLongitude = direction == .top ? CGFloat(Double.pi) : CGFloat(-10)
        

        leaf.contents = shape.cgImage
        
        leaf.emissionRange = CGFloat(Double.pi / 10)
        leaf.scaleRange = 0.5
        
        return leaf
    }
    
    public func isActive() -> Bool {
        return self.active
    }
    
    public func setImageForLeaf(imageLeaf: UIImage) {
        self.imageLeaf = imageLeaf
    }
    
    public func stopLeaf() {
        active = false
        emitter.birthRate = 0
    }
}
