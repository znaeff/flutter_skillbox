class Person {
  late String firstname;
  late String lastname;
  late String email;
  late String photo;

  Person({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.photo,
  });

  Person.fromJson(Map<String, dynamic> json)
      : this(
          firstname: json['firstname'],
          lastname: json['lastname'],
          email: json['email'],
          photo: json['photo'],
        );
}
