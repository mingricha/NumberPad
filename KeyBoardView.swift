//
//  KeyBoardView.swift
//  AurfyPay
//
//  Created by swane chen on 2019/3/15.
//  Copyright © 2019 swane chen. All rights reserved.
//

import UIKit

//protocol KeyBoardViewDelegate: class {
//    func confirmButtonClick()
//    func numberChanged(newNumber: NSString)
//}

@IBDesignable class KeyBoardView: UIView {
    
    
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
    
    @IBOutlet var button0: UIButton!
    
    @IBOutlet var buttonClear: UIButton!
    
    var num: NSString =  "" {
        didSet {
//            PrintLog(message: "????")
            currentTextField?.text = num as String
        }
    }

    //weak var delegate: KeyBoardViewDelegate?
    
    weak var currentTextField: UITextField?
    
    var contentView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView = loadViewFromNib()
        addSubview(contentView)
        addConstraints()
        //初始化属性配置
        initialSetup()
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
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
    
    func initialSetup() {
        
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
       
        buttonBackSpace.addTarget(self, action: #selector(self.functionButtonClicked(_:)), for: .touchUpInside)
        buttonClear.addTarget(self, action: #selector(self.functionButtonClicked(_:)), for: .touchUpInside)
        
        
    }
    
    @objc func numberButtonClicked(_ sender: UIButton) {
        
        
        
        guard let tf = currentTextField  else {
            return
        }
        
        num = tf.text! as NSString
        guard num.length <= 12 else { return }  //最大 2 位，超出按钮无效
    
        
        var numInt: Int  //临时变量
//        if sender.tag == 11 {
//                if num.length >= 8 { return }  //如果已经 8 位，则 00 键无效
//                numInt = num.integerValue * 100  //按 00 键后，num X 100 倍
//        }else
        var numIntegerValue: Int = 0
        if num.length > 0 {
            numIntegerValue = num.integerValue
        }
        
        if sender.tag == 10 {
                numInt = numIntegerValue * 10  //按 0 键后，num X 10 倍
        } else {
                numInt = numIntegerValue * 10  //先 num X 10 倍
                numInt += sender.tag // num ＋ 键值
        }
            //            print(numInt)
        num = String(numInt) as NSString //保留两位小数转成 NSString
        
        //textField?.text = num as String  //NSString -> String 来显示
        
    }
    
    @objc func functionButtonClicked(_ sender: UIButton) -> Void {
        
        guard (currentTextField != nil) else {
            return
        }
        
        
        switch sender.tag {
        case 11:  //功能 退格
           
            if num.length >= 1 {
                    num = num.substring(to: num.length-1) as NSString
            } else {
                    num = ""
            }
                //textField?.text = num as String
           
        case 12:  //功能 清零
            num = ""
        //textField?.text = num as String
        default:
            return
        }
    }
    
}
