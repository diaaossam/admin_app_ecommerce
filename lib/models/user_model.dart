
class UserModel{
  String ? firstName;
  String ? lastName;
  String ? phone;
  String ? address;
  String ? image ;
  String ? uid;
  bool ? isAdmin;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.address,
    required this.isAdmin,
    this.image,
    this.uid});

  UserModel.fromJson(Map<String, dynamic> json){
    firstName = json ['firstName'];
    lastName = json ['lastName'];
    phone = json ['phone'];
    address = json ['address'];
    image = json ['image'];
    uid = json ['uid'];
    isAdmin = json['isAdmin'];
  }

  Map<String, dynamic> toMap(){
    return {
      'firstName':firstName,
      'lastName':lastName,
      'phone':phone,
      'address':address,
      'image':image,
      'uid':uid,
      'isAdmin':isAdmin,
    };
  }
}