using glovo_webapi.Entities;
using MailKit.Net.Smtp;
using MimeKit;

namespace glovo_webapi.Utils
{
    public static class MailSender
    {
        private static readonly string recoveryMailAccount = "glovopwdrecov@gmail.com";
        
        public static void SendRecoveryMail(User user, string recoveryToken)
        {
            //Send mail with mail and token link
            var message = new MimeMessage ();
            message.From.Add (new MailboxAddress ("Komet Account Recovery Bot", recoveryMailAccount));
            message.To.Add (new MailboxAddress (user.Name, user.Email));
            message.Subject = "Restore Komet Account Password";

            string link = "http://komet.cat/#/reset-password/" + user.Email + "/" + recoveryToken;
            message.Body = new TextPart ("plain") {
                Text = "A password restoration of your account has been issued. If you want to change your password, go to this link:\n" + link
            };

            using (var client = new SmtpClient ()) {
                client.Connect ("smtp.gmail.com", 587, false);
                client.Authenticate ("kometpwdrecov@gmail.com", "glovodevpassword");
                client.Send (message);
                client.Disconnect (true);
            }
        }
        
    }
}
