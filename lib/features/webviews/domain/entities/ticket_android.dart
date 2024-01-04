import 'dart:convert';

TicketAndroid documentStructFromMap(String str) =>
    TicketAndroid.fromMap(json.decode(str));

String documentStructToMap(TicketAndroid data) => json.encode(data.toMap());

class TicketAndroid {
  TicketAndroid({
    required this.companyData,
    required this.documentHeader,
    required this.documentBodyHeader,
    required this.documentBodyLines,
    required this.documentNotes,
    required this.documentFooter,
    required this.codesToScanner,
  });

  final List<CodesToScanner>? companyData;
  final List<CodesToScanner>? documentHeader;
  final List<DocumentBodyHeader>? documentBodyHeader;
  final List<DocumentBodyLine>? documentBodyLines;
  final List<DocumentNote>? documentNotes;
  final List<CodesToScanner>? documentFooter;
  final List<CodesToScanner>? codesToScanner;

  TicketAndroid copyWith({
    List<CodesToScanner>? companyData,
    List<CodesToScanner>? documentHeader,
    List<DocumentBodyHeader>? documentBodyHeader,
    List<DocumentBodyLine>? documentBodyLines,
    List<DocumentNote>? documentNotes,
    List<CodesToScanner>? documentFooter,
    List<CodesToScanner>? codesToScanner,
  }) =>
      TicketAndroid(
        companyData: companyData ?? this.companyData,
        documentHeader: documentHeader ?? this.documentHeader,
        documentBodyHeader: documentBodyHeader ?? this.documentBodyHeader,
        documentBodyLines: documentBodyLines ?? this.documentBodyLines,
        documentNotes: documentNotes ?? this.documentNotes,
        documentFooter: documentFooter ?? this.documentFooter,
        codesToScanner: codesToScanner ?? this.codesToScanner,
      );

  factory TicketAndroid.fromMap(Map<String, dynamic> json) => TicketAndroid(
        companyData: json["company_data"] == null
            ? null
            : List<CodesToScanner>.from(
                json["company_data"].map((x) => CodesToScanner.fromMap(x))),
        documentHeader: json["document_header"] == null
            ? null
            : List<CodesToScanner>.from(
                json["document_header"].map((x) => CodesToScanner.fromMap(x))),
        documentBodyHeader: json["document_body_header"] == null
            ? null
            : List<DocumentBodyHeader>.from(json["document_body_header"]
                .map((x) => DocumentBodyHeader.fromMap(x))),
        documentBodyLines: json["document_body_lines"] == null
            ? null
            : List<DocumentBodyLine>.from(json["document_body_lines"]
                .map((x) => DocumentBodyLine.fromMap(x))),
        documentNotes: json["document_notes"] == null
            ? null
            : List<DocumentNote>.from(
                json["document_notes"].map((x) => DocumentNote.fromMap(x))),
        documentFooter: json["document_footer"] == null
            ? null
            : List<CodesToScanner>.from(
                json["document_footer"].map((x) => CodesToScanner.fromMap(x))),
        codesToScanner: json["codes_to_scanner"] == null
            ? null
            : List<CodesToScanner>.from(
                json["codes_to_scanner"].map((x) => CodesToScanner.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "company_data": companyData == null
            ? null
            : List<dynamic>.from(companyData!.map((x) => x.toMap())),
        "document_header": documentHeader == null
            ? null
            : List<dynamic>.from(documentHeader!.map((x) => x.toMap())),
        "document_body_header": documentBodyHeader == null
            ? null
            : List<dynamic>.from(documentBodyHeader!.map((x) => x.toMap())),
        "document_body_lines": documentBodyLines == null
            ? null
            : List<dynamic>.from(documentBodyLines!.map((x) => x.toMap())),
        "document_notes": documentNotes == null
            ? null
            : List<dynamic>.from(documentNotes!.map((x) => x.toMap())),
        "document_footer": documentFooter == null
            ? null
            : List<dynamic>.from(documentFooter!.map((x) => x.toMap())),
        "codes_to_scanner": codesToScanner == null
            ? null
            : List<dynamic>.from(codesToScanner!.map((x) => x.toMap())),
      };
}

class CodesToScanner {
  CodesToScanner({
    required this.title,
    required this.description,
  });

  final String? title;
  final String? description;

  CodesToScanner copyWith({
    String? title,
    String? description,
  }) =>
      CodesToScanner(
        title: title ?? this.title,
        description: description ?? this.description,
      );

  factory CodesToScanner.fromMap(Map<String, dynamic> json) => CodesToScanner(
        title: json["title"],
        description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "description": description,
      };
}

class DocumentBodyHeader {
  DocumentBodyHeader({
    required this.names,
    required this.abbreviation,
  });

  final List<String>? names;
  final List<String>? abbreviation;

  DocumentBodyHeader copyWith({
    List<String>? names,
    List<String>? abbreviation,
  }) =>
      DocumentBodyHeader(
        names: names ?? this.names,
        abbreviation: abbreviation ?? this.abbreviation,
      );

  factory DocumentBodyHeader.fromMap(Map<String, dynamic> json) =>
      DocumentBodyHeader(
        names: json["names"] == null
            ? null
            : List<String>.from(json["names"].map((x) => x)),
        abbreviation: json["abbreviation"] == null
            ? null
            : List<String>.from(json["abbreviation"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "names":
            names == null ? null : List<dynamic>.from(names!.map((x) => x)),
        "abbreviation": abbreviation == null
            ? null
            : List<dynamic>.from(abbreviation!.map((x) => x)),
      };
}

class DocumentBodyLine {
  DocumentBodyLine({
    required this.title,
    required this.description,
  });

  final List<String>? title;
  final String? description;

  DocumentBodyLine copyWith({
    List<String>? title,
    String? description,
  }) =>
      DocumentBodyLine(
        title: title ?? this.title,
        description: description ?? this.description,
      );

  factory DocumentBodyLine.fromMap(Map<String, dynamic> json) =>
      DocumentBodyLine(
        title: json["title"] == null
            ? null
            : List<String>.from(json["title"].map((x) => x)),
        description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        "title":
            title == null ? null : List<dynamic>.from(title!.map((x) => x)),
        "description": description,
      };
}

class DocumentNote {
  DocumentNote({
    required this.title,
    required this.description,
  });

  final String? title;
  final String? description;

  DocumentNote copyWith({
    String? title,
    String? description,
  }) =>
      DocumentNote(
        title: title ?? this.title,
        description: description ?? this.description,
      );

  factory DocumentNote.fromMap(Map<String, dynamic> json) => DocumentNote(
        title: json["title"],
        description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "description": description,
      };
}
