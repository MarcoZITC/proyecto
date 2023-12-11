class CastModel {
    String? knownForDepartment;
    String? name;
    String? originalName;
    String? profilePath;
    int? castId;
    String? character;
    String? creditId;

    CastModel({
        this.knownForDepartment,
        this.name,
        this.originalName,
        this.profilePath,
        this.castId,
        this.character,
        this.creditId,
    });

    factory CastModel.fromJson(Map<String, dynamic> json) => CastModel(
        knownForDepartment: json["known_for_department"],
        name: json["name"],
        originalName: json["original_name"],
        profilePath: json["profile_path"],
        castId: json["cast_id"],
        character: json["character"],
        creditId: json["credit_id"],
    );

    Map<String, dynamic> toJson() => {
        "known_for_department": knownForDepartment,
        "name": name,
        "original_name": originalName,
        "profile_path": profilePath,
        "cast_id": castId,
        "character": character,
        "credit_id": creditId,
    };
}