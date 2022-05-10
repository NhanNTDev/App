

const TopBanner = () => {
    const baners = [
        {
            id: "1",
            image: "/img/slider/slider_1.jpg",
        },
        {
            id: "2",
            image: "/img/slider/slider_2.jpg",
        },
        {
            id: "3",
            image: "/img/slider/slider_3.jpg",
        },
        {
            id: "4",
            image: "/img/slider/slider_4.jpg",
        },
        {
            id: "5",
            image: "/img/slider/slider_1.jpg",
        }
    ]

    function renderBaner (props) {
        return (
            <div className="item" key={props.id}>
            <a href="#">
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