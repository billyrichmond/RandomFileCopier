#$path = "D:\E_Root\b\BRA03108\jsa\April 2011 Production\Not associated with Negotiations\Network Files\WrapModeling\TCEQ SysOps Files\Received 3-10-10\Executed\Allens Monthly Limit Only\July 2010 version\Whitney Min by Reducing Yield";


Function Update-Log($logPath, $message)
{
    try
    {
        $logStream = New-Object System.IO.StreamWriter($logPath, $True);
        $logStream.WriteLine($message);
    }
    catch
    {
        Write-Host "Error writing log file." -ForegroundColor Red;
    }
    finally
    {
        $logStream.Close();
    }
} 


Clear-Host;
$logDate 		= Get-Date -Format "yyyyMMddHHmmss";
$logPath 		= "C:\Utilities\Random File Copier\Logs";
$logName 		= "RFC_{0}.log" -f $logDate;
$targetRoot 	= "G:\";

$logPathValid = Test-Path $logPath;
if($logPathValid)
{
    $logFileName = Join-Path $logPath $logName;
    [array]$directoryList = Get-Content "C:\Utilities\Random File Copier\directories10000.txt";  
	$directoryCount = $directoryList.Count;
    
    for ($i = 1; $i -le 1; $i++)
    {
		for ($n = 0; $n -le $directoryCount -1; $n++)
		{
			$directoryName = $directoryList[$n].ToString();	
			$newParentDirectory = $directoryName.Substring(0,18);
			#$tempDir = $targetRoot + $newParentDirectory + $directoryName.Substring(2);
			#$targetDir = [System.IO.Directory]::CreateDirectory($targetRoot + $directoryName + "\" + $directoryName.Substring(6));
			$targetDir = [System.IO.Directory]::CreateDirectory($targetRoot + $newParentDirectory + "\" + $directoryName);
			#$targetDir = [System.IO.Directory]::CreateDirectory($targetRoot + $directoryName);
        	$validPath = Test-Path $targetDir.FullName;
        	if($validPath)
        	{
            	$date = Get-Date -Format "yyyyMMddHHmmss.ffffff";
            	#$sourceFile = Get-ChildItem "C:\Utilities\Random File Copier\Assets\*.*"				
				
				#$file = [System.IO.File]::Create($targetDir.FullName + "\" + $fileName);
            	#$file.SetLength($iFileSize); 
            	
				Copy-Item "C:\Utilities\Random File Copier\Assets\*.*" $targetDir.FullName;
            	#$message = (Join-Path $targetDir.FullName $fileName) + "," + $fileSize + "," + $iFileSize; 
            	Write-Host ("{0} File copied to directory:  {1}" -f ($fileCount = $n+1), $targetDir.FullName) -ForegroundColor Green;
            	Update-Log $logFileName $message;
            	#Start-Sleep -s 1;
        	}
        	else
        	{
            	Clear-Host;  
            	Write-Host "`Directory path does not exist.  Create directory or update script and try again." -ForegroundColor Red;
        	}
        	#$file.Close();
		}
    }    
    #$file.Close();
}
else
{
    Clear-Host;  
    Write-Host "`Log directory path does not exist.  Create directory or update script and try again." -ForegroundColor Red;
}






