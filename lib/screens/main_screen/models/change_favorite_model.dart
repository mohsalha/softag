class ChangeFavoriteModel {

  bool? status;
  String? message;

  ChangeFavoriteModel.formJson(Map<String,dynamic>json){
    status = json['status'];
    message = json['message'];
  }

}