using CustomerOrderViewer2._0.Models;
using CustomerOrderViewer2._0.Repository;
using System;
using System.Collections.Generic;
using System.Linq;

namespace CustomerOrderViewer2._0
{
    class Program
    {
        private static string _connectionString = @"Data Source=AVOCB59;Initial Catalog=CustomerOrderViewer;Integrated Security=True";
        private static readonly CustomerOrderDetailCommand _customerOrderDetailCommand = new CustomerOrderDetailCommand(_connectionString);
        private static readonly CustomerCommand _customerCommand = new CustomerCommand(_connectionString);
        private static readonly ItemCommand _itemCommand = new ItemCommand(_connectionString);

        static void Main(string[] args)
        {
            try
            {
                var continueManaging = true;
                var userId = string.Empty;

                Console.WriteLine("What is your username?");
                userId = Console.ReadLine();

                do
                {
                    Console.WriteLine("1 - Show All | 2 - Upsert Customer Order | 3 - Delete Customer Order | 4 - Exit");

                    int option = Convert.ToInt32(Console.ReadLine());

                    if (option == 1)
                    {
                        ShowAll();
                    }
                    else if (option == 2)
                    {
                        UpsertCustomerOrder(userId);
                    }
                    else if (option == 3)
                    {
                        DeleteCustomerOrder(userId);
                    }
                    else if (option == 4)
                    {
                        continueManaging = false;
                    }
                    else
                    {
                        Console.WriteLine("Option not found.");
                    }


                } while (continueManaging == true);

            }
            catch (Exception ex)
            {
                Console.WriteLine("Something went wrong: {0}", ex.Message);
            }
        }

        private static void ShowAll()
        {
            Console.WriteLine("{0}All Customer Orders: {1}", Environment.NewLine, Environment.NewLine);
            DisplayCustomerOrders();

            Console.WriteLine("{0}All Customers {1}", Environment.NewLine, Environment.NewLine);
            DisplayCustomers();

            Console.WriteLine("{0}All Items: {1}", Environment.NewLine, Environment.NewLine);
            DisplayItems();

            Console.WriteLine();
        }

        private static void DisplayItems()
        {
            IList<ItemModel> items = _itemCommand.GetList();

            if (items.Any())
            {
                foreach (ItemModel item in items)
                {
                    Console.WriteLine("{0}: Description: {1}, Price {2}", item.ItemId, item.Description, item.Price);
                }
            }
        }

        private static void DisplayCustomers()
        {
            IList<CustomerModel> customers = _customerCommand.GetList();

            if (customers.Any())
            {
                foreach (CustomerModel customer in customers)
                {
                    Console.WriteLine("{0}: First Name: {1}, Middle Name: {2}, Last Name: {3}, Age: {4}", 
                        customer.CustomerId, 
                        customer.FirstName, 
                        customer.MiddleName ?? "N/A",
                        customer.LastName,
                        customer.Age);
                }
            }
        }

        private static void DisplayCustomerOrders()
        {
            IList<CustomerOrderDetailModel> customerOrderDetails = _customerOrderDetailCommand.GetList();

            if (customerOrderDetails.Any())
            {
                foreach (CustomerOrderDetailModel customerOrderDetail in customerOrderDetails)
                {
                    Console.WriteLine(String.Format("{0}: Fullname: {1} {2} (Id: {3}) - purchased {4} for {5} (Id: {6})",
                        customerOrderDetail.CustomerOrderId,
                        customerOrderDetail.FirstName,
                        customerOrderDetail.LastName,
                        customerOrderDetail.CustomerId,
                        customerOrderDetail.Description,
                        customerOrderDetail.Price,
                        customerOrderDetail.ItemId));
                }
            }
        }

        private static void DeleteCustomerOrder(string userId)
        {
            Console.WriteLine("Enter CustomerOrderId:");
            int customerOrderId = Convert.ToInt32(Console.ReadLine());

            _customerOrderDetailCommand.Delete(customerOrderId, userId);
        }

        private static void UpsertCustomerOrder(string userId)
        {
            Console.WriteLine("Note: For updating insert existing CustomerOrderId, for new entries enter -1.");

            Console.WriteLine("Enter CustomerOrderId:");
            int newCustomerOrderId = Convert.ToInt32(Console.ReadLine());

            Console.WriteLine("Enter CustomerId:");
            int newCustomerId = Convert.ToInt32(Console.ReadLine());

            Console.WriteLine("Enter ItemId:");
            int newItemId = Convert.ToInt32(Console.ReadLine());

            _customerOrderDetailCommand.Upsert(newCustomerOrderId, newCustomerId, newItemId, userId);

        }
    }
}
