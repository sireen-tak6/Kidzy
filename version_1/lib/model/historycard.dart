// ignore_for_file: camel_case_types, non_constant_identifier_names

class history {
  String Date;
  String start;
  String time;
  bool success;
  String name;
  history({
    required this.Date,
    required this.start,
    required this.time,
    required this.success,
    required this.name,
  });
}

List<history> shape = [
  history(
      Date:
          "${DateTime.now().year}:${DateTime.now().month}:${DateTime.now().day}",
      name: "shape",
      time: "05:02",
      start:
          " ${DateTime.now().minute > 9 ? DateTime.now().minute.toString() : DateTime.now().minute.toString().padLeft(2, '0')} ${DateTime.now().second > 9 ? (DateTime.now().second).toString() : (DateTime.now().second).toString().padLeft(2, '0')}",
      success: true),
  history(
      Date:
          "${DateTime.now().year}:${DateTime.now().month}:${DateTime.now().day}",
      name: "shape",
      time: "01:52",
      start:
          " ${DateTime.now().minute > 9 ? DateTime.now().minute.toString() : DateTime.now().minute.toString().padLeft(2, '0')} ${DateTime.now().second > 9 ? (DateTime.now().second).toString() : (DateTime.now().second).toString().padLeft(2, '0')}",
      success: true),
  history(
      Date:
          "${DateTime.now().year}:${DateTime.now().month}:${DateTime.now().day}",
      name: "shape",
      time: "10:02",
      start:
          " ${DateTime.now().minute > 9 ? DateTime.now().minute.toString() : DateTime.now().minute.toString().padLeft(2, '0')} ${DateTime.now().second > 9 ? (DateTime.now().second).toString() : (DateTime.now().second).toString().padLeft(2, '0')}",
      success: true),
  history(
      Date:
          "${DateTime.now().year}:${DateTime.now().month}:${DateTime.now().day}",
      name: "shape",
      time: "00:40",
      start:
          " ${DateTime.now().minute > 9 ? DateTime.now().minute.toString() : DateTime.now().minute.toString().padLeft(2, '0')} ${DateTime.now().second > 9 ? (DateTime.now().second).toString() : (DateTime.now().second).toString().padLeft(2, '0')}",
      success: true),
];

List<history> math = [
  history(
      Date:
          "${DateTime.now().year}:${DateTime.now().month}:${DateTime.now().day}",
      name: "math",
      time: "05:02",
      start:
          " ${DateTime.now().minute > 9 ? DateTime.now().minute.toString() : DateTime.now().minute.toString().padLeft(2, '0')} ${DateTime.now().second > 9 ? (DateTime.now().second).toString() : (DateTime.now().second).toString().padLeft(2, '0')}",
      success: true),
  history(
      Date:
          "${DateTime.now().year}:${DateTime.now().month}:${DateTime.now().day}",
      name: "math",
      time: "01:52",
      start:
          " ${DateTime.now().minute > 9 ? DateTime.now().minute.toString() : DateTime.now().minute.toString().padLeft(2, '0')} ${DateTime.now().second > 9 ? (DateTime.now().second).toString() : (DateTime.now().second).toString().padLeft(2, '0')}",
      success: false),
  history(
      Date:
          "${DateTime.now().year}:${DateTime.now().month}:${DateTime.now().day}",
      name: "math",
      time: "10:02",
      start:
          " ${DateTime.now().minute > 9 ? DateTime.now().minute.toString() : DateTime.now().minute.toString().padLeft(2, '0')} ${DateTime.now().second > 9 ? (DateTime.now().second).toString() : (DateTime.now().second).toString().padLeft(2, '0')}",
      success: false),
  history(
      Date:
          "${DateTime.now().year}:${DateTime.now().month}:${DateTime.now().day}",
      name: "math",
      time: "00:40",
      start:
          " ${DateTime.now().minute > 9 ? DateTime.now().minute.toString() : DateTime.now().minute.toString().padLeft(2, '0')} ${DateTime.now().second > 9 ? (DateTime.now().second).toString() : (DateTime.now().second).toString().padLeft(2, '0')}",
      success: true),
];
List<history> match = [
  history(
      Date:
          "${DateTime.now().year}:${DateTime.now().month}:${DateTime.now().day}",
      name: "match",
      time: "05:02",
      start:
          " ${DateTime.now().minute > 9 ? DateTime.now().minute.toString() : DateTime.now().minute.toString().padLeft(2, '0')} ${DateTime.now().second > 9 ? (DateTime.now().second).toString() : (DateTime.now().second).toString().padLeft(2, '0')}",
      success: true),
  history(
      Date:
          "${DateTime.now().year}:${DateTime.now().month}:${DateTime.now().day}",
      name: "match",
      time: "01:52",
      start:
          " ${DateTime.now().minute > 9 ? DateTime.now().minute.toString() : DateTime.now().minute.toString().padLeft(2, '0')} ${DateTime.now().second > 9 ? (DateTime.now().second).toString() : (DateTime.now().second).toString().padLeft(2, '0')}",
      success: true),
  history(
      Date:
          "${DateTime.now().year}:${DateTime.now().month}:${DateTime.now().day}",
      name: "match",
      time: "10:02",
      start:
          " ${DateTime.now().minute > 9 ? DateTime.now().minute.toString() : DateTime.now().minute.toString().padLeft(2, '0')} ${DateTime.now().second > 9 ? (DateTime.now().second).toString() : (DateTime.now().second).toString().padLeft(2, '0')}",
      success: true),
  history(
      Date:
          "${DateTime.now().year}:${DateTime.now().month}:${DateTime.now().day}",
      name: "match",
      time: "00:40",
      start:
          " ${DateTime.now().minute > 9 ? DateTime.now().minute.toString() : DateTime.now().minute.toString().padLeft(2, '0')} ${DateTime.now().second > 9 ? (DateTime.now().second).toString() : (DateTime.now().second).toString().padLeft(2, '0')}",
      success: true),
];
