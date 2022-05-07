#!/usr/bin/env bash

#此脚本需要依赖外部脚本，这是外部脚本的链接
url() {
wget -P /root -N -q --no-check-certificate "https://raw.githubusercontent.com/mack-a/v2ray-agent/master/install.sh" && chmod 700 /root/install.sh && /root/install.sh
}

#定义字体颜色
#红色
red() {
if [ "$1" == "read" ];then
      color= echo -e "\033[31m$2\033[0m"
      read -p "$color"
elif [ "$1" == "txt" ];then
      echo -e "\033[31m$2\033[0m"
fi
}

#绿色
green() {
if [ "$1" == "read" ];then
      color= echo -e "\033[32m$2\033[0m"
      read -r -p "$color" myStr
elif [ "$1" == "txt" ];then
      echo -e "\033[32m$2\033[0m"
fi
}

#黄色
yellow() {
if [ "$1" == "txt" ];then
      echo -e "\033[33m$2\033[0m"
fi
}

#蓝色
blue() {
if [ "$1" == "txt" ];then
      echo -e "\033[34m$2\033[0m"
fi
}

#紫色
purple() {
if [ "$1" == "txt" ];then
      echo -e "\033[35m$2\033[0m"
fi
}

#天蓝色
skyblue() {
if [ "$1" == "txt" ];then
      echo -e "\033[36m$2\033[0m"
fi
}

#白色
white() {
if [ "$1" == "txt" ];then
      echo -e "\033[37m$2\033[0m"
fi
}

#创建伪装站点软链接
link() {
if [ -L /www/wwwroot/$myStr ];then
    unlink /www/wwwroot/$myStr
    ln -s /usr/share/nginx/html /www/wwwroot/$myStr
else
    ln -s /usr/share/nginx/html /www/wwwroot/$myStr
fi
}

compack1() {
#移动系统文件
if [ -e /usr/share/nginx/html/.user.ini ];then
chattr -i /usr/share/nginx/html/.user.ini
mv /usr/share/nginx/html/.user.ini /usr/share/nginx

#下载v2ray安装脚本
url && mv /usr/share/nginx/.user.ini /usr/share/nginx/html
exit 0
else

#下载v2ray安装脚本
url
exit 0
fi
}

compack2() {
#选择域名
echo ""
green txt "此证书支持以下域名（*表示通配符，表示所有二级域名）："
echo ""
yellow txt "bywwh.com,*.bywwh.com"
echo ""
yellow txt "bywwh.top,*.bywwh.top"
echo ""
yellow txt "wei.bio,*.wei.bio"
echo ""
yellow txt "wwh.ink,*.wwh.ink"
echo ""
green read "请输入你的域名:"
echo ""
yellow txt "待配置的域名：$myStr"
echo ""

#创建v2ray证书目录
rm -rf /etc/v2ray-agent
mkdir -p /etc/v2ray-agent/tls

#创建宝塔面板证书目录
mkdir -p /www/server/panel/vhost/cert/$myStr

#复制证书文件
cp /root/SSL-CERT/*.crt /etc/v2ray-agent/tls/$myStr.crt
cp /root/SSL-CERT/*.key /etc/v2ray-agent/tls/$myStr.key
cp /root/SSL-CERT/*.crt /www/server/panel/vhost/cert/$myStr/fullchain.pem
cp /root/SSL-CERT/*.key /www/server/panel/vhost/cert/$myStr/privkey.pem

#删除伪装站点
if [ -d /usr/share/nginx/html ];then
if [ -e /usr/share/nginx/html/.user.ini ];then
chattr -i /usr/share/nginx/html/.user.ini
rm -rf /usr/share/nginx/html
else
rm -rf /usr/share/nginx/html
fi
fi

#创建脚本快捷方式
if [ -e /usr/local/sbin/ssl ];then
     rm -rf /usr/local/sbin/ssl
     ln -s /root/SSL-CERT/ssl-install.sh /usr/local/sbin/ssl
else
     ln -s /root/SSL-CERT/ssl-install.sh /usr/local/sbin/ssl
fi
green txt "快捷方式已创建，可执行[ssl]重新打开脚本"
echo ""

#注意事项
red read "注意：若要使用自定义证书，请在安装证书时选择[n]，按回车键继续"

#下载v2ray安装脚本
url
}

compack3() {
echo ""
green txt "请在宝塔面板添加以下站点："
yellow txt "$myStr"
echo ""
green txt "然后在站点部署SSL证书时选择“其他证书”，保存即可。"
echo ""

#修改nginx用户
sed -i '/^user  /s/.*/user  '"root root;"'/' /www/server/nginx/conf/nginx.conf
}

#判断是否已安装
echo ""
if [ -e /etc/v2ray-agent/backup_crontab.cron ];then
green read "检测到证书已安装，是否需要重新安装?[y/n]:"
     if [ "$myStr" == "y" ]; then
          compack2
     else
          compack1
     fi
else
          compack2
fi

if [ -e /etc/v2ray-agent/backup_crontab.cron ];then
     compack3
fi
link
