# XForwarder
برای انتقال ترافیک (تانل) دستور زیر را روی سرور اول خود که قصد دارید به سرور دوم تانل شود اجرا کنید
`
bash <(curl -Ls https://raw.githubusercontent.com/xpanel-cp/port-forwarder/main/xforwarder.sh --ipv4)
`
به راحتی می توانید با Iptables ترافیک خود را تانل کنید به سرور دوم.
عزیزانی که از XPANEL پروتکل های Singbox  استفاده میکنند با اجرای دستور بالا در سرور اول و انتخاب عدد 2 به راحتی می توانید ترافیک کلیه پورت ها را به سرور دوم و اصلی خود منتقل کنید.
Tuic = UDP,TCP
Hysteria2 = UDP,TCP


