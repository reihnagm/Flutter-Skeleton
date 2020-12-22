class UserClass {
  String uid;
  String fullName;
  String username;
  String nra;
  String ynci;
  String alamat;
  String noKtp;
  String noSim;
  String closestName;
  String closestNo;
  String golDarah;
  String shortBio;
  String avatarUrl;
  String email;
  String authKey;
  int status;
  DateTime createdAt;
  DateTime updatedAt;

  UserClass({
    this.uid,
    this.fullName,
    this.username,
    this.nra,
    this.ynci,
    this.alamat,
    this.noKtp,
    this.noSim,
    this.closestName,
    this.closestNo,
    this.golDarah,
    this.shortBio,
    this.avatarUrl,
    this.email,
    this.authKey,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory UserClass.fromJson(Map<String, dynamic> json) => UserClass(
    uid: json["uid"] == null ? null : json["uid"],
    fullName: json["full_name"] == null ? null : json["full_name"],
    username: json["username"] == null ? null : json["username"],
    nra: json["nra"] == null ? null : json["nra"],
    ynci: json["ynci"] == null ? null : json["ynci"],
    alamat: json["alamat"] == null ? null : json["alamat"],
    noKtp: json["no_ktp"] == null ? null : json["no_ktp"],
    noSim: json["no_sim"] == null ? null : json["no_sim"],
    closestName: json["closest_name"] == null ? null : json["closest_name"],
    closestNo: json["closest_no"] == null ? null : json["closest_no"],
    golDarah: json["gol_darah"] == null ? null : json["gol_darah"],
    shortBio: json["short_bio"] == null ? null : json["short_bio"],
    avatarUrl: json["avatar_url"] == null ? null : json["avatar_url"],
    email: json["email"] == null ? null : json["email"],
    authKey: json["auth_key"] == null ? null : json["auth_key"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );
}
