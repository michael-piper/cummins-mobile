class Notification{
  String title;
  String description;
  Notification(Map data):assert(data!=null){
    title=data['title']??null;
    description=data['description']??null;
  }
}