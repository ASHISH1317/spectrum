

import 'package:get_starter_kit_2024/app/data/remote/api_service/init_api_service.dart';
import 'package:get_starter_kit_2024/app/utils/network_call_back.dart';

/// Api calls
class ApiCall {
  /// Send sms api call
  static Future<void> sendSms({
    required Map<String, dynamic> body,
    required NetworkCallBack callBack,
  }) async {
    await APIService.post(
      callBack: callBack,
      path: 'SendSMS',
      data: body,
    );
  }

  /// Otp verification api call
  static Future<void> otpVerify({
    required Map<String, dynamic> body,
    required NetworkCallBack callBack,
  }) async {
    await APIService.post(
      callBack: callBack,
      path: 'OTPVerification/',
      data: body,
    );
  }
}
