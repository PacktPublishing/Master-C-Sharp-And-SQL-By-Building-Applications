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
    class StudentCommand
    {
        private string _connectionString;

        public StudentCommand(string connectionString)
        {
            _connectionString = connectionString;
        }

        public IList<StudentModel> GetList()
        {
            List<StudentModel> students = new List<StudentModel>();

            var sql = "Student_GetList";

            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                students = connection.Query<StudentModel>(sql).ToList();
            }

            return students;
        }
    }
}
