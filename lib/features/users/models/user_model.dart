import 'package:objectbox/objectbox.dart';

@Entity()
class User {
  int id;
  String name;
  String email;

  User({this.id=0, required this.name, required this.email});
}
