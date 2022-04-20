//
//  NumberPadViewController.swift
//  tx
//
//  Created by chenswane on 2018/4/20.
//  Copyright © 2018年 com.ledcas.tx. All rights reserved.
//

import UIKit

protocol AurfyPayNumberPadDelegate: class {
    func confirmButtonClick()
    func numberChanged(newNumber: NSString)
}

@IBDesignable class AurfyPayNumberPadView: UIView {
    
    weak var delegate: AurfyPayNumberPadDelegate?
    
    //var textField: UITextField?
    
    
    var hasDecimal = true
    
    var num: NSString =  "" {
        didSet {
//            PrintLog(message: "????")
            if let delegate = self.delegate {
                delegate.numberChanged(newNumber: num)
            }
        }
    }

    @IBOutlet var button1: UIButton!
    
    @IBOutlet var button2: UIButton!
    
    @IBOutlet var button3: UIButton!
    
    @IBOutlet var buttonBackSpace: UIButton!
    
    @IBOutlet var button4: UIButton!
    
    @IBOutlet var button5: UIButton!
    
    @IBOutlet var button6: UIButton!
    
    @IBOutlet var button7: UIButton!
    
    @IBOutlet var button8: UIButton!
    
    @IBOutlet var button9: UIButton!
    
    @IBOutlet var button00: UIButton!
    
    @IBOutlet var button0: UIButton!
    
    @IBOutlet var buttonPoint: UIButton!
    
    @IBOutlet var buttonClear: UIButton!
    
    @IBOutlet var buttonConfirm: UIButton!
    
