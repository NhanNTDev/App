const TopCategory = () => {
    const categories = [
        {
            id: "1",
            title: "Rau Sạch",
            totalItem: "100",
            image: "img/small/1.jpg",
        },
        {
            id: "2",
            title: "Trái Cây",
            totalItem: "100",
            image: "img/small/1.jpg",
        },
        {
            id: "3",
            title: "Củ",
            totalItem: "100",
            image: "img/small/1.jpg",
        },
        {
            id: "4",
            title: "Hoa Tươi",
            totalItem: "100",
            image: "img/small/1.jpg",
        },
        {
            id: "5",
            title: "Rau Sạch",
            totalItem: "100",
            image: "img/small/1.jpg",
        },
        {
            id: "6",
            title: "Củ",
            totalItem: "100",
            image: "img/small/1.jpg",
        },
        {
            id: "7",
            title: "Trái Cây",
            totalItem: "100",
            image: "img/small/1.jpg",
        },
        {
            id: "8",
            title: "Hoa Tươi",
            totalItem: "100",
            image: "img/small/1.jpg",
        },
        {
            id: "9",
            title: "Củ",
            totalItem: "100",
            image: "img/small/1.jpg",
        },
        {
            id: "10",
            title: "Trái Cây",
            totalItem: "100",
            image: "img/small/1.jpg",
        },
        {
            id: "11",
            title: "Hoa Tươi",
            totalItem: "100",
            image: "img/small/1.jpg",
        }
    ]

    const renderItem = (props) => {
        console.log("renderItems")
        return (
            <div className="item" key={props.id}>
                <div className="category-item">
                    <a href="shop.html">
                        <img className="img-fluid" src={props.image} alt="" />
                        <h6>{props.title}</h6>
                        <p>{props.totalItem} Sản Phẩm</p>
                    </a>
                </div>
            </div>
        )
    }
    return (
        <>
            <section className="top-category section-padding">
                <div className="container">
                    <div className="owl-carousel owl-carousel-category">
                        {
                            categories.map((category) => renderItem({...category}))
                        }                        
                    </div>
                </div>
            </section>
        </>
    )
}

export default TopCategory;