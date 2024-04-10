import 'dart:async';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown_alert/alert_controller.dart';
import 'package:flutter_dropdown_alert/model/data_alert.dart';
import 'package:flutx/flutx.dart';
import 'package:get/get.dart';
import 'package:client.gogogo/data/models/Dtos/cludinary/resp_upload.dart';
import 'package:client.gogogo/data/models/client/client_model.dart';
import 'package:client.gogogo/data/models/state.dart';
import 'package:client.gogogo/data/models/statescode.dart';
import 'package:client.gogogo/data/providers/user_provider.dart';
import 'package:hive/hive.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image/image.dart' as img;

class EditProfileController extends FxController {
  TickerProvider ticker;

  var idsol;
  var isreadonly = true.obs;

  var genders = ["Masculino", "Femenino"];

  EditProfileController(this.ticker);
  var daterecogida = DateTime.now().obs;

  //List<Product>? products;
  bool showLoading = true, uiLoading = true;
  GlobalKey<FormState> formKey = GlobalKey();

  var loadrequest = false.obs;

  List<dynamic> requests = [];
  var lod = false.obs;
  var exeption = false.obs;
  var userid = "".obs;
  var loadingrutes = false.obs;
  var tomadadone = false.obs;

  //----------------variables------------------------
  UserProvider up = UserProvider();
  //----------------end-variables---------------------

  final f = DateFormat('dd-MM-yyyy');
  //-------------variables del formulario---------------
  late TextEditingController nombre = TextEditingController(text: '');
  late TextEditingController birthday =
      TextEditingController(text: '2023-07-28');
  late TextEditingController apellido1 = TextEditingController(text: '');
  late TextEditingController apellido2 = TextEditingController(text: '');
  late TextEditingController username = TextEditingController(text: '');
  late TextEditingController email = TextEditingController(text: '');
  late TextEditingController direccion = TextEditingController(text: '');
  late TextEditingController idnumber = TextEditingController(text: '');
  late TextEditingController phone = TextEditingController(text: '');
  late TextEditingController genero = TextEditingController(text: '');

  var gender = "Masculino".obs;
  var avatar = "".obs;
  var iduser = "".obs;
  late TextEditingController addres = TextEditingController(text: '');
  late TextEditingController country = TextEditingController(text: '');
  late TextEditingController city = TextEditingController(text: '');
  late TextEditingController states = TextEditingController(text: '');
  late TextEditingController town = TextEditingController(text: '');
  late TextEditingController zip = TextEditingController(text: '');
  late TextEditingController age = TextEditingController(text: '');

  //-------------ned variables form-------------
  var styledloading = false.obs;
  var loadinggetrequest = false.obs;
  RxList<Municipios> statescode = <Municipios>[].obs;
  Rx<Municipios> selectedstatecode = Municipios(city: "", state: "").obs;
  RxList<String> statess = <String>[].obs;
  var selectedstate = "".obs;
  //---------------------si es edit---------------
  var readonly = false.obs;
  late File imageFiless;
  @override
  Future<void> initState() async {
    super.initState();
    genders = ["Masculino", "Femenino"];
    statess.value = await Provincia.getDummyList();
    selectedstate.value = statess[2];
    await getsession();

    //  await getrequests();
  }

  cargaedit() async {}

  Future<void> getsession() async {
    loadinggetrequest.value = true;

    var box = await Hive.openBox('SessionFR');
    userid.value = box.get('iduser');
    var respprofile = await up.getprofile();
    respprofile == "Error Server"
        ? exeption.value = true
        : exeption.value = false;
    respprofile != "Error Server" ? await textprofileinit(respprofile) : null;
    respprofile != "Error Server" ? box.put('avatar', avatar.value) : null;
    loadinggetrequest.value = false;
  }

  Future<void> textprofileinit(respprofile) async {
    nombre = TextEditingController(text: respprofile['client']['name'] ?? "");
    apellido1 =
        TextEditingController(text: respprofile['client']['lastname1'] ?? "");
    apellido2 =
        TextEditingController(text: respprofile['client']['lastname2'] ?? "");
    addres =
        TextEditingController(text: respprofile['client']['address'] ?? "");
    email = TextEditingController(text: respprofile['client']['email'] ?? "");
    idnumber =
        TextEditingController(text: respprofile['client']['idNumber'] ?? "");

    gender.value = respprofile['client']['gender'] ?? "";
    zip = TextEditingController(text: respprofile['client']['zip'] ?? "");
    phone = TextEditingController(text: respprofile['client']['phone'] ?? "");
    avatar.value = respprofile['client']['avatar'] ?? "";
    iduser.value = respprofile['client']['id'] ?? "";
    respprofile['client']['city'] ?? "";
    town = TextEditingController(text: respprofile['client']['town'] ?? "");
    selectedstate.value = respprofile['client']['state'] ?? selectedstate.value;
    avatar.value = respprofile['client']['avatar'] ?? "";

    var municipios = await Municipios.getDummyList();

    for (var mun in municipios) {
      mun.state == selectedstate.value ? statescode.add(mun) : null;
    }

    var filtromunicipio = respprofile['client']['city'] ?? statescode[0].city;
    var municipioselect =
        municipios.firstWhere((element) => element.city == filtromunicipio);

    selectedstatecode.value = municipioselect ?? municipios.first;
  }

//validators--------------------------------------
  String? validateText(String? text) {
    if (text == null || text.isEmpty) {
      return "Porfavor introduzca el texto";
    }
    return null;
  }

  String? validatenumb(String? text) {
    if (text == null || text.isEmpty) {
      return "Porfavor introduzca el texto";
    } else if (!FxStringUtils.isDigitIncluded(text)) {
      return "Porfavor introduzca un correo válido";
    }
    return null;
  }

