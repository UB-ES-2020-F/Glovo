namespace glovo_webapi.Models.Users
{
    public class PasswordEmailModel
    {
        public string Email { get; set; }
        
        public PasswordEmailModel() {}

        public PasswordEmailModel(string email)
        {
            Email = email;
        }
    }
}