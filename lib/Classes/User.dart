
class User{
  String ?uid ='';
  String ?Fname;
  String ?Sname;
  String ?email;
  String ?password;
  // List<ProductInCart> ShoppingCart = [];
  double ?CartSubtotal=0;

  User({
    required this.uid,
    required this.Fname,
    required this.Sname,
    required this.email,
    required this.password,
    // required this.ShoppingCart
  });
}