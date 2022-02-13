import 'package:api_check/Modals/post_model.dart';

class SuperModel {
  List<Post> data;
  SuperModel({this.data});
  SuperModel.fromJson(Map<String, dynamic> json) : data = (json['data'] as List)?.map((e) => e == null ? null :Post.fromJson(e as Map<String, dynamic>))?.toList();
}
