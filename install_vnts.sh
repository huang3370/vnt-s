
#!/bin/bash

# 下载并解压VNT客户端
wget https://github.com/vnt-dev/vnts/releases/download/v1.2.12/vnts-x86_64-unknown-linux-musl-v1.2.12.tar.gz
tar -zxvf vnts-x86_64-unknown-linux-musl-v1.2.12.tar.gz
cd vnts-x86_64-unknown-linux-musl-v1.2.12.tar.gz

# 提示用户输入自定义参数
echo "自定义虚拟IP默认直接回车下一步-例如-g空格192.168.x.x："
read ip
echo "开启--wg空格私密不使用直接下一步："
read wg

# 创建一个服务文件
cat <<EOF > /etc/systemd/system/vnts-cli.service
[Unit]
Description=VNT CLI Service
After=network.target

[Service]
Type=simple
ExecStart=/root/vnts $ip $wg

Restart=always
User=root
Group=root

[Install]
WantedBy=multi-user.target
EOF

# 重新加载systemd配置
systemctl daemon-reload

# 启用并启动服务
systemctl enable vnts-cli.service
systemctl start vnts-cli.service

echo "VNTS客户端安装并设置开机自启动完成！"
