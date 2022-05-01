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
cd /www/wwwroot
if [ -L /www/wwwroot/$myStr ];then
    unlink $myStr
    ln -s /usr/share/nginx/html $myStr
else
    ln -s /usr/share/nginx/html $myStr
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
#创建v2ray证书目录
rm -rf /etc/v2ray-agent
mkdir -p /etc/v2ray-agent/tls
cd /etc/v2ray-agent/tls

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

#创建证书文件
touch $myStr.crt
touch $myStr.key
cat>/etc/v2ray-agent/tls/$myStr.crt <<END
-----BEGIN CERTIFICATE-----
MIIFZzCCBE+gAwIBAgISA1Ze03c3IxPZ0XVzLB6l6tnpMA0GCSqGSIb3DQEBCwUA
MDIxCzAJBgNVBAYTAlVTMRYwFAYDVQQKEw1MZXQncyBFbmNyeXB0MQswCQYDVQQD
EwJSMzAeFw0yMjA0MjExMzU4NDlaFw0yMjA3MjAxMzU4NDhaMBQxEjAQBgNVBAMT
CWJ5d3doLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAKMgPeOm
0+Puqc6sVf3p7+aEaOnm1f5LuAQxTEUyX6eYfdS0OvQyejEho+lv1uCUUhYk2iOm
zz5JhT+Gbsf/4WxFMROsDziuu4k3ITQa/wHVnld9YcNaLjJfsV2poxTBdn3f/L3v
t7oVWdV9vqaCQZ0likA1OK36y7Bx8r5pYgiroJ1+P6j2iwrpdl2PNAZdV6rYaQaf
2TF6KySD5mTBXkjQE/0xbrRvhG3JRwGb244KZUfIb9XPYoHVguOCkRgSey0tuiis
H6kV9T170Zw0ZsVnQrq8EjMKWl4JMTdF6q7ujplt6/q5oWaQ9+MoY7NQPM/eVDql
clnkCU2sNA1DXmECAwEAAaOCApMwggKPMA4GA1UdDwEB/wQEAwIFoDAdBgNVHSUE
FjAUBggrBgEFBQcDAQYIKwYBBQUHAwIwDAYDVR0TAQH/BAIwADAdBgNVHQ4EFgQU
/VugY13S2RCrpoxeT63vkx3csb8wHwYDVR0jBBgwFoAUFC6zF7dYVsuuUAlA5h+v
nYsUwsYwVQYIKwYBBQUHAQEESTBHMCEGCCsGAQUFBzABhhVodHRwOi8vcjMuby5s
ZW5jci5vcmcwIgYIKwYBBQUHMAKGFmh0dHA6Ly9yMy5pLmxlbmNyLm9yZy8wYQYD
VR0RBFowWIILKi5ieXd3aC5jb22CCyouYnl3d2gudG9wggkqLndlaS5iaW+CCSou
d3doLmlua4IJYnl3d2guY29tgglieXd3aC50b3CCB3dlaS5iaW+CB3d3aC5pbmsw
TAYDVR0gBEUwQzAIBgZngQwBAgEwNwYLKwYBBAGC3xMBAQEwKDAmBggrBgEFBQcC
ARYaaHR0cDovL2Nwcy5sZXRzZW5jcnlwdC5vcmcwggEGBgorBgEEAdZ5AgQCBIH3
BIH0APIAdwApeb7wnjk5IfBWc59jpXflvld9nGAK+PlNXSZcJV3HhAAAAYBMogqo
AAAEAwBIMEYCIQDbE25xLPxjlXiRA9DruHc/AVd5cVSPbP+yEzBNqY7JvQIhAIgW
lhadaqIaxoer2kQfF5Ys6+z4Tj1r0HzB+DSlvKKgAHcAb1N2rDHwMRnYmQCkURX/
dxUcEdkCwQApBo2yCJo32RMAAAGATKIMKwAABAMASDBGAiEAoxI0kOmndaj+dIIA
TvyNeMwZ1YbRwBz0HsUPTqVnZrICIQCKXco2s2tWAvUxN2sgroiFH3uRUFWFFqa5
O/6cMT0zEjANBgkqhkiG9w0BAQsFAAOCAQEAYJ2vK95VYsVW/kl3VcB1BjX0XKf9
Kx96qJneG9xiwF52HUrN+RVfvV8yS66MSXbJuyv4Lhl0M679Xre9v5PyIZCBV6hU
09Km9sGsTftPUSq0BdURtef/GWI695ks+JXkiIXFLb0VfAt4ZhyzGevzlQ2awQoW
BJkP8DyPeJZo0sbwFaqUSaliko8C21/WsR9OO2bwcW5dg9B2lXFHlEf01J/QogTH
4b5+/+CpHneFCE7AkG++6l/W3wXX8miRI+8k9btd8nu12WgchiCAJU0l7uCcdOUS
7BJZb48drhY9sgU/VIkI5bc8bQ3klDphktLiXoThyhVne9co7MSPdpI7cg==
-----END CERTIFICATE-----
-----BEGIN CERTIFICATE-----
MIIFFjCCAv6gAwIBAgIRAJErCErPDBinU/bWLiWnX1owDQYJKoZIhvcNAQELBQAw
TzELMAkGA1UEBhMCVVMxKTAnBgNVBAoTIEludGVybmV0IFNlY3VyaXR5IFJlc2Vh
cmNoIEdyb3VwMRUwEwYDVQQDEwxJU1JHIFJvb3QgWDEwHhcNMjAwOTA0MDAwMDAw
WhcNMjUwOTE1MTYwMDAwWjAyMQswCQYDVQQGEwJVUzEWMBQGA1UEChMNTGV0J3Mg
RW5jcnlwdDELMAkGA1UEAxMCUjMwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEK
AoIBAQC7AhUozPaglNMPEuyNVZLD+ILxmaZ6QoinXSaqtSu5xUyxr45r+XXIo9cP
R5QUVTVXjJ6oojkZ9YI8QqlObvU7wy7bjcCwXPNZOOftz2nwWgsbvsCUJCWH+jdx
sxPnHKzhm+/b5DtFUkWWqcFTzjTIUu61ru2P3mBw4qVUq7ZtDpelQDRrK9O8Zutm
NHz6a4uPVymZ+DAXXbpyb/uBxa3Shlg9F8fnCbvxK/eG3MHacV3URuPMrSXBiLxg
Z3Vms/EY96Jc5lP/Ooi2R6X/ExjqmAl3P51T+c8B5fWmcBcUr2Ok/5mzk53cU6cG
/kiFHaFpriV1uxPMUgP17VGhi9sVAgMBAAGjggEIMIIBBDAOBgNVHQ8BAf8EBAMC
AYYwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMBMBIGA1UdEwEB/wQIMAYB
Af8CAQAwHQYDVR0OBBYEFBQusxe3WFbLrlAJQOYfr52LFMLGMB8GA1UdIwQYMBaA
FHm0WeZ7tuXkAXOACIjIGlj26ZtuMDIGCCsGAQUFBwEBBCYwJDAiBggrBgEFBQcw
AoYWaHR0cDovL3gxLmkubGVuY3Iub3JnLzAnBgNVHR8EIDAeMBygGqAYhhZodHRw
Oi8veDEuYy5sZW5jci5vcmcvMCIGA1UdIAQbMBkwCAYGZ4EMAQIBMA0GCysGAQQB
gt8TAQEBMA0GCSqGSIb3DQEBCwUAA4ICAQCFyk5HPqP3hUSFvNVneLKYY611TR6W
PTNlclQtgaDqw+34IL9fzLdwALduO/ZelN7kIJ+m74uyA+eitRY8kc607TkC53wl
ikfmZW4/RvTZ8M6UK+5UzhK8jCdLuMGYL6KvzXGRSgi3yLgjewQtCPkIVz6D2QQz
CkcheAmCJ8MqyJu5zlzyZMjAvnnAT45tRAxekrsu94sQ4egdRCnbWSDtY7kh+BIm
lJNXoB1lBMEKIq4QDUOXoRgffuDghje1WrG9ML+Hbisq/yFOGwXD9RiX8F6sw6W4
avAuvDszue5L3sz85K+EC4Y/wFVDNvZo4TYXao6Z0f+lQKc0t8DQYzk1OXVu8rp2
yJMC6alLbBfODALZvYH7n7do1AZls4I9d1P4jnkDrQoxB3UqQ9hVl3LEKQ73xF1O
yK5GhDDX8oVfGKF5u+decIsH4YaTw7mP3GFxJSqv3+0lUFJoi5Lc5da149p90Ids
hCExroL1+7mryIkXPeFM5TgO9r0rvZaBFOvV2z0gp35Z0+L4WPlbuEjN/lxPFin+
HlUjr8gRsI3qfJOQFy/9rKIJR0Y/8Omwt/8oTWgy1mdeHmmjk7j1nYsvC9JSQ6Zv
MldlTTKB3zhThV1+XWYp6rjd5JW1zbVWEkLNxE7GJThEUG3szgBVGP7pSWTUTsqX
nLRbwHOoq7hHwg==
-----END CERTIFICATE-----
END
cat>/etc/v2ray-agent/tls/$myStr.key <<END
-----BEGIN RSA PRIVATE KEY-----
MIIEogIBAAKCAQEAoyA946bT4+6pzqxV/env5oRo6ebV/ku4BDFMRTJfp5h91LQ6
9DJ6MSGj6W/W4JRSFiTaI6bPPkmFP4Zux//hbEUxE6wPOK67iTchNBr/AdWeV31h
w1ouMl+xXamjFMF2fd/8ve+3uhVZ1X2+poJBnSWKQDU4rfrLsHHyvmliCKugnX4/
qPaLCul2XY80Bl1XqthpBp/ZMXorJIPmZMFeSNAT/TFutG+EbclHAZvbjgplR8hv
1c9igdWC44KRGBJ7LS26KKwfqRX1PXvRnDRmxWdCurwSMwpaXgkxN0Xqru6OmW3r
+rmhZpD34yhjs1A8z95UOqVyWeQJTaw0DUNeYQIDAQABAoIBAA+0vQC8QU6C3iqe
ATGPYp/JQ+ixZw0y8SbGMFfBP+B9GDBwofR9H7K3UHbbY87/uN+U8MPZ/b47ie7R
3Ly48FViXBVOzbBhcoEFo9bGeqMMlFBMLCuI9UW4XPVtrdwDvIrmFAmdmQz7nUim
8MJLbFHbGXKRLUHjEdWNQxf+QYggBt7g5uXzsH7GRocDyZGbMMdWlB22JX/a1cW3
G5YfQIb0/yOtIXr5nj6K5fJ2L7H1zDkA+4m1nDF1qrTWQ2hvoG1uuhtgPLggzPGX
r4eXYk2PKpHK2n4uHph4r/7LSnxrae11s7dLoRao0lTJHn5OT1ov7ebeVJcDzuAS
Q7owX/kCgYEAzOCHq/4l4Yb3dC00M2gr3JoJ7hD2wyV5iAkRbTxT49fMgVEfhjvJ
DpK6wVSCKM6sbhbT9kxeEzD9nxzNp2wE3AuZToDf+BDLmhZSSUCkX/4KCbJow+bR
eg/wJ2YkiMxFu81mbbBySJxe9Sjvf4e25lnyTYqDz4lvMVzY3rGXqasCgYEAy9Sq
ZPn8Irin37uUq4aM6TvWX4Ws2cJQFt+HhGL6O04kgyWbuETrN/BE8qywc7HrD/zl
CTWokiHzELU41pNYJ7rO8SDYkL0l4VglWVM/yEMLbWkmbFvwTfvZkS5j8n2P0WHU
pr0zc6LDsyTdJmecWpQitinqKFFflsoTMxkhhCMCgYAppj+OhHUY+wIVORdSmAvK
pfn8zrALjfO95vIG/euj9vvZEi/Rbxf5gXS71r07JIDDRJrEiFPbnOsCTK22Kmx2
e1koL2TYnjl10rHZuG1yIkfSHtXTdXoCUXkl2Ur2EGjgu+nlxKgHANsBBdhiWamh
/IkYoF8ZcrwLEe/4navSTwKBgDnEph5EM09r4jgoo7QRSDJ6AQHFkv2McsJoy7Gb
k6vnM7XvnLiW38tUz1Wv17qSfDplxEvd506zTH45vkgiLmPkL+5rDrXGxcud/cfZ
LkSFq+FwYbFoRSz06e6ZpT3+lBoVjf1Lth9Zy/kjw4G0771EKqpSKskOdvb3goWC
49rdAoGAYfQlIVFoienSYcTpy9yKRHbYU5an7KtB3qiT2mfKYYaVU5K8xBx5qpSG
AJ7IYA0cppq0WXgvo96uumjWKMr8FnbzKn9W7DpTLmE0p6O2onct/g4auqAC7oZu
zHjegkYPDAY/3x8hqqYf6wQlehkhuM8Q5YOqGlXj3HUy4utg2tk=
-----END RSA PRIVATE KEY-----
END

