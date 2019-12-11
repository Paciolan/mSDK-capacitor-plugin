```
npm install ./paciolan-sdk-capacitor-plugin --save
```

## iOS

Add to your project's iOS podfile:

```
source 'https://github.com/CocoaPods/Specs.git'
```

```
npx cap sync
```

```
ionic build && npx cap copy
```

```
npx cap open ios
```

In `Pods -> Targets -> React -> Build Phases -> Link Binary With Libraries` add:

- `glog.framework`
- `DoubleConversion.framework`

In `Pods -> Targets -> react-native-flurry-sdk -> Build Phases -> Link Binary With Libraries -> + -> Add Other...` add:

- `Pods/Flurry-iOS-SDK/Flurry/libFlurry_9.3.1.a`
- `Pods/Flurry-iOS-SDK/FlurryConfig/libFlurryConfig_9.3.1.a`
- `Pods/Flurry-iOS-SDK/FlurryMessaging/libFlurryMessaging_9.3.1.a`

Manually copy `{.m|.h}` files recursively from `ios/AppName/Pods/Flurry-iOS-SDK` to `ios/AppName/Pods/react-native-flurry-sdk/ios/ReactNativeFlurry` (8 files)

Comment Out RCT_EXPORT_METHOD `logPayment` in `AppName/ios/App/Pods/react-native-flurry-sdk/ios/ReactNativeFlurry/ReactNativeFlurry.m` (Should be lines 296 - 306)

In `AppName -> Targets -> AppName -> Build Phases -> Copy Bundle Resources -> + -> Add Other...` add:

- `Pods/PaciolanSDK/Pod/Assets/PaciolanSDK.js` - `Copy items if needed` - `Finish`

## Android

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
