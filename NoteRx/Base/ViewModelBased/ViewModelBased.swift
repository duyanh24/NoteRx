
//
//  ViewModelBase.swift
//  NoteRx
//
//  Created by AnhLD on 9/17/20.
//  Copyright © 2020 AnhLD. All rights reserved.
//

import Foundation
import UIKit

protocol ViewModel {
    
}

protocol ServicesViewModel: ViewModel {
    associatedtype Services
    var services: Services! { get set }
}

protocol ViewModelBased: class {
    associatedtype ViewModelType: ViewModel
    var viewModel: ViewModelType! { get set }
}

extension ViewModelBased where Self: UIViewController {
    static func instantiate<ViewModelType>(withViewModel viewModel: ViewModelType) -> Self? where ViewModelType == Self.ViewModelType {
        let identifier = String(describing: Self.self)
        let viewController = UIStoryboard.init(name: identifier, bundle: nil).instantiateViewController(withIdentifier: identifier) as? Self
        viewController?.viewModel = viewModel
        return viewController
    }
}

extension ViewModelBased where Self: UIViewController, ViewModelType: ServicesViewModel {
    static func instantiate<ViewModelType, ServiceType>(withViewModel viewModel: ViewModelType, andServices services: ServiceType) -> Self? where ViewModelType == Self.ViewModelType, ServiceType == Self.ViewModelType.Services {
        let identifier = String(describing: Self.self)
        let viewController = UIStoryboard.init(name: identifier, bundle: nil).instantiateViewController(withIdentifier: identifier) as? Self
        viewController?.viewModel = viewModel
        viewController?.viewModel.services = services
        return viewController
    }
}
