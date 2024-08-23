$Username = Read-Host 'Enter the from email address: '
$Password = Read-Host 'Enter the password: '
$HostCust = Read-Host 'Enter the email host: ';
$PortCust = Read-Host 'Enter the email port: ';
$Path = Read-Host 'Enter the attachment path: ';
$Recipient = Read-Host 'Enter the recipient email address: ';


function Send-ToEmail([string]$email, [string]$attachmentpath){

    try {
        $message = New-Object Net.Mail.MailMessage
        $message.From = $Username
        $message.To.Add($email)
        $message.Subject = Read-Host 'Enter the subject: '
        $message.Body = Read-Host 'Enter the body: '
        
        if (Test-Path $attachmentpath) {
            $attachment = New-Object Net.Mail.Attachment($attachmentpath)
            $message.Attachments.Add($attachment)
        } else {
            Write-Host "Attachment path is invalid."
        }
        
        $smtp = New-Object Net.Mail.SmtpClient($HostCust, $PortCust)
        $smtp.EnableSSL = $true
        $smtp.Credentials = New-Object System.Net.NetworkCredential($Username, $Password)
        
        # Attempt to send the email
        $smtp.Send($message)
        
        Write-Host "Email sent successfully."
    }
    catch {
        Write-Host "Failed to send email. Error message: $_"
    }
    finally {
        # Dispose of resources
        $message.Dispose()
        if ($message.Attachments.Count -gt 0) {
            $message.Attachments.Dispose()
        }
    }    
 }
Send-ToEmail  -email $Recipient -attachmentpath $Path;