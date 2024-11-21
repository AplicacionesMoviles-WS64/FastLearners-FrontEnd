class User {
  int? id;
  String name;
  String email;
  String password;
  List<String> membership;

  User({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    this.membership = const ["BASIC"]
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'membership': membership
    };
  }

  static User fromLoginMap(Map<String, dynamic> res) {

    List<String> membership = (res["memberships"] as List<dynamic>)
        .map((m) => m as String)
        .toList();

    return new User(
        id: res["id"],
        name: "",
        email: "",
        password: "",
        membership: membership);
  }

  static User fromMap(Map<String, dynamic> res) {


    return new User(
        id: res["id"],
        name: res["username"],
        email: "",
        password: "",
        membership: const [""]);
  }

}