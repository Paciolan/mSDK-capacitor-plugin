# Capacitor integration for MobileSDK

```
npm install https://github.com/Paciolan/mSDK-capacitor-plugin --save
```

## iOS

Add the following to your project's iOS podfile:

```
source 'https://github.com/Paciolan/mSDK-specs'
source 'https://github.com/CocoaPods/Specs.git'

# Include the PaciolanSdkCapacitorPlugin in your pods
pod 'PaciolanSdkCapacitorPlugin', :path => '../../node_modules/paciolan-sdk-capacitor-plugin'
```

If Podfile includes use_frameworks! add this post install script or append the contents to your post install script:

```
post_install do |installer|
  installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
          if target.name == "RNAwesomeCardIO"
              config.build_settings["OTHER_LDFLAGS"] = '$(inherited) "-ObjC"'
          end
      end
  end
end
```

Run `pod install repo-update` in the ios/App directory of your project.

Run the following in the root directory of the project:

```
npx cap sync
ionic build && npx cap copy
```

If linking issues occur for React, this step would need to be done as the frameworks are an external dependency of React.

```
npx cap open ios


In `Pods -> Targets -> React -> Build Phases -> Link Binary With Libraries` add:

- `glog.framework`
- `DoubleConversion.framework`
```

This might be needed if some assets not added to the App target from the PaciolanSDK pod.

```
In `AppName -> Targets -> AppName -> Build Phases -> Copy Bundle Resources -> + -> Add Other...` add:

- `Pods/PaciolanSDK/Pod/Assets/PaciolanSDK.js` - `Copy items if needed` - `Finish`
```

## Android

In your `build.gradle` file within the root of your `android` folder, add:

```
maven {
            url "http://s3.us-west-2.amazonaws.com/paciolan.mobilesdk/releases"
}
```

The above url should work. But if for some reason, an alternate url is needed - url "http://paciolan.mobilesdk.s3.amazonaws.com/releases" can be used as well.

In your `app/build.gradle` file, add (`under dependencies`):

```
implementation 'com.paciolan:mobilesdk:{specific version}'
```

Register PaciolanSdk's class in your Acitivity so Capacitor is aware of it:

```
// Other imports...
import com.paciolan.PaciolanSdk.PaciolanSdk;

...

    // Initializes the Bridge
    this.init(savedInstanceState, new ArrayList<Class<? extends Plugin>>() {{
      // Additional plugins you've installed go here
      // Ex: add(TotallyAwesomePlugin.class);
      add(PaciolanSdk.class);
    }});

```

## Ionic App

Call the PaciolanSdk Plugin

```
const { PaciolanSdk } = Plugins;
```

```
PaciolanSdk.show({
  config: JSON.stringify({
    channelCode: "msdk-sa",
    sdkKey: "test2",
    applicationId: "com.paciolan.sdk",
    uiOptions: {
      accentColor: "#ab0520",
      permissions: {
        statusBar: false,
        camera: true
      },
      contactURL:
        "https://ev12.evenue.net/cgi-bin/ncommerce3/EVExecMacro?linkID=uaz-ts&evm=cont",
      privacyURL: "http://www.sidearmsports.com/policies/",
      tosURL: "http://www.sidearmsports.com/policies/"
    },
    organizationId: 521,
    distributorCode: "ARIZONA",
    route: {
      name: "bestAvailableTicketPurchase",
      params: {
        policyCode: "PDISA",
        seasonCode: "FB20",
        itemCode: "FB01"
      },
      uiOptions: {
        forgotPasswordUrl:
          "https://ev12.evenue.net/cgi-bin/ncommerce3/EVExecMacro?linkID=uaz-ts&evm=regf&addrReq=&phoneReq=&RSRC=&RDAT=&url=https%3A%2F%2Fev12.evenue.net%2Fcgi-bin%2Fncommerce3%2FEVExecMacro%3FlinkID%3Duaz-ts%26evm%3Dmyac%26entry%3DDisplayGroupList.html",
        loginDomain: "arizonawildcats.com",
        itemImage:
          "https://s3-us-west-2.amazonaws.com/pachtml-production/www/uaz-ts/images/group/FBMP.jpg",
        loginImage:
          "https://ev12.evenue.net/www/ev_uaz-ts/ss/evenue/customize/ev_uaz-ts/images/skin/nav_logo.png",
        accessibleSeatingUrl: "tel:18008008000"
      }
    },
    debug: false,
    demo: false
  })
})
```

Other Notes:

If you wish to set camera permissions to true, the info.plist file under your iOS folder needs to include: (Defaulted to false in the initialization)

```
// This will allow the application to ask the user for permission to access the camera
<key>NSCameraUsageDescription</key>
<string>Used for the card scanning feature.</string>
```

If there seem to be crashes due to statusBar customization, adding this to your info.plist: (Defaulted to false in the initialization)

```
// This will allow the application to ask the user for permission to customize the look of the status bar
<key>UIViewControllerBasedStatusBarAppearance</key>
 <string>Used for customizing the status bar.</string>
```

Any issues with android, usually a `./gradlew clean` inside the `android` folder along with an Android Studio restart does the job.
