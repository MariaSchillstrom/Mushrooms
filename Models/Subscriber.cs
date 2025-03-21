using System;
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

        [Required]
        [StringLength(20, ErrorMessage = "Name cannot exceed 20 characters")]
        public string? Name { get; set; }

        [Required]
        [EmailAddress]
        [RegularExpression("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$", ErrorMessage = "Missing top level domain")]
        public string? Email { get; set; }
    }
}
