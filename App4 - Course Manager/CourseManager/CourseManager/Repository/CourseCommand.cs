using CourseManager.Models;
using Dapper;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CourseManager.Repository
{
    class CourseCommand
    {
        private string _connectionString;

        public CourseCommand(string connectionString)
        {
            _connectionString = connectionString;
        }

        public IList<CourseModel> GetList()
        {
            List<CourseModel> courses = new List<CourseModel>();

            var sql = "Course_GetList";

            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                courses = connection.Query<CourseModel>(sql).ToList();
            }

            return courses;
        }
    }
}
