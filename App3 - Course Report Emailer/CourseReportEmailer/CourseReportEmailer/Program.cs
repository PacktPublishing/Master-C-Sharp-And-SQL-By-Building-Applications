using CourseReportEmailer.Models;
using CourseReportEmailer.Repository;
using CourseReportEmailer.Workers;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;

namespace CourseReportEmailer
{
    class Program
    {
        static void Main(string[] args)
        {
            try
            {
                EnrollmentDetailReportCommand command = new EnrollmentDetailReportCommand(@"Data Source=localhost;Initial Catalog=CourseReport;Integrated Security=True");
                IList<EnrollmentDetailReportModel> models = command.GetList();

                var reportFileName = "EnrollmentDetailsReport.xlsx";
                EnrollmentDetailReportSpreadSheetCreator enrollmentSheetCreator = new EnrollmentDetailReportSpreadSheetCreator();
                enrollmentSheetCreator.Create(reportFileName, models);

                EnrollmentDetailReportEmailSender emailer = new EnrollmentDetailReportEmailSender();
                emailer.Send(reportFileName);
            }
            catch (Exception ex)
            {
                Console.WriteLine("Something went wrong: {0}", ex.Message);
            }
        }
    }
}
