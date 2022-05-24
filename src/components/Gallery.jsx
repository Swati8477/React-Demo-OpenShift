import React from "react";
import "../components/tab.css";
import Menu from "./Menu";

const Gallery = () => {
    return (
        <>
            <h1 className="mt-5 text-center main-heading"> Order your favourite Dish</h1>
            <hr />

            <div className="menu-tabs container">
                <div className="menu-tab d-flex justify-cintent-around">
                    <button className="btn btn-warning"> Breakfast</button>
                    <button className="btn btn-warning"> Lunch</button>
                    <button className="btn btn-warning"> Snacks</button>
                    <button className="btn btn-warning"> Dinner</button>
                    <button className="btn btn-warning"> All</button>
                </div>
            </div>

            {/*  My main items section */}

            <div className="menu-items container-fluid mt-5">
                <div className="row">
                    <div className="col-11 mx-auto">
                        <div className="row my-5">
                            <div className="item col-12 col-md-6 col-lg-6 col-xl-4">
                                <div className="row Item-inside">
                                    <div className="col-12 col-md-12 col-lg-4 img-div">
                                        <img src="menu.jpg" alt="menuPic" className="img-fluid" />
                                    </div>
                                    {/*  Menu description */}

                                    <div className="col-12 col-md-12 col-lg-8">
                                        <div className="main-title pt-4 pb-3">
                                            <h1> maggie</h1>
                                            <p> Maggi 2-Minutes Noodles have been a classic Indian snack for a good few decades now. 
                                                Nestle brings you another delicious instant food product - Maggi 2-Minute Masala Instant Noodles!  </p>
                                            <div className="menu-price-book">
                                                <div className="price-book-divide d-flex justify-content-between align-items-center">
                                                    <h2> Price: 12Rs</h2>
                                                    <a href="#">
                                                        <button className="btn btn-primary"> Order Now</button>
                                                    </a>
                                                </div>
                                                <p>*Prices may vary on selected date.</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </>
    )
}

export default Gallery;