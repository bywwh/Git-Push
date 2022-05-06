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
green read "请输入邮箱(Email)："
echo
yellow txt "$myStr"
git config --global user.email "$myStr"
green read "请输入用户名(Username)："
echo
yellow txt "$myStr"   
git config --global user.name "$myStr"

#设置密钥
green key "请输入Github密钥(Personal access tokens)："
echo
yellow txt "$key"
green repo "请输入仓库名(Project)："
echo
yellow txt "$repo"
git remote set-url origin https://"$key"@github.com/"$myStr"/"$repo"
green txt "设置完毕！"
echo
touch done.log
cat> done.log <<END
Key setting succeeded!
END

}

compack2() {
#上传代码
git add -A
green read "请输入提交记录(Git commit)："
echo
yellow txt "$myStr"
git commit -m "$myStr"
green read "请输入仓库分支(Branch)："
echo
yellow txt "$myStr"
git push origin "$myStr"

}

#判断是否已设置密钥
if [ -e done.log ]; then
      compack2
else
      compack1
      compack2
fi
