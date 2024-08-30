import React, { Children } from 'react';
import Header from '../../layouts/header/header';
import Footer from '../../layouts/footer/footer';


export default function Screen ({ children }) {
  return (
    <>
      <div className="flex flex-col h-screen">
        <Header />
        <div className='py-12'>
          {children}
        </div>
        <Footer />
      </div>
    </>
  );
}