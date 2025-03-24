using System.ComponentModel.DataAnnotations;
using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;

namespace WeLoveMushrooms.Models
{
    public class Subscriber
    {
        [BsonId]
        [BsonRepresentation(BsonType.ObjectId)]
        public string? Id { get; set; }

        [BsonElement("name")]  // 👈 matchar med MongoDB-fältet "name"
        [Required]
        [StringLength(20, ErrorMessage = "Name cannot exceed 20 characters")]
        public string? Name { get; set; }

        [BsonElement("email")]  // 👈 matchar med MongoDB-fältet "email"
        [Required]
        [EmailAddress]
        [RegularExpression("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$", ErrorMessage = "Missing top level domain")]
        public string? Email { get; set; }

        [BsonElement("isActive")]  // 👈 matchar med MongoDB-fältet "isActive"
        public bool IsActive { get; set; }
    }
}
