

const TopBanner = () => {
    const baners = [
        {
            id: "1",
            image: "/img/slider/slider1.PNG",
        },
        {
            id: "2",
            image: "/img/slider/slider2.PNG",
        },
        {
            id: "3",
            image: "/img/slider/slider1.PNG",
        },
        {
            id: "4",
            image: "/img/slider/slider2.PNG",
        },
        {
            id: "5",
            image: "/img/slider/slider1.PNG",
        }
    ]

    function renderBaner (props) {
        return (
            <div className="item" key={props.id}>
            <a href="shop.html">
                <img
                    className="img-fluid"
                    src={props.image}
                    alt="First slide"
                />
            </a>
        </div>
        )
    }
    
    return (
        <>
            <section className="carousel-slider-main text-center border-top border-bottom bg-white">
                <div className="owl-carousel owl-carousel-slider">
                    {
                        baners.map((baner) => renderBaner({...baner}))
                    }                   
                </div>
            </section>
        </>
    );
}

export default TopBanner;