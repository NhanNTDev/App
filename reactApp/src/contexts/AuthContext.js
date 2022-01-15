import React, { createContext, useState } from 'react'
import { Navigate, useNavigate } from 'react-router-dom';
import userApi from '../apis/userApi';
// Initiate Context
const AuthContext = createContext();
// Provide Context
export const AuthProvider = ({ children }) => {
  const [user, setUser] = useState(null);
  const [isAuthen, setIsAuthen] = useState(false);
  
  return (
    <AuthContext.Provider value={{ user, isAuthen, setUser, setIsAuthen }}>
      {children}
    </AuthContext.Provider>
  )
}

export default AuthContext;