  String? validateCi(String? text) {
    if (text == null || text.isEmpty) {
      return "Porfavor introduzca el texto";
    } else if (text.length < 11) {
      return "Porfavor introduzca un carnet de identidad válido";
    }
    return null;
  }

  String? validateEmail(String? text) {
    if (text == null || text.isEmpty) {
      return "Porfavor introduzca el correo";
    } else if (!FxStringUtils.isEmail(text)) {
      return "Porfavor introduzca un correo válido";
    }
    return null;
  }

//end validators-------------------------------------------------------

//-----------------states and code ----------------------------------
  void filtersMunicipios() async {
    statescode.clear();
    var municipios = await Municipios.getDummyList();

    for (var mun in municipios) {
      mun.state == selectedstate.value ? statescode.add(mun) : null;
    }

    selectedstatecode.value = statescode.first;
  }

//------------------end states ----------------------------------

//---------------------camera permission-------------------
  Future<void> subirimagen(ImageSource metod) async {
    await _checkStoragePermission();
    _getImageFromGalleryorCamera(metod);
  }

  _checkStoragePermission() async {
    PermissionStatus status;
    PermissionStatus statuscamera;
    if (Platform.isAndroid) {
      final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
      final AndroidDeviceInfo info = await deviceInfoPlugin.androidInfo;
      if ((info.version.sdkInt) >= 32) {
        status = await Permission.manageExternalStorage.request();
        statuscamera = await Permission.photos.request();
        await Permission.camera.request();
      } else {
        status = await Permission.storage.request();
        statuscamera = await Permission.camera.request();
      }
    } else {
      status = await Permission.storage.request();
    }

    switch (status) {
      case PermissionStatus.denied:
        return false;
      case PermissionStatus.granted:
        return true;
      case PermissionStatus.restricted:
        return false;
      case PermissionStatus.limited:
        return true;
      case PermissionStatus.permanentlyDenied:
        return false;
    }
  }

  Future<void> _getImageFromGalleryorCamera(ImageSource metod) async {
    final picker = ImagePicker();
    XFile? imager =
        await picker.pickImage(source: metod); //source: ImageSource.camera

    if (imager != null) {
      final imageFile = imager.path;
      final image = File(imageFile);

      final imageBytes = await image.readAsBytes();
      final imageSizeInBytes = imageBytes.length;
      final decodedImage = img.decodeImage(Uint8List.fromList(imageBytes));
      // final resizedImage =
      //   img.copyResize(decodedImage!, width: 250, height: 250);
      final compressedImage = img.encodeJpg(decodedImage!, quality: 100);
      final editedFile = File(imager.path);
      await editedFile.writeAsBytes(compressedImage);

      // Verificar dimensiones (por ejemplo, ancho y alto máximos).
      final imageWidth = decodedImage.width;
      final imageHeight = decodedImage.height;
      final maxWidth = 1920;
      final maxHeight = 1080;
      // Aquí puedes utilizar pickedFile para mostrar la imagen o realizar otras acciones.
      // Por ejemplo, mostrar la imagen en un widget Image:
      // final imageFile = File(pickedFile.path);
      // rECORTAR IMAGEN AWAIT-----------------------------------------;
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: imager.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Ajustar imagen de perfil',
              toolbarColor: theme.primaryColor,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Ajustar imagen de perfil',
          ),
        ],
      );
      if (croppedFile != null) {
        var img = File(croppedFile.path);
        imageFiless = img;
        loadrequest.value = true;
        RespUploadCloud resp = await up.updateimgprofile(img, "user");
        if (resp.statusCode != 500) {
          avatar.value = resp.response['imageUrl'];
          // var impublic_id = resp.response['public_id'];
          var imgresp =
              await up.updateImageprofileClient(iduser.value, avatar.value);
          imgresp.statusCode == 200
              ? AlertController.show(
                  "Enhorabuena",
                  "Foto de perfil actualizada correctamente",
                  TypeAlert.success,
                )
              : AlertController.show(
                  "Error al editar la foto de perfil",
                  imgresp.message,
                  TypeAlert.error,
                );
        } else {
          loadrequest.value = false;
          AlertController.show(
            "Error al editar la foto de perfil",
            "Reintentar",
            TypeAlert.error,
          );
        }
      }

      update();
      loadrequest.value = false;
    } else {
      // El usuario canceló la selección de la imagen.
    }
  }

  Future<void> updateprofile() async {
    if (formKey.currentState!.validate()) {
      loadrequest.value = true;
      update();
      var client = Clients();
      client.id = iduser.value;
      client.idNumber = idnumber.text;

      client.name = nombre.text;
      client.lastname1 = apellido1.text;
      client.lastname2 = apellido2.text;
      client.address = addres.text;
      client.email = email.text;
      client.gender = gender.value;
      client.town = town.text;
      client.state = selectedstate.value;
      client.city = selectedstatecode.value.city;
      client.phone = phone.text;
      client.zip = zip.text == "" ? null : zip.text;

      var updateuser = await up.updateprofileClient(client);
      updateuser.statusCode == 200
          ? AlertController.show(
              "Enhorabuena",
              updateuser.message,
              TypeAlert.success,
            )
          : AlertController.show(
              "Error al actualizar el perfil de usuario",
              updateuser.message,
              TypeAlert.error,
            );

      loadrequest.value = false;
      update();
    }
  }

  void goBack() {
    Navigator.pop(context);
  }

  Future<bool> onWillPop() async {
    return true;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  String getTag() {
    return "editprofile_controller";
  }
}
