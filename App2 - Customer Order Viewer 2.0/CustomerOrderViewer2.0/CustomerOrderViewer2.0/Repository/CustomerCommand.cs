using CustomerOrderViewer2._0.Models;
using Dapper;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace CustomerOrderViewer2._0.Repository
{
    class CustomerCommand
    {
        private string _connectionString;

        public CustomerCommand(string connectionString)
        {
            _connectionString = connectionString;
        }

        public IList<CustomerModel> GetList()
        {
            List<CustomerModel> customers = new List<CustomerModel>();

            var sql = "Customer_GetList";

            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                customers = connection.Query<CustomerModel>(sql).ToList();
            }

            return customers;
        }

    }
}
