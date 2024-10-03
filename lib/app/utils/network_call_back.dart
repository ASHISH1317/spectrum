/// NetworkCallBack is a class that contains two functions`onSuccess`
/// and `onFailure` that are called when the http request is successful
/// and when it fails respectively.`
class NetworkCallBack {
  /// NetworkCallBack is a class that contains two functions`onSuccess`
  NetworkCallBack({
    required this.onSuccess,
    required this.onFailure,
  });

  /// Called when http request is successful
  final void Function(Map<String, dynamic> data) onSuccess;

  /// Called when http request fail-200
  final void Function(Map<String, dynamic> data) onFailure;
}


/// Create call back with return type List<Dynamic>
class NetworkCallBackList {
  /// NetworkCallBack is a class that contains two functions`onSuccess`
  NetworkCallBackList({
    required this.onSuccess,
  });

  /// Called when http request is successful
  final void Function(List<dynamic> data) onSuccess;

}
