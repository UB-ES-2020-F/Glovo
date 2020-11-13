namespace glovo_webapi.Models.Users
{
    public class UserModel
    {
        public int Id { get; set; }
        public string Email { get; set; }
        public string Name { get; set; }

        
        public UserModel(int Id, string Email, string Name)
        {
            this.Id = Id;
            this.Email = Email;
            this.Name = Name;
        }
    }
}