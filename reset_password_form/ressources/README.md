Sur la page de reset password, l'input email est hidden et a une valeur par default.
On peux donc modifier cette valeur directement via l'inspecteur et submit avec notre email pour changer le mot de passe.

Solution
Il faut envoyer la valeur au serveur, et c'est lui qui se charge de verifier si la valeur de l'input (ici l'email) correspond bien a un compte utilisateur au niveau de la database avant d'envoyer le mail.