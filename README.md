#ASSKStoreActivity (Objective-C Framework, Swift Tutorial)

![image]()


#### # First things First

- Drag `"ASSKStoreActivity"` folder into your Xcode project
- If Xcode asks if you want to use a Bridging Header then please do. In this .h we will write `#import "ASSKStoreActivity.h"`. If you are using Objective-C throughout, place the #import in the UIViewController of the button whose action will call the ActivityVC
- This example uses `JDSActivityVC` but it should work with the standard UIActivityVC
- This example also uses `ARSafariActivity` and `ARChromeActivity` but have nothing to do with this 🌚


**Setup**

Import related framework

	import StoreKit
 
 Whichever ViewController you are activating the ActivityVC from (in this example ASViewController), add `SKStoreProductViewControllerDelegate` like so:

 	class ASViewController: UIViewController, SKStoreProductViewControllerDelegate
 
 Next add the productViewControllerDidFinish method anywhere to this ViewController
 
	func productViewControllerDidFinish(viewController: SKStoreProductViewController!)` {
        
        viewController.dismissViewControllerAnimated(true, completion: nil)
	}

Create these variables

	var url: NSURL!	// URL to pass
	var string: NSString!	// Optional URL
	var appID: Int!	// AppID (trackID) which you will need for ASSKStoreActivity to work



**Action**

Next we simply create a method that we can call multiple times without copying and pasting. If you only present it once then put this in the button action method

	func presentActivity() {
        
        let chromeActivity = ARChromeActivity()
        let safariActivity = ARSafariActivity()
        let skstoreActivity = ASSKStoreActivity()
        
        let sampleActivityViewController = JDSActivityViewController(activityItems: [url!, string], applicationActivities: [chromeActivity, safariActivity, skstoreActivity])
        
        sampleActivityViewController.link = url
        
        sampleActivityViewController.completionWithItemsHandler = doneSharingHandler
        
        presentViewController(sampleActivityViewController, animated: true, completion: nil)
    }





The example I used was in didSelectCell but any button action will do

	if (indexPath.section == 0 && indexPath.row == 0) {
            
            url = NSURL (string: "https://itunes.apple.com/gb/app/llythrennau/id838931462?mt=8")
            string = ""
            appID = 838931462
            
            presentActivity()
        }
        
Because we cannot present the SKStore modal view from the Activity itself, we need to use a UIViewController. The best one is the one we've been writing all the code so far in
        

	func doneSharingHandler(activityType: String!, completed: Bool, returnedItems: [AnyObject]!, error: NSError!) {
        // Return if cancelled
        if (!completed) {
            println("Not ASSKStoreActivity")
            return
        }
        
        // If here, log which activity occurred
        println("Shared activity: \(activityType)")
        
        
        if (activityType == "ASSKStoreActivity") {
            
            println("Is ASSKStoreActivity")
            
            var storeProductViewController = SKStoreProductViewController()
            storeProductViewController.delegate = self
            
            // url = https://itunes.apple.com/gb/app/farty-sheep-elwyn/id903327490?mt=8
            
            let parameters = [SKStoreProductParameterITunesItemIdentifier :
                NSNumber(integer: appID)]
            
            storeProductViewController.loadProductWithParameters(parameters,
                completionBlock: {result, error in
                    if result {
                        self.presentViewController(storeProductViewController,
                            animated: true, completion: nil)
                        println("Present")
                    }
                        
                    else {
                        
                        println("Error \(error) with User Info \(error.userInfo)")
                        
                        //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/say-it-welsh-welsh-word-day/id985224829?ls=1&mt=8"]]
                    }
            })
        }
            
        else{
            
            println("Isn't ASSKStoreActivity")
        }
    }

Basically because we set a completionHolder, we check what happened in the ActivityVC and feed it back to the ASViewController. If the "Open SKStore Modal" activity is selected, here is where we do it all, whether in reality it failed or not. If you check ASSKStoreActivity.m you will see that we hardcoded completed = YES; 

Eventually I'll upload a simpler tutorial, but this is pretty much the exact code I use in Say It Welsh (iOS).


