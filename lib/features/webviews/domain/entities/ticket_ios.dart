import 'dart:convert';

List<TicketIos> iosDocumentFromJson(String str) => List<TicketIos>.from(json.decode(str).map((x) => TicketIos.fromJson(x)));

String iosDocumentToJson(List<TicketIos> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TicketIos {
    final String line;

    TicketIos({
        required this.line,
    });

    factory TicketIos.fromJson(Map<String, dynamic> json) => TicketIos(
        line: json["line"],
    );

    Map<String, dynamic> toJson() => {
        "line": line,
    };
}