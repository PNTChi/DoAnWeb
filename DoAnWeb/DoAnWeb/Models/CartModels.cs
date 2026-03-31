using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DoAnWeb.Models
{
    /// <summary>
    /// Model cho m?t item trong gi? hàng
    /// </summary>
    [Serializable]
    public class CartItem
    {
  public int ProductId { get; set; }
        public string ProductName { get; set; }
        public string ProductImage { get; set; }
        public decimal Price { get; set; }
        public int Quantity { get; set; }
        public string Color { get; set; } // Màu s?c ?ã ch?n

        /// <summary>
        /// T?ng giá c?a item (Price * Quantity)
   /// </summary>
        public decimal TotalPrice
        {
            get { return Price * Quantity; }
        }
    }

    /// <summary>
    /// Model cho gi? hàng
    /// </summary>
    [Serializable]
    public class ShoppingCart
    {
        /// <summary>
      /// Danh sách items trong gi? hàng
        /// </summary>
        public List<CartItem> Items { get; set; }

        /// <summary>
        /// Constructor
        /// </summary>
        public ShoppingCart()
    {
      Items = new List<CartItem>();
        }

        /// <summary>
      /// Thêm s?n ph?m vào gi? hàng
        /// </summary>
        public void AddItem(CartItem item)
        {
   // Ki?m tra s?n ph?m ?ã có trong gi? ch?a (cùng ID và màu)
        var existingItem = Items.FirstOrDefault(i => 
 i.ProductId == item.ProductId && 
       i.Color == item.Color);

  if (existingItem != null)
      {
// N?u có r?i thì t?ng s? l??ng
             existingItem.Quantity += item.Quantity;
        }
       else
     {
        // Ch?a có thì thêm m?i
       Items.Add(item);
    }
        }

        /// <summary>
        /// Xóa s?n ph?m kh?i gi? hàng
        /// </summary>
        public void RemoveItem(int productId, string color = null)
        {
            if (string.IsNullOrEmpty(color))
            {
     // Xóa t?t c? items có productId này
    Items.RemoveAll(i => i.ProductId == productId);
       }
       else
    {
      // Xóa item c? th? (productId + color)
     Items.RemoveAll(i => i.ProductId == productId && i.Color == color);
    }
        }

        /// <summary>
        /// C?p nh?t s? l??ng s?n ph?m
/// </summary>
        public void UpdateQuantity(int productId, int quantity, string color = null)
    {
      CartItem item;
     
            if (string.IsNullOrEmpty(color))
        {
        item = Items.FirstOrDefault(i => i.ProductId == productId);
         }
            else
   {
         item = Items.FirstOrDefault(i => i.ProductId == productId && i.Color == color);
     }

   if (item != null)
            {
       if (quantity <= 0)
         {
      // N?u quantity <= 0 thì xóa item
         RemoveItem(productId, color);
      }
           else
          {
         // C?p nh?t s? l??ng
           item.Quantity = quantity;
    }
          }
    }

     /// <summary>
  /// L?y t?ng ti?n c?a gi? hàng
        /// </summary>
        public decimal GetTotal()
        {
  return Items.Sum(i => i.TotalPrice);
        }

        /// <summary>
   /// L?y t?ng s? l??ng s?n ph?m trong gi?
        /// </summary>
        public int GetTotalQuantity()
   {
            return Items.Sum(i => i.Quantity);
        }

    /// <summary>
  /// Xóa toàn b? gi? hàng
      /// </summary>
   public void Clear()
        {
            Items.Clear();
        }

        /// <summary>
        /// Ki?m tra gi? hàng có r?ng không
        /// </summary>
  public bool IsEmpty()
        {
     return Items == null || Items.Count == 0;
    }

        /// <summary>
        /// L?y item theo productId và color
/// </summary>
    public CartItem GetItem(int productId, string color = null)
        {
            if (string.IsNullOrEmpty(color))
      {
      return Items.FirstOrDefault(i => i.ProductId == productId);
            }
 else
     {
       return Items.FirstOrDefault(i => i.ProductId == productId && i.Color == color);
    }
        }
    }
}
