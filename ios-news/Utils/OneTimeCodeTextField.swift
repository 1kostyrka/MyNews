//
//  OneTimeCodeTextField.swift
//  ios-auto-report
//
//  Created by Oleh Kulakevych on 07.09.2024.
//

import UIKit

protocol OneTimeCodeTextFieldOutput: AnyObject {
    func didEnterLastDigit(code: String)
    func textFieldShouldReturn()
}

class OneTimeCodeTextField: UITextField {
    
    var defaultCharacter = "\u{2014}"
    
    weak var output: OneTimeCodeTextFieldOutput?
    
    private var digitLabels = [UILabel]()
    
    private lazy var tapRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer()
        recognizer.addTarget(self, action: #selector(becomeFirstResponder))
        return recognizer
    }()
    
    private var isConfigured = false
    
    func configure(with slotCount: Int = 6) {
        guard isConfigured == false else { return }
        isConfigured.toggle()
        
        configureTextField()
        
        let labelStackView = createLabelStackView(with: slotCount)
        addSubview(labelStackView)
        
        addGestureRecognizer(tapRecognizer)
        
        NSLayoutConstraint.activate([
            labelStackView.topAnchor.constraint(equalTo: topAnchor),
            labelStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            labelStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            labelStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
    }
    
    private func configureTextField() {
        tintColor = .clear
        textColor = .clear
        keyboardType = .numberPad
        if #available(iOS 12, *) {
            textContentType = .oneTimeCode
        } else {
            textContentType = .postalCode
        }
        
        addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        delegate = self
    }
    
    private func createLabelStackView(with count: Int) -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 14
        
        for _ in 1...count {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 33, weight: .medium)
            label.textColor = UIColor.white
            label.isUserInteractionEnabled = true
            label.text = defaultCharacter
            
            stackView.addArrangedSubview(label)
            
            digitLabels.append(label)
        }
        
        return stackView
    }
    
    @objc private func textDidChange() {
        guard let text = self.text, text.count <= digitLabels.count else { return }
        
        for i in 0..<digitLabels.count {
            let curentLabel = digitLabels[i]
            
            if i < text.count {
                let index = text.index(text.startIndex, offsetBy: i)
                curentLabel.textColor = UIColor.white
                curentLabel.font = UIFont.systemFont(ofSize: 33, weight: .medium)
                curentLabel.text = String(text[index])
            } else {
                curentLabel.text?.removeAll()
                curentLabel.textColor = UIColor.white
                curentLabel.text = defaultCharacter
            }
        }
        
        if text.count == digitLabels.count {
            output?.didEnterLastDigit(code: text)
        }
    }
    
    public func autoFill(with code: String) {
        let characters = Array(code)
        for i in 0..<characters.count {
            digitLabels[i].textColor = UIColor.white
            digitLabels[i].font = UIFont.systemFont(ofSize: 33, weight: .medium)
            digitLabels[i].text = String(characters[i])
        }
        output?.didEnterLastDigit(code: code)
    }
}

extension OneTimeCodeTextField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let characterCount = textField.text?.count else { return false }
        return characterCount < digitLabels.count || string == ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        output?.textFieldShouldReturn()
        return true
    }
}


