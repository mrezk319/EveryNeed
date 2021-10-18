class UserModel{
  String? name,email,pic,uid;

  UserModel({required this.email,required this.name,required this.pic,required this.uid});

  UserModel.fromJson(Map<String,dynamic> json){
    this.name = json['name'];
    this.pic = json['pic'];
    this.email = json['email'];
    this.uid = json['uid'];
  }

  Map<String,dynamic> toMap()=>{
    'name' : this.name,
    'email' : this.email,
    'pic' : this.pic,
    'uid' : this.uid,
  };

}
