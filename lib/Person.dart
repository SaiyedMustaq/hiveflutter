import 'package:hive/hive.dart';

part 'Person.g.dart';

@HiveType(typeId: 1)
class Person {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late int age;
}
