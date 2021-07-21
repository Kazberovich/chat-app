const functions = require("firebase-functions");

exports.myFunction = functions.firestore
    .document("chats/{message}")
    .onCreate((snapshot, context) => {
      console.log(snapshot.data());
      return;
    });
