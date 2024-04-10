import 'package:hive/hive.dart';

class ShippingAddress {
  @HiveField(0)
  String name;

  @HiveField(1)
  String number;

  @HiveField(2)
  String ci;

  @HiveField(3)
  String address;

  @HiveField(4)
  String provincia;

  @HiveField(5)
  String municipio;

  ShippingAddress(
      {
      // required  this.type,
      required this.name,
      required this.address,
      required this.number,
      required this.ci,
      required this.provincia,
      required this.municipio});

  static List<ShippingAddress> shipping() {
    List<ShippingAddress> list = [];

    list.add(ShippingAddress(
        address: "",
        name: 'Andy Munoz',
        municipio:
            'Room 1 - Ground Floor, Al Najoum Building, 24 B Street, Dubai - United Arab Emirates.',
        number: '+53 58053217',
        ci: '',
        provincia: ''));
    list.add(ShippingAddress(
        address: "",
        name: 'Andy Munoz',
        municipio:
            'Room 1 - Ground Floor, Al Najoum Building, 24 B Street, Dubai - United Arab Emirates.',
        number: '+53 58053217',
        ci: '',
        provincia: ''));

    return list;
  }
}

@HiveType(typeId: 0)
class ShippingAddresss extends HiveObject {
  // String type;
  @HiveField(0)
  String name;

  @HiveField(1)
  String number;

  @HiveField(2)
  String ci;

  @HiveField(3)
  String address;

  @HiveField(4)
  String provincia;

  @HiveField(5)
  String municipio;

  // bool isDefault;
  //IconData icon;

  ShippingAddresss(
      {
      // required  this.type,
      required this.name,
      required this.address,
      required this.number,
      required this.ci,
      required this.provincia,
      required this.municipio});

  static Future<List<ShippingAddresss>> shipping() async {
    var box1 = await Hive.openBox('Address');
    box1.add(ShippingAddresss(
        address: "",
        name: 'Andy Munoz',
        municipio:
            'Room 1 - Ground Floor, Al Najoum Building, 24 B Street, Dubai - United Arab Emirates.',
        number: '+53 58053217',
        ci: '',
        provincia: ''));
    var items = box1.values.toList().reversed.toList();
    // await box1.put('adress', ShippingAddresss.shipping());

    return items.cast();
  }

  static Future<List<ShippingAddresss>> addAddress(
      ShippingAddresss address) async {
    var box1 = await Hive.openBox('Address');
    box1.add(address);
    var items = box1.values.toList().reversed.toList();
    // await box1.put('adress', ShippingAddresss.shipping());

    return items.cast();
  }
}

class ShippingAddresssAdapter extends TypeAdapter<ShippingAddresss> {
  @override
  final typeId = 0;

  @override
  ShippingAddresss read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ShippingAddresss(
      name: fields[0] as String,
      number: fields[1] as String,
      ci: fields[2] as String,
      address: fields[3] as String,
      provincia: fields[4] as String,
      municipio: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ShippingAddresss obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.number)
      ..writeByte(2)
      ..write(obj.ci)
      ..writeByte(3)
      ..write(obj.address)
      ..writeByte(4)
      ..write(obj.provincia)
      ..writeByte(5)
      ..write(obj.municipio);
  }
}
