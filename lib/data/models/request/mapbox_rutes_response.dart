// To parse this JSON data, do
//
//     final responseMapboxRutes = responseMapboxRutesFromJson(jsonString);

import 'dart:convert';

ResponseMapboxRutes responseMapboxRutesFromJson(String str) =>
    ResponseMapboxRutes.fromJson(json.decode(str));

String responseMapboxRutesToJson(ResponseMapboxRutes data) =>
    json.encode(data.toJson());

class ResponseMapboxRutes {
  List<Route>? routes;
  List<Waypoint>? waypoints;
  String? code;
  String? uuid;

  ResponseMapboxRutes({
    this.routes,
    this.waypoints,
    this.code,
    this.uuid,
  });

  factory ResponseMapboxRutes.fromJson(Map<String, dynamic> json) =>
      ResponseMapboxRutes(
        routes: json["routes"] == null
            ? []
            : List<Route>.from(json["routes"]!.map((x) => Route.fromJson(x))),
        waypoints: json["waypoints"] == null
            ? []
            : List<Waypoint>.from(
                json["waypoints"]!.map((x) => Waypoint.fromJson(x))),
        code: json["code"],
        uuid: json["uuid"],
      );

  Map<String, dynamic> toJson() => {
        "routes": routes == null
            ? []
            : List<dynamic>.from(routes!.map((x) => x.toJson())),
        "waypoints": waypoints == null
            ? []
            : List<dynamic>.from(waypoints!.map((x) => x.toJson())),
        "code": code,
        "uuid": uuid,
      };
}

class Route {
  String? weightName;
  double? weight;
  double? duration;
  double? distance;
  // List<Leg>? legs;
  Geometry? geometry;

  Route({
    this.weightName,
    this.weight,
    this.duration,
    this.distance,
    //   this.legs,
    this.geometry,
  });

  factory Route.fromJson(Map<String, dynamic> json) => Route(
        weightName: json["weight_name"],
        weight: json["weight"]?.toDouble(),
        duration: json["duration"]?.toDouble(),
        distance: json["distance"]?.toDouble(),
        //   legs: json["legs"] == null ? [] : List<Leg>.from(json["legs"]!.map((x) => Leg.fromJson(x))),
        geometry: json["geometry"] == null
            ? null
            : Geometry.fromJson(json["geometry"]),
      );

  Map<String, dynamic> toJson() => {
        "weight_name": weightName,
        "weight": weight,
        "duration": duration,
        "distance": distance,
        //    "legs": legs == null ? [] : List<dynamic>.from(legs!.map((x) => x.toJson())),
        "geometry": geometry?.toJson(),
      };
}

class Geometry {
  List<List<double>>? coordinates;
  GeometryType? type;

  Geometry({
    this.coordinates,
    this.type,
  });

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        coordinates: json["coordinates"] == null
            ? []
            : List<List<double>>.from(json["coordinates"]!
                .map((x) => List<double>.from(x.map((x) => x?.toDouble())))),
        type: geometryTypeValues.map[json["type"]]!,
      );

  Map<String, dynamic> toJson() => {
        "coordinates": coordinates == null
            ? []
            : List<dynamic>.from(
                coordinates!.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "type": geometryTypeValues.reverse[type],
      };
}

enum GeometryType { LINE_STRING }

final geometryTypeValues = EnumValues({"LineString": GeometryType.LINE_STRING});

class Leg {
  List<dynamic>? viaWaypoints;
  List<Admin>? admins;
  double? weight;
  double? duration;
  List<Step>? steps;
  double? distance;
  String? summary;

  Leg({
    this.viaWaypoints,
    this.admins,
    this.weight,
    this.duration,
    this.steps,
    this.distance,
    this.summary,
  });

  factory Leg.fromJson(Map<String, dynamic> json) => Leg(
        viaWaypoints: json["via_waypoints"] == null
            ? []
            : List<dynamic>.from(json["via_waypoints"]!.map((x) => x)),
        admins: json["admins"] == null
            ? []
            : List<Admin>.from(json["admins"]!.map((x) => Admin.fromJson(x))),
        weight: json["weight"]?.toDouble(),
        duration: json["duration"]?.toDouble(),
        steps: json["steps"] == null
            ? []
            : List<Step>.from(json["steps"]!.map((x) => Step.fromJson(x))),
        distance: json["distance"]?.toDouble(),
        summary: json["summary"],
      );

  Map<String, dynamic> toJson() => {
        "via_waypoints": viaWaypoints == null
            ? []
            : List<dynamic>.from(viaWaypoints!.map((x) => x)),
        "admins": admins == null
            ? []
            : List<dynamic>.from(admins!.map((x) => x.toJson())),
        "weight": weight,
        "duration": duration,
        "steps": steps == null
            ? []
            : List<dynamic>.from(steps!.map((x) => x.toJson())),
        "distance": distance,
        "summary": summary,
      };
}

