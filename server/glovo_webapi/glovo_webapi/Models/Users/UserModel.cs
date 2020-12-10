namespace glovo_webapi.Models.Users
{
    
    //Send
    public class UserModel
    {
        public int Id { get; set; }
        public string Email { get; set; }
        public string Name { get; set; }

        
        public UserModel(int id, string email, string name)
        {
            this.Id = id;
            this.Email = email;
            this.Name = name;
        }
    }
}