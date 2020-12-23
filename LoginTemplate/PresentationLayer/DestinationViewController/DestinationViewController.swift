//
//  DestinationViewController.swift
//  LoginTemplate
//
//  Created by Ацкий Станислав on 20.12.2020.
//

import UIKit
import Contacts

class DestinationViewController: UIViewController {
    
    // MARK: - UI
    
    private lazy var destinationView: DestinationView = {
        let destView = DestinationView()
        return destView
    }()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = destinationView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        getContacts().forEach {
            print("\n\($0.givenName) \($0.familyName):")
            $0.phoneNumbers.forEach { print("\($0.label ?? "Unknowned"): \($0.value.stringValue)") }
        }
    }
    
    // MARK: - Helpful

    private func getContacts() -> [CNContact] {
        
        let contactStore = CNContactStore()
        let keys: [Any] = [
            CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
            CNContactPhoneNumbersKey,
            CNContactEmailAddressesKey,
            CNContactThumbnailImageDataKey
        ]
        
        var allContainers: [CNContainer] = []
        do {
            allContainers = try contactStore.containers(matching: nil)
        } catch {
            print("Error fetching containers")
        }
        
        var results: [CNContact] = []
        
        for container in allContainers {
            let fetchPredicate = CNContact.predicateForContactsInContainer(withIdentifier: container.identifier)
            
            do {
                let containerResults = try contactStore.unifiedContacts(matching: fetchPredicate,
                                                                        keysToFetch: keys as! [CNKeyDescriptor])
                results.append(contentsOf: containerResults)
            } catch {
                print("Error fetching containers")
            }
        }
        return results
    }

}
