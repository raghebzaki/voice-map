
class PlaceList {

   final int id ;
   final String placeName;
   final double userlat;
   final double userlng;


  PlaceList({this.id, this.placeName, this.userlat, this.userlng});

  String table(){
    return 'places';
  }

  String database() {
    return 'places_db';
  }

  Map< String, dynamic> tomap() {
    return{
      'id' : this.id,
      'name' : this.placeName,
      'lat' : this.userlat,
      'lng' : this.userlng,
    };
  }


  String getname() {
    return this.placeName;
  }



}