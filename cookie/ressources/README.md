En inspectant les cookie du navigateur, on peux voir I_am_admin=68934a3e9455fa72420237eb05902327
Cela correspond a la string "false" en MD5 Hash

Il suffit d'utiliser un generateur de MD5 Hash pour lui demander la valeur pour la string true.
https://www.md5hashgenerator.com/
On peux ensuite remplacer la valeur dans le cookie, et nous serons donc considerer comme admin du site.
Mettre dans la console du navigateur -> document.cookie = 'I_am_admin=b326b5062b2f0e69046810717534cb09'
Refresh la page pour voir le flag apparaitre


Solution
Il faut utiliser une autre methode d'encryption, comme par exemple un JWT (Json Web Token) avec une secret key.
Le Jwt est generer a partir des informations utilisateurs et de la secret key.
Chaque requete envoyer au backend, comme celle pour recuperer les informations du header, passent ce JWT a la requete.
Le backend le decrypte, et recupere les informations utilisateur.
C'est lui qui reponds donc au client si le user est admin ou pas.
 