class Admin {
  String? iso31661Alpha3;
  String? iso31661;

  Admin({
    this.iso31661Alpha3,
    this.iso31661,
  });

  factory Admin.fromJson(Map<String, dynamic> json) => Admin(
        iso31661Alpha3: json["iso_3166_1_alpha3"],
        iso31661: json["iso_3166_1"],
      );

  Map<String, dynamic> toJson() => {
        "iso_3166_1_alpha3": iso31661Alpha3,
        "iso_3166_1": iso31661,
      };
}

class Step {
  List<Intersection>? intersections;
  Maneuver? maneuver;
  String? name;
  double? duration;
  double? distance;
  DrivingSide? drivingSide;
  double? weight;
  Mode? mode;
  Geometry? geometry;

  Step({
    this.intersections,
    this.maneuver,
    this.name,
    this.duration,
    this.distance,
    this.drivingSide,
    this.weight,
    this.mode,
    this.geometry,
  });

  factory Step.fromJson(Map<String, dynamic> json) => Step(
        intersections: json["intersections"] == null
            ? []
            : List<Intersection>.from(
                json["intersections"]!.map((x) => Intersection.fromJson(x))),
        maneuver: json["maneuver"] == null
            ? null
            : Maneuver.fromJson(json["maneuver"]),
        name: json["name"],
        duration: json["duration"]?.toDouble(),
        distance: json["distance"]?.toDouble(),
        drivingSide: drivingSideValues.map[json["driving_side"]]!,
        weight: json["weight"]?.toDouble(),
        mode: modeValues.map[json["mode"]]!,
        geometry: json["geometry"] == null
            ? null
            : Geometry.fromJson(json["geometry"]),
      );

  Map<String, dynamic> toJson() => {
        "intersections": intersections == null
            ? []
            : List<dynamic>.from(intersections!.map((x) => x.toJson())),
        "maneuver": maneuver?.toJson(),
        "name": name,
        "duration": duration,
        "distance": distance,
        "driving_side": drivingSideValues.reverse[drivingSide],
        "weight": weight,
        "mode": modeValues.reverse[mode],
        "geometry": geometry?.toJson(),
      };
}

enum DrivingSide { RIGHT, STRAIGHT }

final drivingSideValues =
    EnumValues({"right": DrivingSide.RIGHT, "straight": DrivingSide.STRAIGHT});

class Intersection {
  List<int>? bearings;
  List<bool>? entry;
  MapboxStreetsV8? mapboxStreetsV8;
  bool? isUrban;
  int? adminIndex;
  int? out;
  int? geometryIndex;
  List<double>? location;
  int? intersectionIn;
  double? duration;
  double? turnWeight;
  double? turnDuration;
  double? weight;
  bool? trafficSignal;
  bool? railwayCrossing;
  List<Lane>? lanes;

  Intersection({
    this.bearings,
    this.entry,
    this.mapboxStreetsV8,
    this.isUrban,
    this.adminIndex,
    this.out,
    this.geometryIndex,
    this.location,
    this.intersectionIn,
    this.duration,
    this.turnWeight,
    this.turnDuration,
    this.weight,
    this.trafficSignal,
    this.railwayCrossing,
    this.lanes,
  });

