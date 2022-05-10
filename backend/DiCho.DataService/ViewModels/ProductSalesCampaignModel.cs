namespace DiCho.DataService.ViewModels
{
    public class ProductSalesCampaignModel
    {
        public int? Id { get; set; }
        public int? MaxCapacity { get; set; }
        public int? MinCapacity { get; set; }
        public int? ProductSystemId { get; set; }
        public int? CampaignId { get; set; }
    }

    public class ProductSalesCampaignCreateModel
    {
        public int MaxCapacity { get; set; }
        public int MinCapacity { get; set; }
        public int ProductSystemId { get; set; }
    }
    public class ProductSalesCampaignUpdateModel
    {
        public int Id { get; set; }
        public int MaxCapacity { get; set; }
        public int MinCapacity { get; set; }
        public int ProductSystemId { get; set; }
    }

    public class ProductSalesCampaignViewModel
    {
        public int? Id { get; set; }
        public int? MaxCapacity { get; set; }
        public int? MinCapacity { get; set; }
        public int? ProductSystemId { get; set; }
        public virtual ProductSystemCampagin ProductSystem { get; set; }
    }

    public class ProductSalesCampaignDetailModel
    {
        public int? Id { get; set; }
        public string ProductName { get; set; }
        public string Unit { get; set; }
        public int? MaxCapacity { get; set; }
        public int? MinCapacity { get; set; }
    }
}
