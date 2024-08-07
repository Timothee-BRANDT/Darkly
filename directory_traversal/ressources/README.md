https://portswigger.net/web-security/file-path-traversal

Le param ?page= dans l'URL semble ne pas etre proteger par les directory traversal, ce qui pourrais nous permettre d'acceter au fichier /etc/passwd et recuperer des donnees utilisateur.

Le fichier se trouve ici : ?page=../../../../../../../etc/passwd

Solution
Valider l'entrée de l'utilisateur avant de la traiter. Idéalement, comparez l'entrée de l'utilisateur 
avec une liste de valeurs autorisées.
