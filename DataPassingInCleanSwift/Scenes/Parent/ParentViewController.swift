//
//  ParentViewController.swift
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

protocol ParentDisplayLogic: AnyObject
{
    func displayChild(viewModel: Parent.SetEnteredText.ViewModel)
}

class ParentViewController: UIViewController, ParentDisplayLogic
{
    var interactor: ParentBusinessLogic?
    var router: (NSObjectProtocol & ParentRoutingLogic & ParentDataPassing)?
    
    @IBOutlet weak var txtField: UITextField!
    @IBOutlet weak var btnSendToChild: UIButton!
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = ParentInteractor()
        let presenter = ParentPresenter()
        let router = ParentRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    // MARK: IBActions
    
    @IBAction func btnSendToChildTapped(_ sender: UIButton) {
        
        if let enteredText = txtField.text, enteredText.count > 0 {
            
            self.setEnteredText(text: enteredText)
            
        }
    }
    
    // MARK: Do something
    
    //@IBOutlet weak var nameTextField: UITextField!
    
    func setEnteredText(text: String)
    {
        let request = Parent.SetEnteredText.Request(enteredText: text)
        interactor?.setEnteredText(request: request)
    }
    
    func displayChild(viewModel: Parent.SetEnteredText.ViewModel)
    {
        self.router?.routeToChild(segue: nil)
    }
}
