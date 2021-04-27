
class PlaceList {

    int id ;
    String placeName;
    double userlat;
    double userlng;


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

   PlaceList.fromMap(Map<String, dynamic> data){
     id = data['id'];
     placeName = data['name'];
     userlat = data['lat'];
     userlng = data['lng'];
   }


}