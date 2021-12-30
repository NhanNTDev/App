using System;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

#nullable disable

namespace DiCho.DataService.Models
{
    public partial class DiChoNaoContext : IdentityDbContext<AspNetUsers, AspNetRoles, string,
                                       AspNetUserClaims, AspNetUserRoles, AspNetUserLogins,
                                       AspNetRoleClaims, AspNetUserTokens>
    {
        public DiChoNaoContext()
        {
        }

        public DiChoNaoContext(DbContextOptions<DiChoNaoContext> options)
            : base(options)
        {
        }

        public virtual DbSet<Address> Addresses { get; set; }
        public virtual DbSet<AspNetRoles> AspNetRoles { get; set; }
        public virtual DbSet<AspNetRoleClaims> AspNetRoleClaims { get; set; }
        public virtual DbSet<AspNetUsers> AspNetUsers { get; set; }
        public virtual DbSet<AspNetUserClaims> AspNetUserClaims { get; set; }
        public virtual DbSet<AspNetUserLogins> AspNetUserLogins { get; set; }
        public virtual DbSet<AspNetUserRoles> AspNetUserRoles { get; set; }
        public virtual DbSet<AspNetUserTokens> AspNetUserTokens { get; set; }
        public virtual DbSet<Campaign> Campaigns { get; set; }
        public virtual DbSet<CampaignApply> CampaignApplies { get; set; }
        public virtual DbSet<CampaignDeliveryZone> CampaignDeliveryZones { get; set; }
        public virtual DbSet<ClusteringOrder> ClusteringOrders { get; set; }
        public virtual DbSet<DeliveryZone> DeliveryZones { get; set; }
        public virtual DbSet<Farm> Farms { get; set; }
        public virtual DbSet<FarmArea> FarmAreas { get; set; }
        public virtual DbSet<Feedback> Feedbacks { get; set; }
        public virtual DbSet<Harvest> Harvests { get; set; }
        public virtual DbSet<HarvestCampaign> HarvestCampaigns { get; set; }
        public virtual DbSet<Order> Orders { get; set; }
        public virtual DbSet<OrderItem> OrderItems { get; set; }
        public virtual DbSet<Payment> Payments { get; set; }
        public virtual DbSet<Product> Products { get; set; }
        public virtual DbSet<ProductCategory> ProductCategories { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see http://go.microsoft.com/fwlink/?LinkId=723263.
                optionsBuilder.UseSqlServer("Server=VUONGNGUYEN;Database=DiChoNao;user id=sa;password=123;Trusted_Connection=false;MultipleActiveResultSets=true");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.HasAnnotation("Relational:Collation", "SQL_Latin1_General_CP1_CI_AS");

            modelBuilder.Entity<Address>(entity =>
            {
                entity.ToTable("Address");

                entity.Property(e => e.City).HasMaxLength(256);

                entity.Property(e => e.Country).HasMaxLength(256);

                entity.Property(e => e.CustomerId).HasMaxLength(450);

                entity.Property(e => e.Description).HasMaxLength(500);

                entity.Property(e => e.District).HasMaxLength(256);

                entity.Property(e => e.Email)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.Phone)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.HasOne(d => d.Customer)
                    .WithMany(p => p.Addresses)
                    .HasForeignKey(d => d.CustomerId)
                    .HasConstraintName("FK__Address__Custome__4D5F7D71");

                entity.HasOne(d => d.DeliveryZone)
                    .WithMany(p => p.Addresses)
                    .HasForeignKey(d => d.DeliveryZoneId)
                    .HasConstraintName("FK__Address__Deliver__4E53A1AA");
            });

            modelBuilder.Entity<AspNetRoles>(entity =>
            {
                entity.Property(e => e.Name).HasMaxLength(256);

                entity.Property(e => e.NormalizedName).HasMaxLength(256);
            });

            modelBuilder.Entity<AspNetRoleClaims>(entity =>
            {
                entity.Property(e => e.RoleId)
                    .IsRequired()
                    .HasMaxLength(450);

                entity.HasOne(d => d.Role)
                    .WithMany(p => p.AspNetRoleClaims)
                    .HasForeignKey(d => d.RoleId);
            });

            modelBuilder.Entity<AspNetUsers>(entity =>
            {
                entity.HasIndex(e => e.NormalizedUserName, "UserNameIndex")
                    .IsUnique()
                    .HasFilter("([NormalizedUserName] IS NOT NULL)");

                entity.Property(e => e.Address).HasMaxLength(256);

                entity.Property(e => e.DateOfBirth).HasColumnType("datetime");

                entity.Property(e => e.Email).HasMaxLength(256);

                entity.Property(e => e.Gender).HasMaxLength(10);

                entity.Property(e => e.Image).HasMaxLength(500);

                entity.Property(e => e.Name).HasMaxLength(256);

                entity.Property(e => e.NormalizedEmail).HasMaxLength(256);

                entity.Property(e => e.NormalizedUserName).HasMaxLength(256);

                entity.Property(e => e.ShortName).HasMaxLength(256);

                entity.Property(e => e.UserName).HasMaxLength(256);
            });

            modelBuilder.Entity<AspNetUserClaims>(entity =>
            {
                entity.Property(e => e.UserId)
                    .IsRequired()
                    .HasMaxLength(450);

                entity.HasOne(d => d.User)
                    .WithMany(p => p.AspNetUserClaims)
                    .HasForeignKey(d => d.UserId);
            });

            modelBuilder.Entity<AspNetUserLogins>(entity =>
            {
                entity.HasKey(e => new { e.LoginProvider, e.ProviderKey });

                entity.Property(e => e.UserId)
                    .IsRequired()
                    .HasMaxLength(450);

                entity.HasOne(d => d.User)
                    .WithMany(p => p.AspNetUserLogins)
                    .HasForeignKey(d => d.UserId);
            });

            modelBuilder.Entity<AspNetUserRoles>(entity =>
            {
                entity.HasKey(e => new { e.UserId, e.RoleId });

                entity.HasOne(d => d.Role)
                    .WithMany(p => p.AspNetUserRoles)
                    .HasForeignKey(d => d.RoleId);

                entity.HasOne(d => d.User)
                    .WithMany(p => p.AspNetUserRoles)
                    .HasForeignKey(d => d.UserId);
            });

            modelBuilder.Entity<AspNetUserTokens>(entity =>
            {
                entity.HasKey(e => new { e.UserId, e.LoginProvider, e.Name });

                entity.HasOne(d => d.User)
                    .WithMany(p => p.AspNetUserTokens)
                    .HasForeignKey(d => d.UserId);
            });

            modelBuilder.Entity<Campaign>(entity =>
            {
                entity.ToTable("Campaign");

                entity.Property(e => e.Description).HasMaxLength(500);

                entity.Property(e => e.EndAtt).HasColumnType("datetime");

                entity.Property(e => e.EndRecruitmentAt).HasColumnType("datetime");

                entity.Property(e => e.Image1).HasMaxLength(500);

                entity.Property(e => e.Image2).HasMaxLength(500);

                entity.Property(e => e.Image3).HasMaxLength(500);

                entity.Property(e => e.Image4).HasMaxLength(500);

                entity.Property(e => e.Image5).HasMaxLength(500);

                entity.Property(e => e.Name).HasMaxLength(256);

                entity.Property(e => e.StartAtt).HasColumnType("datetime");

                entity.Property(e => e.StartRecruitmentAt).HasColumnType("datetime");
            });

            modelBuilder.Entity<CampaignApply>(entity =>
            {
                entity.ToTable("CampaignApply");

                entity.HasOne(d => d.Campaign)
                    .WithMany(p => p.CampaignApplies)
                    .HasForeignKey(d => d.CampaignId)
                    .HasConstraintName("FK__CampaignA__Campa__3F115E1A");

                entity.HasOne(d => d.Farm)
                    .WithMany(p => p.CampaignApplies)
                    .HasForeignKey(d => d.FarmId)
                    .HasConstraintName("FK__CampaignA__FarmI__3E1D39E1");
            });

            modelBuilder.Entity<CampaignDeliveryZone>(entity =>
            {
                entity.ToTable("CampaignDeliveryZone");

                entity.HasOne(d => d.Campaign)
                    .WithMany(p => p.CampaignDeliveryZones)
                    .HasForeignKey(d => d.CampaignId)
                    .HasConstraintName("FK__CampaignD__Campa__47A6A41B");

                entity.HasOne(d => d.DeliveryZone)
                    .WithMany(p => p.CampaignDeliveryZones)
                    .HasForeignKey(d => d.DeliveryZoneId)
                    .HasConstraintName("FK__CampaignD__Deliv__489AC854");
            });

            modelBuilder.Entity<ClusteringOrder>(entity =>
            {
                entity.ToTable("ClusteringOrder");

                entity.Property(e => e.CreateAt).HasColumnType("datetime");

                entity.HasOne(d => d.Address)
                    .WithMany(p => p.ClusteringOrders)
                    .HasForeignKey(d => d.AddressId)
                    .HasConstraintName("FK__Clusterin__Addre__531856C7");

                entity.HasOne(d => d.Campaign)
                    .WithMany(p => p.ClusteringOrders)
                    .HasForeignKey(d => d.CampaignId)
                    .HasConstraintName("FK__Clusterin__Campa__5224328E");

                entity.HasOne(d => d.Payment)
                    .WithMany(p => p.ClusteringOrders)
                    .HasForeignKey(d => d.PaymentId)
                    .HasConstraintName("FK__Clusterin__Payme__51300E55");
            });

            modelBuilder.Entity<DeliveryZone>(entity =>
            {
                entity.ToTable("DeliveryZone");

                entity.Property(e => e.Name).HasMaxLength(200);
            });

            modelBuilder.Entity<Farm>(entity =>
            {
                entity.ToTable("Farm");

                entity.Property(e => e.AddAt).HasColumnType("datetime");

                entity.Property(e => e.Address).HasMaxLength(256);

                entity.Property(e => e.Description).HasMaxLength(500);

                entity.Property(e => e.FarmerId).HasMaxLength(450);

                entity.Property(e => e.Image1).HasMaxLength(500);

                entity.Property(e => e.Image2).HasMaxLength(500);

                entity.Property(e => e.Image3).HasMaxLength(500);

                entity.Property(e => e.Image4).HasMaxLength(500);

                entity.Property(e => e.Image5).HasMaxLength(500);

                entity.Property(e => e.Name).HasMaxLength(256);

                entity.HasOne(d => d.FarmArea)
                    .WithMany(p => p.Farms)
                    .HasForeignKey(d => d.FarmAreaId)
                    .HasConstraintName("FK__Farm__FarmAreaId__2FCF1A8A");

                entity.HasOne(d => d.Farmer)
                    .WithMany(p => p.Farms)
                    .HasForeignKey(d => d.FarmerId)
                    .HasConstraintName("FK__Farm__FarmerId__2EDAF651");
            });

            modelBuilder.Entity<FarmArea>(entity =>
            {
                entity.ToTable("FarmArea");

                entity.Property(e => e.Name).HasMaxLength(256);
            });

            modelBuilder.Entity<Feedback>(entity =>
            {
                entity.ToTable("Feedback");

                entity.Property(e => e.Content).HasMaxLength(500);

                entity.Property(e => e.CreateAt).HasColumnType("datetime");

                entity.HasOne(d => d.Orders)
                    .WithMany(p => p.Feedbacks)
                    .HasForeignKey(d => d.OrdersId)
                    .HasConstraintName("FK__Feedback__Orders__59C55456");
            });

            modelBuilder.Entity<Harvest>(entity =>
            {
                entity.ToTable("Harvest");

                entity.Property(e => e.Description).HasMaxLength(500);

                entity.Property(e => e.Name).HasMaxLength(256);

                entity.Property(e => e.StartAt).HasColumnType("datetime");

                entity.HasOne(d => d.Farm)
                    .WithMany(p => p.Harvests)
                    .HasForeignKey(d => d.FarmId)
                    .HasConstraintName("FK__Harvest__FarmId__3864608B");

                entity.HasOne(d => d.Product)
                    .WithMany(p => p.Harvests)
                    .HasForeignKey(d => d.ProductId)
                    .HasConstraintName("FK__Harvest__Product__395884C4");
            });

            modelBuilder.Entity<HarvestCampaign>(entity =>
            {
                entity.ToTable("HarvestCampaign");

                entity.Property(e => e.Unit).HasMaxLength(15);

                entity.HasOne(d => d.CampaignApply)
                    .WithMany(p => p.HarvestCampaigns)
                    .HasForeignKey(d => d.CampaignApplyId)
                    .HasConstraintName("FK__HarvestCa__Campa__42E1EEFE");

                entity.HasOne(d => d.Harvest)
                    .WithMany(p => p.HarvestCampaigns)
                    .HasForeignKey(d => d.HarvestId)
                    .HasConstraintName("FK__HarvestCa__Harve__41EDCAC5");
            });

            modelBuilder.Entity<Order>(entity =>
            {
                entity.Property(e => e.CreateAt).HasColumnType("datetime");

                entity.HasOne(d => d.ClusteringOrder)
                    .WithMany(p => p.Orders)
                    .HasForeignKey(d => d.ClusteringOrderId)
                    .HasConstraintName("FK__Orders__Clusteri__56E8E7AB");

                entity.HasOne(d => d.Farm)
                    .WithMany(p => p.Orders)
                    .HasForeignKey(d => d.FarmId)
                    .HasConstraintName("FK__Orders__FarmId__55F4C372");
            });

            modelBuilder.Entity<OrderItem>(entity =>
            {
                entity.ToTable("OrderItem");

                entity.HasOne(d => d.HarvestCampaign)
                    .WithMany(p => p.OrderItems)
                    .HasForeignKey(d => d.HarvestCampaignId)
                    .HasConstraintName("FK__OrderItem__Harve__5D95E53A");

                entity.HasOne(d => d.Orders)
                    .WithMany(p => p.OrderItems)
                    .HasForeignKey(d => d.OrdersId)
                    .HasConstraintName("FK__OrderItem__Order__5CA1C101");
            });

            modelBuilder.Entity<Payment>(entity =>
            {
                entity.ToTable("Payment");

                entity.Property(e => e.Name).HasMaxLength(256);
            });

            modelBuilder.Entity<Product>(entity =>
            {
                entity.ToTable("Product");

                entity.Property(e => e.Description).HasMaxLength(500);

                entity.Property(e => e.Image1).HasMaxLength(500);

                entity.Property(e => e.Image2).HasMaxLength(500);

                entity.Property(e => e.Image3).HasMaxLength(500);

                entity.Property(e => e.Image4).HasMaxLength(500);

                entity.Property(e => e.Image5).HasMaxLength(500);

                entity.Property(e => e.Name).HasMaxLength(256);

                entity.HasOne(d => d.Farm)
                    .WithMany(p => p.Products)
                    .HasForeignKey(d => d.FarmId)
                    .HasConstraintName("FK__Product__FarmId__3493CFA7");

                entity.HasOne(d => d.ProductCategory)
                    .WithMany(p => p.Products)
                    .HasForeignKey(d => d.ProductCategoryId)
                    .HasConstraintName("FK__Product__Product__3587F3E0");
            });

            modelBuilder.Entity<ProductCategory>(entity =>
            {
                entity.ToTable("ProductCategory");

                entity.Property(e => e.Description).HasMaxLength(500);

                entity.Property(e => e.Image).HasMaxLength(500);

                entity.Property(e => e.Name).HasMaxLength(256);
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
