class ChatArgs {
  String name;
  String image;
  String uid;

  ChatArgs(this.name, this.image, this.uid);
}

class BidArgs {
  String? currentUserImage, docId, uid;
  bool timerFinished;

  BidArgs(this.currentUserImage, this.docId, this.uid, this.timerFinished);
}
