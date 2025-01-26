#ifndef FLUTTER_PLUGIN_MULTILINGUAL_PLUGIN_H_
#define FLUTTER_PLUGIN_MULTILINGUAL_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace multilingual {

class MultilingualPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  MultilingualPlugin();

  virtual ~MultilingualPlugin();

  // Disallow copy and assign.
  MultilingualPlugin(const MultilingualPlugin&) = delete;
  MultilingualPlugin& operator=(const MultilingualPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace multilingual

#endif  // FLUTTER_PLUGIN_MULTILINGUAL_PLUGIN_H_
