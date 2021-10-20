class UserModel{
  String? name,email,pic,uid;
  bool? isAdmin;

  UserModel({required this.email,required this.name,required this.pic,required this.uid,this.isAdmin});

  UserModel.fromJson(Map<String,dynamic> json){
    this.name = json['name'];
    this.pic = json['pic'];
    this.email = json['email'];
    this.uid = json['uid'];
    this.isAdmin = json['isAdmin'];
  }

  Map<String,dynamic> toMap()=>{
    'name' : this.name,
    'email' : this.email,
    'pic' : this.pic,
    'uid' : this.uid,
    'isAdmin' : this.isAdmin,
  };

}
