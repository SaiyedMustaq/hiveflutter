import 'package:hive/hive.dart';
part 'Address.g.dart';

@HiveType(typeId: 2)
class Address {
  @HiveField(0)
  late String landmark;

  @HiveField(1)
  late int poncode;
}
