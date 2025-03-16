using WeLoveMushrooms.Models;

namespace WeLoveMushrooms.Services;

public interface INewsletterService
{
    Task<OperationResult> SignUpForNewsletterAsync(Subscriber subscriber);
    Task<OperationResult> OptOutFromNewsletterAsync(string email);
    Task<IEnumerable<Subscriber>> GetActiveSubscribersAsync();
}