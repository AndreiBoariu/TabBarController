//
//  MMHomeVC.swift
//  MM
//
//  Created by Andy Boariu on 08/11/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

let k_UIActionSheet_Tag_NewAsset                        = 99999
let k_UIActionSheet_Tag_AddToProperty                   = 99998
let k_UIActionSheet_Tag_NewPhotoCloudOptions            = 99997

protocol MMHomeVCDelegate
{
    func didTakePictures()
    func didChoosePictures()
}

class MMHomeVC: UITabBarController, UITabBarControllerDelegate, UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate
{
    var delegateHomeVC    : MMHomeVCDelegate?
    
    var imagePicker = UIImagePickerController()
    var btnNewMoment = UIButton()

    // MARK: - ViewController Methods
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //=>    Set delegate
        self.delegate = self
        
        //=>    Keep white color for tab images for both tab states (selected and unselected)
        for item in tabBar.items as! [UITabBarItem] {
            if let image = item.image {
                item.image = image.imageWithColor(UIColor.whiteColor()).imageWithRenderingMode(.AlwaysOriginal)
            }
        }
        
        //=>    Add selected/unselected tab image
        if let arrTabBarItems = tabBar.items {
            var tabBarItem1 = arrTabBarItems[0] as! UITabBarItem
            var tabBarItem2 = arrTabBarItems[1] as! UITabBarItem
            
            var strDeviceModel = "i5"
            if Device.IS_4_INCHES_OR_SMALLER() {
                strDeviceModel = "i5"
            }
            else
                if Device.IS_4_7_INCHES() {
                    strDeviceModel = "i6"
                }
                else
                    if Device.IS_5_5_INCHES() {
                        strDeviceModel = "i6plus"
            }
            
            let imgHomeTabNormal  = UIImage(named: "tabHome_normal_\(strDeviceModel)")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
            let imgHomeTabSelected  = UIImage(named: "tabHome_selected_\(strDeviceModel)")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
            
            let imgProfileTabNormal  = UIImage(named: "tabProfile_normal_\(strDeviceModel)")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
            let imgProfileTabSelected  = UIImage(named: "tabProfile_selected_\(strDeviceModel)")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
            
            let imgTabBarBackground  = UIImage(named: "tabBar_bg_\(strDeviceModel)")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
            
            tabBarItem1.image = imgHomeTabNormal
            tabBarItem1.selectedImage = imgHomeTabSelected
            
            tabBarItem2.image = imgProfileTabNormal
            tabBarItem2.selectedImage = imgProfileTabSelected
            
            //=>    Set appearance to UITabBar
            UITabBar.appearance().tintColor                     = UIColor.whiteColor()
            UITabBar.appearance().selectionIndicatorImage       = UIImage()
            UITabBar.appearance().shadowImage                   = UIImage()
            UITabBar.appearance().backgroundImage               = imgTabBarBackground
        }

        addNewMomentButton()
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    //=>    I incresed the height of tab bar
    override func viewWillLayoutSubviews() {
        var tabFrame = self.tabBar.frame
        tabFrame.size.height = 53
        tabFrame.origin.y = self.view.frame.size.height - 53
        self.tabBar.frame = tabFrame
    }
    
    // MARK: - Custom Methods
    
    func addNewMomentButton() {
        btnNewMoment                      = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        btnNewMoment.frame                = CGRectMake(self.view.frame.size.width / 2 - 29, self.view.frame.size.height - 67, 58, 58)
        btnNewMoment.backgroundColor      = UIColor.clearColor()
        btnNewMoment.setImage(UIImage(named: "btnNewMoment"), forState: UIControlState.Normal)
        btnNewMoment.setImage(UIImage(named: "btnNewMoment_selected"), forState: UIControlState.Highlighted)
        btnNewMoment.addTarget(self, action: "btnNewMoment_Action", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(btnNewMoment)
    }
    
    // MARK: - Action Methods
    
    func btnNewMoment_Action() {
        
    }
    
    // MARK: - Memory Management Methods

    override func didReceiveMemoryWarning()
    {
       super.didReceiveMemoryWarning()
       // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
