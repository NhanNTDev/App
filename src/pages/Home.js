import Banner from "../components/Banner";
import CenterBanner from "../components/CenterBanner";
import ItemGroup from "../components/ItemGroup";
import TopCategory from "../components/TopCategory";
import { runScript } from "../utils/Common";


const Home = () => {
    runScript()
    return (
        <>
            <Banner></Banner>
            <TopCategory></TopCategory>
            <ItemGroup title="Chiến dịch trong tuần"></ItemGroup>
            <CenterBanner></CenterBanner>
            <ItemGroup title="Chiến dịch hot"></ItemGroup>
        </>

    )
}

export default Home;