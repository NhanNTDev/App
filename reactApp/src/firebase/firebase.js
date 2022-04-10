
import { initializeApp } from "firebase/app";
import { getAuth } from "firebase/auth";
import { getStorage } from "firebase/storage";

//Firebase config
const firebaseConfig = {
  apiKey: "AIzaSyBsQgiuhVscJKdwFzNREhHUQRXE3ZKAJOc",
  authDomain: "otpweb-7b358.firebaseapp.com",
  projectId: "otpweb-7b358",
  storageBucket: "otpweb-7b358.appspot.com",
  messagingSenderId: "988565290694",
  appId: "1:988565290694:web:b6249d700c8b33e9fc21c7",
  measurementId: "G-F6YY08WWN2"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
export const auth = getAuth(app);
export const storage = getStorage(app);
