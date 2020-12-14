namespace glovo_webapi.Models.Users
{
    
    //Send
    public class PasswordResetModel
    {
        public string Email { get; set; }
        public string RecoveryToken { get; set; }
        public string NewPassword { get; set; }
        
        public PasswordResetModel() {}

        public PasswordResetModel(string email, string recoveryToken, string newPassword)
        {
            Email = email;
            RecoveryToken = recoveryToken;
            NewPassword = newPassword;
        }
    }
}