# 获取WSL IP地址
$wslIP = wsl hostname -I | Out-String
$wslIP = $wslIP.Trim()  # 清除多余的空白字符

# 检查IP地址是否被正确获取
if (-Not $wslIP) {
    Write-Error "Failed to retrieve WSL IP address."
    exit
}

# 删除现有的端口转发规则
netsh interface portproxy delete v4tov4 listenaddress=0.0.0.0 listenport=1022

# 添加新的端口转发规则
netsh interface portproxy add v4tov4 listenaddress=0.0.0.0 listenport=1022 connectaddress=$wslIP connectport=1022
Write-Output "Port forwarding set up successfully to WSL IP address $wslIP on port 1022."
