echo "::welcome::"
echo "This tool attempts to make ZeroTier service stop and start"
echo "----------------------------------------------------------"
echo "version 0.1 No Warranty"
echo "----------------------------------------------------------"
sleep 3;

$checkProcess = get-process "zerotier*" -ea SilentlyContinue |select ProcessName -ExpandProperty ProcessName;


 
    function stopZero { 
    echo "Zerotier appears to be Running"
    #echo ( get-process "zerotier*" -ea SilentlyContinue |select ProcessName -ExpandProperty ProcessName )
    $choice = Read-Host 'Would you like to stop ZeroTier? y?'
    if($choice -eq "y"){
        echo "Attempting to stop service"
        sleep 2
        Stop-Process -processname (get-process "zerotier*" -ea SilentlyContinue |select ProcessName -ExpandProperty ProcessName ) -Force -v
        Stop-Service -Name "ZeroTierOneService" -v
        sleep 2
        if((get-process "zerotier*" -ea SilentlyContinue |select ProcessName -ExpandProperty ProcessName) -eq $Null){ 
        echo "stopped"
        sleep 2
        }
        else {
                echo "something went wrong when attempting to check if process exists, this should not happen"
                }
        }
    }


if ( ! $checkProcess ) { 
        $isnull++
        echo "Zerotier is Not Running"
        $choice2 = Read-Host 'Would you like to start ZeroTier? y?'
        if($choice -eq "y"){
            echo "attempting to start service"
            sleep 2
            Start-Process -FilePath "C:\Program Files (x86)\ZeroTier\One\ZeroTier One.exe"
            Start-Service -Name "ZeroTierOneService"
            echo "Zerotier started successfully"
            Start-Process -processname "ZeroTier One"
            }
}else{
    stopZero;
}