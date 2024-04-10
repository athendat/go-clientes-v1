import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:client.gogogo/core/helpers/environment.dart';
import 'package:client.gogogo/data/models/Dtos/cludinary/resp_upload.dart';
import 'package:client.gogogo/data/models/Dtos/error/error_responses.dart';
import 'package:client.gogogo/data/models/client/client_model.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as gql;
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';

import '../../core/helpers/environment2.dart';
import '../models/Dtos/auth/response_login.dart';
import '../models/Dtos/auth/signin_dto.dart';
import '../models/Dtos/auth/signup_dto.dart';
import '../models/Dtos/auth2/response_loguin_adminaes.dart';
import '../models/Dtos/auth2/response_loguin_aes.dart';
import '../models/Dtos/error/error_response.dart';

class UserProvider {
  gql.QueryResult? queryResult;

  Future<Response> signup(SigupDto user) async {
    try {
      Response responseApi;
      var url = Uri.parse(Environment.apisignupgogo);

      String bodyParams = json.encode({
        'name': user.name,
        'lastname1': user.lastname1,
        'lastname2': user.lastname2,
        'email': user.email,
        'pwd': user.pwd
      });
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'apiKey': Environment.apiKeyBalanc
      };
      final http.Response res =
          await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(res.body);
      if (data['status'] != null) {
        responseApi = Response(
            ok: false,
            statusCode: data['status'] ?? 500,
            message: data['message']);
      } else {
        responseApi = Response.fromJson(data);
      }

      //  Response responseApi =
      // Response(ok: false, statusCode: 200, message: 'ok');

      return responseApi;
    } catch (e) {
      if (kDebugMode) {
        // print('Error: $e');
      }

      return Response(ok: false, statusCode: 500, message: '$e');
    }
  }

  Future<Response> login(SignDto user) async {
    // final Controller c = Get.find();
    try {
      var url = Uri.parse(Environment.apiclientloguingogo);

      Map data = {'email': user.email, 'pwd': user.pwd};

      String body = json.encode(data);

      final http.Response response = await http.post(url,
          headers: {
            "Content-Type": "application/json",
            'apiKey': Environment.apiKeyBalanc
          },
          body: body);
      final parse = jsonDecode(response.body);
      if (kDebugMode) {
        // print(response.body.toString());
      }
      switch (parse["message"]) {
        case "Credenciales no válidas.":
          return Response(
              ok: false, statusCode: 401, message: "Credenciales Invalidas");

        case "El usuario no está activado, por favor confirme su cuenta.":
          return Response(
              ok: false, statusCode: 409, message: "Usuario no activado");

        case "Ha iniciado sesión correctamente":
          ResponseLogin res = ResponseLogin.fromJson(parse);
          var box = await Hive.openBox('SessionFR');

          box.put('iduser', res.client.clientId);
          box.put('name', res.client.name);
          box.put(
              'lastname', '${res.client.lastname1} ${res.client.lastname2}');
          box.put('token', res.token);
          box.put('islogin', true);
          box.put('avatar', parse["client"]['avatar'] ?? "");

          return Response(
              ok: true, statusCode: res.statusCode, message: res.message);

        default:
          return Response(
              ok: false, statusCode: 500, message: 'Error inesperado');
      }
    } catch (e) {
      if (kDebugMode) {
        // print(e);
      }
      return Response(ok: false, statusCode: 500, message: '$e');
    }
  }

  Future<Response> activate(String code) async {
    try {
      var url = Uri.parse(Environment.activateusergogo);

      Map data = {'code': code};

      String body = json.encode(data);

      final http.Response response = await http.post(url,
          headers: {
            "Content-Type": "application/json",
            'apiKey': Environment.apiKeyBalanc
          },
          body: body);
      // final parse = jsonDecode(response.body);

      //  Response resp = Response.fromJson(parse);
      switch (response.statusCode) {
        case 404:
          // Response resp = Response.fromJson(parse);
          return Response(
              ok: false, statusCode: 404, message: "cambie el password");

        case 202:
          // ResponseLogin res = ResponseLogin.fromJson(parse);
          /*  var box = await Hive.openBox('SessionFR');

          box.put('iduser', res.client.id);
          box.put('name', res.client.name);
          box.put(
              'lastname', '${res.client.lastname1} ${res.client.lastname2}');
          box.put('token', res.token);
          box.put('islogin', true);*/

          // // print('Name: ${box.get('token')}');
          return Response(
              ok: true,
              statusCode: 200,
              message: "El usuario  ha sido confirmado");

        default:
          return Response(
              ok: false, statusCode: 500, message: 'Error inesperado');
      }
    } catch (e) {
      if (kDebugMode) {
        // print(e);
      }
      return Response(ok: false, statusCode: 500, message: '$e');
    }
  }

  Future<Response> forgotpass(String email) async {
    try {
      var url = Uri.parse(Environment.forgotpassclientgogogo);

      String bodyParams = json.encode({'email': email});
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'apiKey': Environment.apiKeyBalanc
      };
      final http.Response res =
          await http.post(url, headers: headers, body: bodyParams);
      final parse = json.decode(res.body);

      switch (res.statusCode) {
        case 500:
          // Response resp = Response.fromJson(parse);
          ErrorResponses resp = ErrorResponses.fromJson(parse);

          return Response(
              ok: false, statusCode: resp.status, message: resp.message);
        case 400:
          return Response(
              ok: false, statusCode: 400, message: parse['message'][0]);

        case 200:
          return Response(
              ok: true, statusCode: 200, message: "Recuperacion satisfactoria");

        default:
          return Response(
              ok: false, statusCode: 500, message: 'Error inesperado');
      }
    } catch (e) {
      if (kDebugMode) {
        // // // print('Error: $e');
      }

      return Response(ok: false, statusCode: 500, message: '$e');
    }
  }

  Future<Response> recoverpass(String code, String pass) async {
    try {
      var url = Uri.parse(Environment.recoverpassclientgogo);
      Response responseApi;
      String bodyParams =
          json.encode({'pwd': pass, 'forgotPasswordCode': code});
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'apiKey': Environment.apiKeyBalanc
      };
      final http.Response res =
          await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(res.body);
      switch (res.statusCode) {
        case 400:
          responseApi =
              Response(ok: false, statusCode: 400, message: "Error inesperado");
          break;
        default:
          responseApi = Response.fromJson(data);
          break;
      }

      //  Response responseApi =
      // Response(ok: false, statusCode: 200, message: 'ok');

      return responseApi;
    } catch (e) {
      if (kDebugMode) {
        //   // print('Error: $e');
      }

      return Response(ok: false, statusCode: 500, message: '$e');
    }
  }

  Future<dynamic> getprofile() async {
    try {
      var box = await Hive.openBox('SessionFR');
      var token = box.get('token');

      var token0 = 'Bearer ' + token;

      gql.HttpLink link = gql.HttpLink(Environments.apigogo, defaultHeaders: {
        'apikey': Environments.apiKeyBalanc,
        'authorization': token0,
      });
      final policies = gql.Policies(
        fetch: gql.FetchPolicy.noCache,
      );

      gql.GraphQLClient qlClient = gql.GraphQLClient(
        link: link,
        defaultPolicies: gql.DefaultPolicies(
          watchQuery: policies,
          query: policies,
          mutate: policies,
        ),
        cache: gql.GraphQLCache(
          store: gql.HiveStore(),
        ),
      );
      queryResult = await qlClient.query(
        gql.QueryOptions(
            document: gql.gql(
              Environment.getprofile,
            ),
            variables: {}),
      );

      if (queryResult!.data == null && queryResult!.hasException) {
        // var error = queryResult!.exception!.graphqlErrors[0].toString();
        if (kDebugMode) {
          // print(queryResult!.exception!.graphqlErrors[0]);
        }
        return "Error Server";
        // exeption.value = true;
      } else {
        //  exeption.value = false;
        var request = queryResult!.data!['getProfileData'];
        return request;
      }
    } catch (e) {
      return "Error Server";
    }
  }

  Future<RespUploadCloud> updateimgprofile(File data, String category) async {
    try {
      var box = await Hive.openBox('SessionFR');
      var token = box.get('token');

      var url = Uri.parse(Environment.uploadcloudinary + category);
      http.MultipartRequest request = http.MultipartRequest('POST', url);

      request.headers.addAll(<String, String>{
        'Content-type': 'multipart/form-data',
        'apikey': Environments.apiKeyBalanc,
        'Authorization': 'Bearer $token'
      });

      request.files.add(http.MultipartFile(
          'image', data.readAsBytes().asStream(), data.lengthSync(),
          filename: data.path.split('/').last));

      var response = await request.send();
      if (response.statusCode == 201 || response.statusCode == 200) {
        var responses = await http.Response.fromStream(response);
        final result = jsonDecode(responses.body) as Map<String, dynamic>;

        return RespUploadCloud(ok: false, statusCode: 200, response: result);
      } else {
        return RespUploadCloud(
            ok: false,
            statusCode: 500,
            response: 'Error al intentar subir la imagen, reintentar');
      }
    } catch (e) {
      return RespUploadCloud(ok: false, statusCode: 500, response: '$e');
    }
  }

  Future<Response> updateprofileClient(Clients? client) async {
    var box = await Hive.openBox('SessionFR');
    var token = box.get('token');

    gql.QueryResult? queryResult;
    try {
      Map<String, dynamic> variables = {
        "updateClientInput": {
          "id": client!.id,
          // "avatar": client.avatar,
          "address": client.address,
          "state": client.state,
          "city": client.city,
          "country": "Cuba",
          "town": client.town,
          "gender": client.gender,
          "idNumber": client.idNumber,
          "phone": client.phone,
          "zip": client.zip ?? null,
          // "name": "Andiel",
          "lastname1": client.lastname1,
          "lastname2": client.lastname2,
          "email": client.email
        }
      };

      gql.HttpLink link = gql.HttpLink(Environment.apigogo, defaultHeaders: {
        'apikey': Environments.apiKeyBalanc,
        'Authorization': 'Bearer $token'
      });

      final policies = gql.Policies(
        fetch: gql.FetchPolicy.noCache,
      );

      gql.GraphQLClient qlClient = gql.GraphQLClient(
        link: link,
        cache: gql.GraphQLCache(
          store: null,
        ),
        defaultPolicies: gql.DefaultPolicies(
          watchQuery: policies,
          query: policies,
          mutate: policies,
        ),
      );
      queryResult = await qlClient.mutate(
        gql.MutationOptions(
            operationName: 'UpdateClient',
            document: gql.gql(
              Environment.updateProfile,
            ),
            variables: variables),
      );

      if (queryResult.data == null && queryResult.hasException) {
        var error = queryResult.exception!.graphqlErrors[0].toString();

        return Response(ok: false, statusCode: 500, message: error);
      } else {
        // exeption.value = false;
        // requests = queryResult.data!['createRequest']['ok'];
        return Response(
            ok: false,
            statusCode: 200,
            message: "Perfil actualizado correctamente");
      }
    } catch (e) {
      if (kDebugMode) {
        //  // print('Error: $e');
      }
      return Response(ok: false, statusCode: 500, message: e.toString());
    }
  }

  Future<Response> updateImageprofileClient(
      String idclient, String urlimg) async {
    var box = await Hive.openBox('SessionFR');
    var token = box.get('token');

    gql.QueryResult? queryResult;
    try {
      Map<String, dynamic> variables = {
        "updateEntityImageInput": {
          "id": idclient,
          "imageUrl": urlimg,
        }
      };

      gql.HttpLink link = gql.HttpLink(Environment.apigogo, defaultHeaders: {
        'apikey': Environments.apiKeyBalanc,
        'Authorization': 'Bearer $token'
      });

      final policies = gql.Policies(
        fetch: gql.FetchPolicy.noCache,
      );

      gql.GraphQLClient qlClient = gql.GraphQLClient(
        link: link,
        cache: gql.GraphQLCache(
          store: null,
        ),
        defaultPolicies: gql.DefaultPolicies(
          watchQuery: policies,
          query: policies,
          mutate: policies,
        ),
      );
      queryResult = await qlClient.mutate(
        gql.MutationOptions(
            operationName: 'UpdateClientAvatar',
            document: gql.gql(
              Environment.updateImageProfileClient,
            ),
            variables: variables),
      );

      if (queryResult.data == null && queryResult.hasException) {
        var error = queryResult.exception!.graphqlErrors[0].toString();
        return Response(ok: false, statusCode: 500, message: error);
      } else {
        return Response(
            ok: true,
            statusCode: 200,
            message: "Imagen de perfil actualizada correctamente");
      }
    } catch (e) {
      if (kDebugMode) {
        //  // print('Error: $e');
      }
      return Response(ok: false, statusCode: 500, message: e.toString());
    }
  }
}
