class TokenModel{
  String ? uid;
  String ? token;
  bool ? isAdmin;

  TokenModel({required this.uid,required this.token,required this.isAdmin});


  TokenModel.fromJson(Map<String , dynamic> json){
    uid = json['uid'];
    token= json['token'];
    isAdmin = json['isAdmin'];
  }

  Map< String , dynamic> toMap(){
    return {
      'uid':uid,
      'isAdmin':isAdmin,
      'token':token,
    };
  }
}