$Username = Read-Host 'Enter the from email address: '
$Password = Read-Host 'Enter the password: '
$HostCust = Read-Host 'Enter the email host: ';
$PortCust = Read-Host 'Enter the email port: ';
$Path = Read-Host 'Enter the attachment path: ';
$Recipient = Read-Host 'Enter the recipient email address: ';


function Send-ToEmail([string]$email, [string]$attachmentpath){

    $message = new-object Net.Mail.MailMessage;
    $message.From = $Username;
    $message.To.Add($email);
    $message.Subject = Read-Host 'Enter the subject: '
    $message.Body = Read-Host 'Enter the body: '
    $attachment = New-Object Net.Mail.Attachment($attachmentpath);
    $message.Attachments.Add($attachment);
    $smtp = new-object Net.Mail.SmtpClient($HostCust, $PortCust);
    $smtp.EnableSSL = $true;
    $smtp.Credentials = New-Object System.Net.NetworkCredential($Username, $Password);
    $smtp.send($message);
    write-host "Mail Sent" ; 
    $attachment.Dispose();
 }
Send-ToEmail  -email $Recipient -attachmentpath $Path;