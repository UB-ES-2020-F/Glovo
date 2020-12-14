namespace glovo_webapi.Models.Users
{
    
    //Send
    public class UserModel
    {
        public int Id { get; set; }
        public string Email { get; set; }
        public string Name { get; set; }

        public UserModel() {}
        
        public UserModel(int id, string email, string name)
        {
            Id = id;
            Email = email;
            Name = name;
        }
    }
}