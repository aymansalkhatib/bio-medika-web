importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts(
  "https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js"
);
const firebaseConfig = {
  apiKey:
    "AAAAV9TkI2A:APA91bGG8FzBTNVl6UtqMjuxMZoHMjSbSx3uhz7CPy5LNELuiTmQgNvmGhqJ5fUPA4_Z46HsJwJpHh0nSlnk1-zC_HdwkvQEuLc-5YfFIZy7hee5_9V2kp7IeS22i_V90Zppo6ZHVHK2",
  authDomain: "bio-medika.firebaseapp.com",
  databaseURL: "https://bio-medika-default-rtdb.firebaseio.com",
  projectId: "bio-medika",
  storageBucket: "bio-medika.appspot.com",
  messagingSenderId: "377233875808",
  appId: "1:377233875808:web:647a8826be384c51c6b405",
  measurementId: "G-MD4CPEQ6GR",
};
firebase.initializeApp(firebaseConfig);

const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((message) => {
  console.log("onBackgroundMessage", message);
});
