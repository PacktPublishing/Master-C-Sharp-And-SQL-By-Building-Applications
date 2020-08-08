using System;
using System.Collections.Generic;
using System.Net;
using System.Net.Mail;
using System.Text;

namespace CourseReportEmailer.Workers
{
    class EnrollmentDetailReportEmailSender
    {
        public void Send(string fileName)
        {
            SmtpClient client = new SmtpClient("smtp-mail.outlook.com");
            client.Port = 587;
            client.DeliveryMethod = SmtpDeliveryMethod.Network;
            client.UseDefaultCredentials = false;

            NetworkCredential creds = new NetworkCredential("[Your Email]", "[Your Password]");
            client.EnableSsl = true;
            client.Credentials = creds;

            MailMessage message = new MailMessage("[Your Email]", "[Send To Email]");
            message.Subject = "Enrollment Details Report";
            message.IsBodyHtml = true;
            message.Body = "Hi,<br><br>Attached please find the enrollment details report.<br><br>Please let me know if there are any questions.<br><br>Best,<br><br>Avetis";

            Attachment attachment = new Attachment(fileName);
            message.Attachments.Add(attachment);

            client.Send(message);
        }
    }
}
