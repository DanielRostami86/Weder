//
//  DynamicWidthView.swift
//  Weder
//
//  Created by Behnam on 8/8/22.
//

import SwiftUI
import SnapKit



struct DashboardStatusView: UIViewRepresentable {
    
    var status: LoadingStatus
    
    func makeUIView(context: Context) -> some UIView {
        let container = UIView()
        let stackContainer = UIView()
        let stackView = UIStackView()
        let statusIndicator = UIView()
        let label = UILabel()
        
        stackContainer.layer.borderColor = UIColor.white.cgColor
        stackContainer.layer.borderWidth = 2
        stackContainer.layer.cornerRadius = 25

        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 10
        
        statusIndicator.layer.cornerRadius = 5
        statusIndicator.backgroundColor = statusColor()
        
        label.text = status.updatingTitle
        label.textAlignment = .center
        label.textColor = .white
        
        container.addSubview(stackContainer)
        stackContainer.addSubview(stackView)
        stackView.addArrangedSubview(statusIndicator)
        stackView.addArrangedSubview(label)
        
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(20)
            make.leading.equalToSuperview().offset(20)
        }
        
        stackContainer.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
        }
        
        statusIndicator.snp.makeConstraints { make in
            make.size.equalTo(10)
        }
        
        return container
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) { }
    
    private func statusColor() -> UIColor {
        switch status {
        case .loading:
            return UIColor.yellow
        case .done:
            return UIColor.green
        case .failed:
            return UIColor.red
        }
    }
}

struct DashboardStatusView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardStatusView(status: .done)
            .preferredColorScheme(.dark)
        DashboardStatusView(status: .failed)
            .preferredColorScheme(.dark)
        DashboardStatusView(status: .loading)
            .preferredColorScheme(.dark)
    }
}
