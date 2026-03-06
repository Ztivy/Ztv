class CastDAD{
  int? idCast;
  String? nameCast;
  String? birthCast;
  String? gender;

  CastDAD({this.idCast, this.nameCast, this.birthCast, this.gender});

  factory CastDAD.fromMap(Map<String, dynamic> cast){
    return CastDAD(
      idCast: cast['idCast'],
      nameCast: cast['nameCast'],
      birthCast: cast['birthCast'],
      gender: cast['gender']
    );
  }
}