  factory Intersection.fromJson(Map<String, dynamic> json) => Intersection(
        bearings: json["bearings"] == null
            ? []
            : List<int>.from(json["bearings"]!.map((x) => x)),
        entry: json["entry"] == null
            ? []
            : List<bool>.from(json["entry"]!.map((x) => x)),
        mapboxStreetsV8: json["mapbox_streets_v8"] == null
            ? null
            : MapboxStreetsV8.fromJson(json["mapbox_streets_v8"]),
        isUrban: json["is_urban"],
        adminIndex: json["admin_index"],
        out: json["out"],
        geometryIndex: json["geometry_index"],
        location: json["location"] == null
            ? []
            : List<double>.from(json["location"]!.map((x) => x?.toDouble())),
        intersectionIn: json["in"],
        duration: json["duration"]?.toDouble(),
        turnWeight: json["turn_weight"]?.toDouble(),
        turnDuration: json["turn_duration"]?.toDouble(),
        weight: json["weight"]?.toDouble(),
        trafficSignal: json["traffic_signal"],
        railwayCrossing: json["railway_crossing"],
        lanes: json["lanes"] == null
            ? []
            : List<Lane>.from(json["lanes"]!.map((x) => Lane.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "bearings":
            bearings == null ? [] : List<dynamic>.from(bearings!.map((x) => x)),
        "entry": entry == null ? [] : List<dynamic>.from(entry!.map((x) => x)),
        "mapbox_streets_v8": mapboxStreetsV8?.toJson(),
        "is_urban": isUrban,
        "admin_index": adminIndex,
        "out": out,
        "geometry_index": geometryIndex,
        "location":
            location == null ? [] : List<dynamic>.from(location!.map((x) => x)),
        "in": intersectionIn,
        "duration": duration,
        "turn_weight": turnWeight,
        "turn_duration": turnDuration,
        "weight": weight,
        "traffic_signal": trafficSignal,
        "railway_crossing": railwayCrossing,
        "lanes": lanes == null
            ? []
            : List<dynamic>.from(lanes!.map((x) => x.toJson())),
      };
}

class Lane {
  List<DrivingSide>? indications;
  bool? valid;
  bool? active;
  DrivingSide? validIndication;

  Lane({
    this.indications,
    this.valid,
    this.active,
    this.validIndication,
  });

  factory Lane.fromJson(Map<String, dynamic> json) => Lane(
        indications: json["indications"] == null
            ? []
            : List<DrivingSide>.from(
                json["indications"]!.map((x) => drivingSideValues.map[x]!)),
        valid: json["valid"],
        active: json["active"],
        validIndication: drivingSideValues.map[json["valid_indication"]]!,
      );

  Map<String, dynamic> toJson() => {
        "indications": indications == null
            ? []
            : List<dynamic>.from(
                indications!.map((x) => drivingSideValues.reverse[x])),
        "valid": valid,
        "active": active,
        "valid_indication": drivingSideValues.reverse[validIndication],
      };
}

class MapboxStreetsV8 {
  Class? mapboxStreetsV8Class;

  MapboxStreetsV8({
    this.mapboxStreetsV8Class,
  });

  factory MapboxStreetsV8.fromJson(Map<String, dynamic> json) =>
      MapboxStreetsV8(
        mapboxStreetsV8Class: classValues.map[json["class"]]!,
      );

  Map<String, dynamic> toJson() => {
        "class": classValues.reverse[mapboxStreetsV8Class],
      };
}

enum Class { STREET, PRIMARY, SECONDARY, TERTIARY, SERVICE, TRUNK }

final classValues = EnumValues({
  "primary": Class.PRIMARY,
  "secondary": Class.SECONDARY,
  "service": Class.SERVICE,
  "street": Class.STREET,
  "tertiary": Class.TERTIARY,
  "trunk": Class.TRUNK
});

class Maneuver {
  ManeuverType? type;
  String? instruction;
  int? bearingAfter;
  int? bearingBefore;
  List<double>? location;
  Modifier? modifier;

  Maneuver({
    this.type,
    this.instruction,
    this.bearingAfter,
    this.bearingBefore,
    this.location,
    this.modifier,
  });

  factory Maneuver.fromJson(Map<String, dynamic> json) => Maneuver(
        type: maneuverTypeValues.map[json["type"]]!,
        instruction: json["instruction"],
        bearingAfter: json["bearing_after"],
        bearingBefore: json["bearing_before"],
        location: json["location"] == null
            ? []
            : List<double>.from(json["location"]!.map((x) => x?.toDouble())),
        modifier: modifierValues.map[json["modifier"]]!,
      );

  Map<String, dynamic> toJson() => {
        "type": maneuverTypeValues.reverse[type],
        "instruction": instruction,
        "bearing_after": bearingAfter,
        "bearing_before": bearingBefore,
        "location":
            location == null ? [] : List<dynamic>.from(location!.map((x) => x)),
        "modifier": modifierValues.reverse[modifier],
      };
}

enum Modifier { RIGHT, LEFT, SLIGHT_RIGHT }

final modifierValues = EnumValues({
  "left": Modifier.LEFT,
  "right": Modifier.RIGHT,
  "slight right": Modifier.SLIGHT_RIGHT
});

enum ManeuverType { DEPART, TURN, FORK, ARRIVE }

final maneuverTypeValues = EnumValues({
  "arrive": ManeuverType.ARRIVE,
  "depart": ManeuverType.DEPART,
  "fork": ManeuverType.FORK,
  "turn": ManeuverType.TURN
});

enum Mode { DRIVING }

final modeValues = EnumValues({"driving": Mode.DRIVING});

class Waypoint {
  double? distance;
  String? name;
  List<double>? location;

  Waypoint({
    this.distance,
    this.name,
    this.location,
  });

  factory Waypoint.fromJson(Map<String, dynamic> json) => Waypoint(
        distance: json["distance"]?.toDouble(),
        name: json["name"],
        location: json["location"] == null
            ? []
            : List<double>.from(json["location"]!.map((x) => x?.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "distance": distance,
        "name": name,
        "location":
            location == null ? [] : List<dynamic>.from(location!.map((x) => x)),
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
