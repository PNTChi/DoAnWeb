using System.ComponentModel.DataAnnotations.Schema;

namespace DoAnWeb
{
    /// <summary>
    /// Partial class ?? extend tb_QuangCao v?i custom properties
    /// File này s? không b? ghi ?è khi regenerate EDMX
    /// </summary>
    public partial class tb_QuangCao
    {
        /// <summary>
        /// Alias cho LienKet ?? t??ng thích v?i Views s? d?ng property Link
        /// </summary>
        [NotMapped]
        public string Link
        {
            get { return LienKet; }
            set { LienKet = value; }
        }
    }
}
