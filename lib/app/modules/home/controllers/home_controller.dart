import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:get_starter_kit_2024/app/data/config/logger.dart';

/// Home controller class
class HomeController extends GetxController {
  /*FlutterInsta flutterInsta = FlutterInsta();

  Future printDetails() async {
    await flutterInsta.getProfileData('mr_modii');
    logI(flutterInsta.followers);
    appSnackbar(message: flutterInsta.followers ?? 'Not found');
  }*/

  /// Get profile data
  Future<void> getProfileData(String username, String sessionId) async {
    final Response<dynamic> res = await Dio().get<dynamic>(
      'https://www.instagram.com/$username/?__a=1',
      options: Options(
        headers: <String, dynamic>{
          'Cookie': 'rur=FTW; shbid=480; sessionid=$sessionId',
        },
      ),
    );

    logI(res.data);

    final Map<String, dynamic> graphql =
        res.data!['graphql'] as Map<String, dynamic>;

    final Map<String, dynamic> user = graphql['user'] as Map<String, dynamic>;
    logI(user);
    logI(user['edge_followed_by'].toString());

    /*var biography = user['biography'];
    _bio = biography;
    var myfollowers = user['edge_followed_by'];
    var myfollowing = user['edge_follow'];
    _followers = myfollowers['count'].toString();
    _following = myfollowing['count'].toString();
    _website = user['external_url'];
    _imgurl = user['profile_pic_url_hd'];
    _feedImagesUrl = user['edge_owner_to_timeline_media']['edges']
      .map<String>((image) => image['node']['display_url'] as String).toList();
    this._username=username;*/
  }
}
