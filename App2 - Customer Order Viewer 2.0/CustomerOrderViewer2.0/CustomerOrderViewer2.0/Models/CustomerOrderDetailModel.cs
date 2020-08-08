using System;
using System.Collections.Generic;
using System.Text;

namespace CustomerOrderViewer2._0.Models
{
    class CustomerOrderDetailModel
    {
        public int CustomerOrderId { get; set; }

        public int CustomerId { get; set; }

        public int ItemId { get; set; }

        public string FirstName { get; set; }

        public string LastName { get; set; }

        public string Description { get; set; }

        public decimal Price { get; set; }
    }
}
