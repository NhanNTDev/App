import Banner from "../components/Banner";
import CenterBanner from "../components/CenterBanner";
import ItemGroup from "../components/ItemGroup";
import TopCategory from "../components/TopCategory";

const Home = () => {
    return (
        <>
            <Banner></Banner>
            <TopCategory></TopCategory>
            <ItemGroup></ItemGroup>
            <CenterBanner></CenterBanner>
            <ItemGroup></ItemGroup>
        </>

    )
}

export default Home;