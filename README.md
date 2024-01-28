## 1 script.sh

В самом начале требуется ввести в скрипте в переменну TOKEN1 свой токен от digitalocean
Скрипт обращается по API к digitalocean.com, находит id ключа REBRAIN.SSH.PUB.KEY и выводит JSON строку, которая содержит ID ключа.

## 2 resources.tf

При помощи провайдера External Data Source передаем id ключа в resource "digitalocean_droplet" "web" 
