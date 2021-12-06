import Banner from "../components/Banner";
import CenterBanner from "../components/CenterBanner";
import Footer from "../components/Footer";
import Header from "../components/Header"
import ItemGroup from "../components/ItemGroup";
import TopCategory from "../components/TopCategory";

const Home = () => {
    return (
        <>
            <Header></Header>
            <Banner></Banner>
            <TopCategory></TopCategory>
            <ItemGroup></ItemGroup>
            <CenterBanner></CenterBanner>
            <ItemGroup></ItemGroup>
            <Footer></Footer>
        </>

    )
}

export default Home;