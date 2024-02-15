//
//  ChildPresenter.swift
//  DataPassingInCleanSwift
//
//  Created by Aqeel Ahmed on 02/02/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ChildPresentationLogic
{
    func presentEnteredText(response: Child.GetEnteredText.Response)
}

class ChildPresenter: ChildPresentationLogic
{
    weak var viewController: ChildDisplayLogic?
    
    // MARK: Do something
    
    func presentEnteredText(response: Child.GetEnteredText.Response)
    {
        let viewModel = Child.GetEnteredText.ViewModel(enteredText: response.enteredText)
        viewController?.displayEnteredText(viewModel: viewModel)
    }
}
