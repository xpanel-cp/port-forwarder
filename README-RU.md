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
Чтобы проложить туннель трафика (перенаправление портов) с первого сервера на второй, выполните следующую команду на первом сервере:<br>

```
bash <(curl -Ls https://raw.githubusercontent.com/xpanel-cp/port-forwarder/main/xforwarder.sh --ipv4)
```
<br>
Вы можете легко проложить туннель своего трафика на второй сервер с помощью Iptables.<br>
Для тех, кто использует протоколы XPANEL Singbox, вы можете легко перенаправить трафик со всех портов на свой второй и основной сервер, выполнив указанную выше команду на первом сервере и выбрав номер 2.<br>

Tuic = UDP,TCP<br>
Hysteria2 = UDP,TCP<br>
