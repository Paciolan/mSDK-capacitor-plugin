declare module "@capacitor/core" {
  interface PluginRegistry {
    PaciolanSdk: PaciolanSdkPlugin;
  }
}

export interface PaciolanSdkPlugin {
  show(options: { config: string }): Promise<{ config: string }>;
}
