class User {
  final String login;
  final String password;
  final String birth;
  final String address;
  final String postal;
  final String city;
  final List<dynamic> panier;

  const User(this.login, this.password, this.panier, this.birth, this.address,
      this.postal, this.city);
}
