function Get-UrlFile 
{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true)]
        $Url,

        [string]$FilePath
    )

    if ([string]::IsNullOrWhiteSpace($FilePath))
    {
        $FilePath = [string]::Format("{0}\{1}", (Get-Location).Path, [System.IO.Path]::GetFileName($Url)) 
    }

    try
    {
        Write-Debug "Fetching file located at: $Url"
        Write-Debug "File will be saved at: $FilePath"
        (New-Object System.Net.WebClient).DownloadFile($Url, $FilePath)
    }
    catch [System.Exception]
    {
        # for some reason string interpolation returns the object type... look further into it
        Write-Host ("Error, " + $_.Exception.Message) -ForegroundColor Red
        if ($_.Exception.InnerException -ne $null)
        {
            Write-Host ("- Inner Error: " + $_.Exception.InnerException.Message) -ForegroundColor Red
        } 
    }  
}
Set-Alias wget Get-UrlFile