#删除伪装站点
if [ -d /usr/share/nginx/html ];then
if [ -e /usr/share/nginx/html/.user.ini ];then
chattr -i /usr/share/nginx/html/.user.ini
rm -rf /usr/share/nginx/html
else
rm -rf /usr/share/nginx/html
fi
fi

#删除旧证书
if [ -d /www/server/panel/vhost/cert/*com ];then
rm -rf /www/server/panel/vhost/cert/*com
elif [ -d /www/server/panel/vhost/cert/*top ];then
rm -rf /www/server/panel/vhost/cert/*top
elif [ -d /www/server/panel/vhost/cert/*bio ];then
rm -rf /www/server/panel/vhost/cert/*bio
else
rm -rf /www/server/panel/vhost/cert/*ink
fi

#删除旧的nginx配置文件
if [ -e /www/server/panel/vhost/nginx/*com.conf ];then
rm -rf /www/server/panel/vhost/nginx/*com.conf
elif [ -e /www/server/panel/vhost/nginx/*top.conf ];then
rm -rf /www/server/panel/vhost/nginx/*top.conf
elif [ -e /www/server/panel/vhost/nginx/*bio.conf ];then
rm -rf /www/server/panel/vhost/nginx/*bio.conf
else
rm -rf /www/server/panel/vhost/nginx/*ink.conf
fi

#创建宝塔面板证书目录
mkdir -p /www/server/panel/vhost/cert/$myStr
cp $myStr.crt /www/server/panel/vhost/cert/$myStr/fullchain.pem
cp $myStr.key /www/server/panel/vhost/cert/$myStr/privkey.pem

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

#创建脚本快捷方式
cd /usr/local/sbin
if [ -e /usr/local/sbin/ssl ];then
     rm -rf /usr/local/sbin/ssl
     ln -s /root/SSL-CERT/ssl-install.sh ssl
else
     ln -s /root/SSL-CERT/ssl-install.sh ssl
fi
green txt "快捷方式已创建，可执行[ssl]重新打开脚本"
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