    @IBInspectable var confirmTitleColor: UIColor = .red {
        didSet {
    //            setNeedsLayout()
        }
    }
    @IBInspectable var buttonColor: UIColor = UIColor.white {
        didSet {
            button0.backgroundColor = buttonColor
//            setNeedsLayout()
        }
     }
    func initialSetup() {
        self.num = (hasDecimal == true) ? "0.00" : "0"
        button0.addTarget(self, action: #selector(self.numberButtonClicked(_:)), for: .touchUpInside)
        button1.addTarget(self, action: #selector(self.numberButtonClicked(_:)), for: .touchUpInside)
        button2.addTarget(self, action: #selector(self.numberButtonClicked(_:)), for: .touchUpInside)
        button3.addTarget(self, action: #selector(self.numberButtonClicked(_:)), for: .touchUpInside)
        button4.addTarget(self, action: #selector(self.numberButtonClicked(_:)), for: .touchUpInside)
        button0.addTarget(self, action: #selector(self.numberButtonClicked(_:)), for: .touchUpInside)
        button5.addTarget(self, action: #selector(self.numberButtonClicked(_:)), for: .touchUpInside)
        button6.addTarget(self, action: #selector(self.numberButtonClicked(_:)), for: .touchUpInside)
        button7.addTarget(self, action: #selector(self.numberButtonClicked(_:)), for: .touchUpInside)
        button8.addTarget(self, action: #selector(self.numberButtonClicked(_:)), for: .touchUpInside)
        button9.addTarget(self, action: #selector(self.numberButtonClicked(_:)), for: .touchUpInside)
        button0.addTarget(self, action: #selector(self.numberButtonClicked(_:)), for: .touchUpInside)
        button00.addTarget(self, action: #selector(self.numberButtonClicked(_:)), for: .touchUpInside)
        buttonBackSpace.addTarget(self, action: #selector(self.functionButtonClicked(_:)), for: .touchUpInside)
        buttonClear.addTarget(self, action: #selector(self.functionButtonClicked(_:)), for: .touchUpInside)
        
        
    }
  
    //布局相关设置
    override func layoutSubviews() {
        super.layoutSubviews()
        
//        layer.backgroundColor = self.barBgColor.cgColor
        
//        var barFrame = bounds
//        barFrame.size.width *= (CGFloat(self.percent) / 100)
//        bar.frame = barFrame
        
//        self.frame = bounds
    }

    var contentView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView = loadViewFromNib()
        addSubview(contentView)
        addConstraints()
        //初始化属性配置
        initialSetup()
    }
//    convenience init(frame: CGRect, textField: UITextField) {
//        self.init(frame: frame)
//        self.textField = textField
//    }
    
    //初始化时将xib中的view添加进来
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        contentView = loadViewFromNib()
        addSubview(contentView)
        addConstraints()
        //初始化属性配置
        initialSetup()
    }
    
    func loadViewFromNib() -> UIView {
        let className = type(of: self)
        let bundle = Bundle(for: className)
        let name = NSStringFromClass(className).components(separatedBy: ".").last
        let nib = UINib(nibName: name!, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return view
    }
    
    //设置好xib视图约束
    func addConstraints() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        var constraint = NSLayoutConstraint(item: contentView, attribute: .leading,
                                            relatedBy: .equal, toItem: self, attribute: .leading,
                                            multiplier: 1, constant: 0)
        addConstraint(constraint)
        constraint = NSLayoutConstraint(item: contentView, attribute: .trailing,
                                        relatedBy: .equal, toItem: self, attribute: .trailing,
                                        multiplier: 1, constant: 0)
        addConstraint(constraint)
        constraint = NSLayoutConstraint(item: contentView, attribute: .top, relatedBy: .equal,
                                        toItem: self, attribute: .top, multiplier: 1, constant: 0)
        addConstraint(constraint)
        constraint = NSLayoutConstraint(item: contentView, attribute: .bottom,
                                        relatedBy: .equal, toItem: self, attribute: .bottom,
                                        multiplier: 1, constant: 0)
        addConstraint(constraint)
    }
    
    
    @objc func numberButtonClicked(_ sender: UIButton) {
        
        if num.length >= 9 { return }  //最大 9 位，超出按钮无效
        if hasDecimal {
            var numDouble: Double  //临时变量
            if sender.tag == 11 {
                if num.length >= 8 { return }  //如果已经 8 位，则 00 键无效
                numDouble = num.doubleValue * 100  //按 00 键后，num X 100 倍
            }else if sender.tag == 10 {
                numDouble = num.doubleValue * 10  //按 0 键后，num X 10 倍
            }else {
                numDouble = num.doubleValue * 10  //先 num X 10 倍
                numDouble += Double(sender.tag) / 100//再 num ＋ 键值
            }
//            print(numDouble)
            num = NSString(format: "%0.2f", numDouble)//保留两位小数转成 NSString
            
        } else {
            var numInt: Int  //临时变量
            if sender.tag == 11 {
                if num.length >= 8 { return }  //如果已经 8 位，则 00 键无效
                numInt = num.integerValue * 100  //按 00 键后，num X 100 倍
            }else if sender.tag == 10 {
                numInt = num.integerValue * 10  //按 0 键后，num X 10 倍
            }else {
                numInt = num.integerValue * 10  //先 num X 10 倍
                numInt += sender.tag // num ＋ 键值
            }
//            print(numInt)
            num = String(numInt) as NSString //保留两位小数转成 NSString
        }
        //textField?.text = num as String  //NSString -> String 来显示
        
    }
    
    @objc func functionButtonClicked(_ sender: UIButton) -> Void {
        
        switch sender.tag {
        case 12:  //功能 退格
            if hasDecimal {
                let mStr: NSMutableString = NSMutableString(string: num)  //先转成 可变的 NSString
                mStr.insert("00", at: mStr.length-1)  //在第一位小数和第二位小数之间 插入 “00”
                let numDouble = mStr.doubleValue / 10  //除以 10
                num = NSString(format: "%0.2f", numDouble)  //保留两位小数 为 NSString
               //textField?.text = num as String
            } else {
                if num.length >= 2 {
                    num = num.substring(to: num.length-1) as NSString
                } else {
                    num = "0"
                }
                //textField?.text = num as String
            }
        case 13:  //功能 清零
            num = hasDecimal ? "0.00" : "0"
            //textField?.text = num as String
        default:
           return
        }
   }

    @IBAction func confirmButtonClicked(_ sender: Any) {
        if let delegate = self.delegate {
            delegate.confirmButtonClick()
        }
    }
    
}
