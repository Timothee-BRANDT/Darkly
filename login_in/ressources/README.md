On peux spam les requetes de login, il n'y a pas de protection qui nous empeche de spam.
On peux donc facilement brutforce le mot de passe.
username: admin
password: shadow

Solution
Ne surtout pas mettre de choses generiques comme admin en username.
Il faut limiter le nombre de requetes par login.
Exemple : Si le user tbrandt est a sa 4eme tentative de login failed, mettre un timer qui l'empeche de continuer.
Incrementer le timer pour chaque echec.
