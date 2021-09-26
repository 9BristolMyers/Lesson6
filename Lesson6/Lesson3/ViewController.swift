//
//  ViewController.swift
//  Lesson4
//
//  Created by Владимир Рузавин on 9/17/21.
//

import UIKit

/*class  TestView: UIView {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.fill(CGRect(x: 0, y: 0, width: 50, height: 50))
        context.setFillColor(UIColor.purple.cgColor)
        context.setStrokeColor(UIColor.black.cgColor)
        let testView = TestView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        testView.backgroundColor = .white
    }
}
}
@IBDesignable class TestView: UIView {
    
    @IBInspectable var radius: CGFloat = 10 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setFillColor(UIColor.red.cgColor)
        context.fillEllipse(in: CGRect(x: rect.midX - radius,
                                       y: rect.midY - radius,
                                       width: radius * 2,
                                       height: radius * 2))
        
    }
}*/
@IBDesignable class GradientView: UIView {
    

override static var layerClass: AnyClass {
    return CAGradientLayer.self
}
var gradientLayer: CAGradientLayer {
    return self.layer as! CAGradientLayer
}/*
var startColor: UIColor = .white
var endColor: UIColor = .black
var startLocation: CGFloat = 0
var endLocation: CGFloat = 1
var startPoint: CGPoint = .zero
var endPoint: CGPoint = CGPoint(x: 0, y: 1)*/
    
    func updateLocations() {
    self.gradientLayer.locations = [self.startLocation as NSNumber, self.endLocation as NSNumber]
    }
    func updateColors() {
        self.gradientLayer.colors = [self.startColor.cgColor, self.endColor.cgColor]
    }
    func updateStartPoint() {
        self.gradientLayer.startPoint = startPoint
    }
    func updateEndPoint() {
        self.gradientLayer.endPoint = endPoint
    }
    
    @IBInspectable var startColor: UIColor = .white {
        didSet {
            self.updateColors()
        }
    }
    @IBInspectable var endColor: UIColor = .black {
        didSet {
            self.updateColors()
        }
    }
        
    @IBInspectable var startLocation: CGFloat = 0 {
        didSet {
            self.updateLocations()
        }
    }
    @IBInspectable var endLocation: CGFloat = 1 {
        didSet {
            self.updateLocations()
        }
    }
        
    @IBInspectable var startPoint: CGPoint = .zero {
        didSet {
            self.updateStartPoint()
        }
    }
    @IBInspectable var endPoint: CGPoint = CGPoint(x: 0, y: 1) {
        didSet {
            self.updateEndPoint()
        }
    }
}
    

enum Day: Int {
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    case sunday
    
    static let allDays: [Day] = [monday, tuesday, wednesday, thursday, friday, saturday, sunday]
    var title: String {
        switch self {
        case .monday: return "ПН"
        case .tuesday: return "ВТ"
        case .wednesday: return "СР"
        case .thursday: return "ЧТ"
        case .friday: return "ПТ"
        case .saturday: return "СБ"
        case .sunday: return "ВС"
            
        }
    }
}

@IBDesignable class WeekDayPicker: UIControl {
        var selectedDay: Day? = nil
    private var buttons: [UIButton] = []
    private var stackView: UIStackView!
    override init(frame: CGRect) {
         super.init(frame: frame)
        self.setupView()
    }
    @objc private func selectDay(_ sender: UIButton) {
        guard let index = self.buttons.firstIndex(of: sender) else { return }
        guard let day = Day(rawValue: index) else { return }
        self.selectedDay = day
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }

    private func setupView() {
        for day in Day.allDays {
            let button = UIButton(type: .system)
            button.setTitle(day.title, for: .normal)
            button.setTitleColor(.lightGray, for: .normal)
            button.setTitleColor(.white, for: .selected)
            button.addTarget(self, action: #selector(selectDay(_:)), for: .touchUpInside)
            self.buttons.append(button)
        }
        
        var selectedDay: Day? = nil {
            didSet {
                self.updateSelectedDay()
            }
        }

        stackView = UIStackView(arrangedSubviews: self.buttons)

        self.addSubview(stackView)

        stackView.spacing = 8
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
    }

    private func updateSelectedDay() {
        for (index, button) in self.buttons.enumerated() {
            guard let day = Day(rawValue: index) else { continue }
            button.isSelected = day == self.selectedDay
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.frame = bounds
    }
}


