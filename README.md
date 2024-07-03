<p align="center">
	<a href="./README-EN.md">
	English
	</a>
	/
	<a href="./README-RU.md">
	Russian
	</a>
	/
	<a href="./README.md">
	فارسی
	</a>
</p>

# XForwarder
برای انتقال ترافیک (تانل) دستور زیر را روی سرور اول خود که قصد دارید به سرور دوم تانل شود اجرا کنید <br>
```
bash <(curl -Ls https://raw.githubusercontent.com/xpanel-cp/port-forwarder/main/xforwarder.sh --ipv4)
```
<br>

به راحتی می توانید با Iptables ترافیک خود را تانل کنید به سرور دوم.<br>
عزیزانی که از XPANEL پروتکل های Singbox  استفاده میکنند با اجرای دستور بالا در سرور اول و انتخاب عدد 2 به راحتی می توانید ترافیک کلیه پورت ها را به سرور دوم و اصلی خود منتقل کنید.<br>
Tuic = UDP,TCP<br>
Hysteria2 = UDP,TCP<br>


