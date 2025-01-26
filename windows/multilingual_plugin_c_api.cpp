#include "include/multilingual/multilingual_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "multilingual_plugin.h"

void MultilingualPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  multilingual::MultilingualPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
