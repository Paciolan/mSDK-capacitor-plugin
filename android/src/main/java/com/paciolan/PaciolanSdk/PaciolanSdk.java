package com.paciolan.PaciolanSdk;

import com.getcapacitor.JSObject;
import com.getcapacitor.NativePlugin;
import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.PluginMethod;

import com.paciolan.mobileSDK.MobileSDK;

@NativePlugin()
public class PaciolanSdk extends Plugin {

    @PluginMethod()
    public void show(PluginCall call) {
        String config = call.getString("config");

        MobileSDK.getInstance().startReactApp(getActivity(), config);

        JSObject ret = new JSObject();
        ret.put("config", config);
        call.success(ret);
    }
}
