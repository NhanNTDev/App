import Banner from "../components/Banner";
import CenterBanner from "../components/CenterBanner";
import ItemGroup from "../components/ItemGroup";
import TopCategory from "../components/TopCategory";
import { runScript } from "../utils/Common";
import { weeklyCampaign, hotCampaign } from "../constants/Data";


const Home = () => {
    runScript()
    const weeklyCampaigns = weeklyCampaign;
    const hotCampaigns = hotCampaign;
    
    return (
        <>
            <Banner></Banner>
            <TopCategory></TopCategory>
            <ItemGroup title="Chiến dịch trong tuần" listCampaigns={weeklyCampaigns} type="weekly"></ItemGroup>
            <CenterBanner></CenterBanner>
            <ItemGroup title="Chiến dịch hot" listCampaigns={hotCampaigns} type="hot"></ItemGroup>
        </>

    )
}

export default Home;