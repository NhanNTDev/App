
import { initializeApp } from "firebase/app";
import { getAuth } from "firebase/auth";
import { getStorage } from "firebase/storage";

//Firebase config
const firebaseConfig = {
  apiKey: "AIzaSyC9aBJX28Xqj_kfJKtsVtfbgyakbKCLpvU",
  authDomain: "verify-otp-mobile.firebaseapp.com",
  projectId: "verify-otp-mobile",
  storageBucket: "verify-otp-mobile.appspot.com",
  messagingSenderId: "986791133927",
  appId: "1:986791133927:web:c0397764ff968d7ad79842",
  measurementId: "G-6ZGP5NZ45P"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
export const auth = getAuth(app);
export const storage = getStorage(app);
