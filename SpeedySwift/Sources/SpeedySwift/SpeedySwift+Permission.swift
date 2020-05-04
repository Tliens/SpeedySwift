//
//  SpeedySwift+Permission.swift
//  SpeedySwift
//
//  Created by Quinn Von on 2020/5/4.
//  Copyright © 2020 Quinn Von. All rights reserved.
//

import UIKit

extension SpeedySwift:PermissionSetDelegate{
    func check(set:PermissionSet,callback:((_ permissionSet: PermissionSet, _ permission: Permission)->())?){
        let permissionSet = PermissionSet(.contacts, .camera, .microphone, .photos)
        permissionSet.delegate = self
        didRequestPermission = callback
    }
    
    func permissionSet(permissionSet: PermissionSet, willRequestPermission permission: Permission) {
        print("Will request \(permission)")
    }

    func permissionSet(permissionSet: PermissionSet, didRequestPermission permission: Permission) {
        self.didRequestPermission?(permissionSet, permission)
    }
}
/*
 https://github.com/delba/Permission
 class PermissionsViewController: UIViewController, PermissionSetDelegate {

     override func viewDidLoad() {
         super.viewDidLoad()

         let label = UILabel()

         let contacts   = PermissionButton(.contacts)
         let camera     = PermissionButton(.camera)
         let microphone = PermissionButton(.microphone)
         let photos     = PermissionButton(.photos)

         contacts.setTitles([
             .notDetermined: "Contacts - NotDetermined"
             .authorized:    "Contacts - Authorized",
             .denied:        "Contacts - Denied"
         ])

         contacts.setTitleColors([
             .notDetermined: .black,
             .authorized:    .green,
             .denied:        .red
         ])

         // ...

         let permissionSet = PermissionSet(contacts, camera, microphone, photos)

         permissionSet.delegate = self

         label.text = String(describing: permissionSet.status)

         for subview in [label, contacts, camera, microphone, photos] {
             view.addSubview(subview)
         }
     }

     func permissionSet(permissionSet: PermissionSet, didRequestPermission permission: Permission) {
         label.text = String(permissionSet.status)
     }
 }
 */
