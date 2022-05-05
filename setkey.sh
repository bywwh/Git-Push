#!/bin/bash

#定义字体颜色
#绿色
green() {
if [ "$1" == "read" ];then
      color= echo -e "\033[32m$2\033[0m"
      read -r -p "$color" myStr
elif [ "$1" == "txt" ];then
      echo -e "\033[32m$2\033[0m"
elif [ "$1" == "key" ];then
      echo -e "\033[32m$2\033[0m" 
      read -r -p "$color" key
elif [ "$1" == "repo" ];then
      echo -e "\033[32m$2\033[0m" 
      read -r -p "$color" repo      
fi

}

#黄色
yellow() {
if [ "$1" == "txt" ];then
      echo -e "\033[33m$2\033[0m"
fi

}

compack1() {
#设置用户名和邮箱
green txt "-------------------------"
green txt "-     Github上传代码    -"
green txt "-         bywwh         -"
green txt "-------------------------"
green read "请输入邮箱："
echo
yellow txt "$myStr"
git config --global user.email "$myStr"
green read "请输入用户名："
echo
yellow txt "$myStr"   
git config --global user.name "$myStr"

#设置密钥
green key "请输入Github密钥："
echo
yellow txt "$key"
green repo "请输入仓库名："
echo
yellow txt "$repo"
git remote set-url origin https://"$key"@github.com/"$myStr"/"$repo"
green txt "设置完毕！"

}

compack2() {
#上传代码
git add .
green read "请输入提交记录(git commit)："
echo
yellow txt "$myStr"
git commit -m "$myStr"
green read "请输入仓库分支(branch)："
echo
yellow txt "$myStr"
git push origin "$myStr"

}

#询问是否已设置密钥
green read "上传代码前需要设置密钥，你是否已设置过密钥?[y/n]:"
     if [ "$myStr" == "y" ]; then
          compack2
     else
          compack1
          compack2
     fi