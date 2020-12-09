namespace glovo_webapi.Models.Users
{
    
    //Receive
    public class UpdateUserModel
    {
        public string Name { get; set; }
        public string Email { get; set; }

        public UpdateUserModel() {}

        public UpdateUserModel(string name, string email)
        {
            Name = name;
            Email = email;
        }
    }
}