echo "::welcome::"
echo "This tool attempts to make ZeroTier service/process/device stop and start"
echo "----------------------------------------------------------"
echo "version 0.2 No Warranty"
echo "----------------------------------------------------------"
sleep 3;

#Variables to adjust if something isn't working.."
$processName = 'zerotier';
$serviceName = 'ZeroTierOneService';
$zeroEP = 'C:\Program Files (x86)\ZeroTier\One\ZeroTier One.exe';
$zDeviceName = 'ZeroTier One Virtual Port';
$zProcessName = 'ZeroTier One';




$checkProcess = Get-Process "$processName*" -ea SilentlyContinue |select ProcessName -ExpandProperty ProcessName;
$zProcessID = Get-Process "$processName*" |select Id -ExpandProperty Id;
#Should return OK, or someother status
$zDeviceStatus = Get-PnpDevice -FriendlyName "$zDeviceName"|select Status -ExpandProperty Status;

function stopZero { 
    echo "Zerotier appears to be Running"
    $choice = Read-Host 'Would you like to stop ZeroTier? y?'
    if( $choice -eq "y" ) {
        
        echo "Attempting to stop service..."
        sleep 2
        
        sleep 2
        Stop-Process -processname (get-process "$processName*" -ea SilentlyContinue |select ProcessName -ExpandProperty ProcessName ) -Force -Verbose
        sleep 2
        Stop-Service -Name "ZeroTierOneService" -Verbose
        sleep 2
         echo Y | Disable-PnpDevice (Get-PnpDevice -FriendlyName "$zDeviceName"|select InstanceId -ExpandProperty InstanceId) -Verbose
        sleep 2
        if ( $checkProcess ) { 
            echo "stopped..."
            sleep 2
            echo "device status: $zDeviceStatus"
            echo "process id: $zProcessId"
            sleep 3;
        }
        else {
            echo "something went wrong when attempting to check if process exists, this should not happen.";
        }
    }
}

function startZero {
     echo "Zerotier is Not Running"
     $choice2 = Read-Host 'Would you like to start ZeroTier? y?'
     if( $choice2 -eq "y" ) {
        echo "attempting to start service.."
        sleep 3;
        echo Y | Enable-PnpDevice (Get-PnpDevice -FriendlyName "$zDeviceName"|select InstanceId -ExpandProperty InstanceId) -Verbose
        sleep 3;
        Start-Process -FilePath "$zeroEP" -Verbose
        sleep 3;
        Start-Service -Name "$serviceName" -Verbose
        sleep 5
        #Start-Process -processname "$zProcessName" -v
        sleep 2
        if ( ! $checkProcess ) { 
           echo "Zerotier is still not Running"
           }
           else {
            echo "Zerotier is now Running"
            sleep 2;
            echo "device status: $zDeviceStatus"
            echo "process id: $zProcessId"
            sleep 3;
            }
            echo "Zerotier started successfully..."
            sleep 1;   
         }
}


##Main Operations

if ( ! $checkProcess ) {
    startZero;
    echo "process complete..."
}
else {
    stopZero;
    echo "process complete..."
}

echo "bye~!"
sleep 2;