//
//  TextFieldOnlyTableViewCell.swift
//  MoodStation
//
//  Created by 홍성준 on 2022/03/05.
//

import UIKit
import SnapKit
import Then

struct TextFieldOnlyTableViewCellModel {
    
    let inset: UIEdgeInsets?
    let placeholder: String
    let font: UIFont?
    let text: String?
    let isEnabled: Bool
    let isSecureTextEntry: Bool
        
    init(inset: UIEdgeInsets?, placeholder: String = "", font: UIFont?, text: String? = "", isEnabled: Bool = true, isSecureTextEntry: Bool = false) {
        self.inset = inset
        self.placeholder = placeholder
        self.font = font
        self.text = text
        self.isEnabled = isEnabled
        self.isSecureTextEntry = isSecureTextEntry
    }
    
}

protocol TextFieldOnlyTableViewCellDelegate {
    
    func textFieldDidChangeText(_ cell: TextFieldOnlyTableViewCell, text: String?)
    
}

final class TextFieldOnlyTableViewCell: UITableViewCell {
    
    var delegate: TextFieldOnlyTableViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupLayout()
        self.setupAttributes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: TextFieldOnlyTableViewCellModel) {
        self.textField.font = model.font
        self.textField.attributedPlaceholder = NSMutableAttributedString(string: model.placeholder)
            .foregroundColor(.gray03)
        self.textField.text = model.text
        self.textField.isEnabled = model.isEnabled
        self.textField.isSecureTextEntry = model.isSecureTextEntry
        self.textField.textColor = model.isEnabled ? .white : .gray03
        
        self.containerView.snp.remakeConstraints { make in
            make.edges.equalToSuperview().inset(model.inset ?? .zero)
            make.height.equalTo(55)
        }
    }
    
    private func setupLayout() {
        self.contentView.addSubview(self.containerView)
        self.containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(55)
        }
        
        self.containerView.addSubview(self.textField)
        self.textField.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview().inset(17)
            make.trailing.equalToSuperview().inset(17) // TODO: Inset 변경
        }
    }
    
    private func setupAttributes() {
        self.do {
            $0.selectionStyle = .none
            $0.backgroundColor = .clear
        }
        
        self.containerView.do {
            $0.backgroundColor = .gray06
            $0.layer.cornerRadius = 10
        }
        
        self.textField.do {
            $0.addTarget(self, action: #selector(textFieldDidChangeText(_:)), for: .editingChanged)
        }
    }
    
    @objc private func textFieldDidChangeText(_ sender: UITextField) {
        self.delegate?.textFieldDidChangeText(self, text: textField.text)
    }
    
    private let containerView = UIView(frame: .zero)
    private let textField = UITextField(frame: .zero)
    
}
