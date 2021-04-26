
class PlaceList {

   int id ;
   String placeName;
   double userlat;
   double userlng;


  PlaceList(this.id, this.placeName, this.userlat, this.userlng);

  PlaceList.frommap(Map<String,dynamic> map){
    this.id = map['id'];
    this.placeName = map['name'];
    this.userlat = map['lat'];
    this.userlng = map['lng'];
  }

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