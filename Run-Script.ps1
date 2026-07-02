$ping = Start-Process ping -ArgumentList "-t google.com" -NoNewWindow -RedirectStandardOutput "CONOUT$" -PassThru
$count = 0
while (-not $ping.HasExited) {
    Start-Sleep -Milliseconds 100
    $count = (ping google.com -n 1 | Select-String "Reply from").Count + $count
    if ($count -ge 1000) {
        $ping.Kill()
        break
    }
}
